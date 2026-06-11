---
name: epac
description: "Guidance for Enterprise Policy as Code (EPAC) — managing Azure Policy definitions, initiatives, assignments, and exemptions as versioned code through a CI/CD pipeline using the open-source EPAC PowerShell module. Covers pacEnvironment design, EPAC folder structure, the plan/deploy workflow, GitHub OIDC federation for service principals, and safe Audit-to-Deny promotion. WHEN: EPAC, Enterprise Policy as Code, policy as code, policy pipeline, Deploy-PolicyPlan, Build-DeploymentPlans, pacEnvironment, EPAC service principal, manage Azure Policy at scale, policy definitions as code, automate policy deployment, governance pipeline, policy CI/CD, how do I manage Azure Policy in git, how do I deploy policy across management groups with a pipeline."
license: MIT
metadata:
  author: CloudTwyst
  version: "1.0.0"
---

# Enterprise Policy as Code (EPAC)

EPAC is the open-source Microsoft PowerShell module that treats Azure Policy — definitions,
initiatives, assignments, and exemptions — as versioned source code deployed through a
repeatable CI/CD pipeline. It is the recommended approach for managing policy at management
group scope across multiple environments.

## When to use
Deploying or operating Azure Policy governance at scale: across multiple subscriptions or
management groups, with change control, environment promotion, and separation of duties between
policy authors and approvers.

## Core concepts

| Concept | Description |
|---|---|
| **pacEnvironment** | A named target (e.g. `epac-dev`, `prod`) mapping to a root management group and a service principal. Each environment gets its own GitHub workflow. |
| **Definitions/** | The source-of-truth folder containing all JSONC policy objects — never edit policy in the portal when using EPAC. |
| **Build-DeploymentPlans.ps1** | Reads `Definitions/` and the live Azure state; produces a plan showing what will be created, modified, or deleted. Equivalent to `terraform plan`. |
| **Deploy-PolicyPlan.ps1** | Applies the plan to Azure. Always run **after** reviewing the plan output. |
| **Roles plan/deploy** | Separate script pair that manages the RBAC role assignments required by `deployIfNotExists` remediation identities. |

## Folder structure

```
Definitions/
  globalSettings.jsonc          # tenant root MG, pacEnvironments, policy defaults
  policyDefinitions/            # custom policy definitions (JSONC, one per file)
  policySetDefinitions/         # custom initiatives
  policyAssignments/            # assignments — tree mirrors management group hierarchy
  policyExemptions/             # time-bound exemptions, scoped to resource/scope
```

## Approach

1. **Bootstrap pacEnvironments** — Define each environment in `globalSettings.jsonc` with its
   `pacOwnerId`, root management group, and service principal object ID. Minimum two: `epac-dev`
   (safe sandbox MG) and `prod`.

2. **Service principals via GitHub OIDC** — Create a dedicated SP per `pacEnvironment`; federate
   it to the GitHub branch/environment (not a client secret). The `prod` SP gets Policy Contributor
   + Owner at the target MG only; the `epac-dev` SP is scoped to the dev MG.

3. **Author in Definitions/** — Export an existing tenant's policy state to seed
   `Definitions/` with `Export-AzPolicyResources`. Commit everything to git; the portal is
   now read-only for policy.

4. **Plan before deploy** — Run `Build-DeploymentPlans.ps1` in CI on every PR. Surface the
   plan as a PR comment or artifact so reviewers see exactly what changes will be deployed.
   Require approval before merge.

5. **Audit → Deny promotion** — Introduce new policy definitions with `Audit` or `AuditIfNotExists`
   effect. Monitor compliance for 2–4 weeks in `epac-dev`, then promote to `Deny` in prod via a
   PR. Never start a new control as `Deny` in prod.

6. **Remediation** — After assigning `deployIfNotExists` or `Modify` policies, run
   `Deploy-RolesPlan.ps1` to grant the managed identity the required roles, then trigger
   remediation tasks in the portal or via `az policy remediation create`.

7. **Exemptions** — Create time-bound exemptions in `policyExemptions/` with an expiry date and
   a justification comment. EPAC will alert when exemptions are near expiry.

## Guardrails
- Never run `Deploy-PolicyPlan.ps1` directly against `prod` — always go through a PR-approved
  pipeline with OIDC; client secrets in pipelines are a supply-chain risk.
- `pacOwnerId` partitions ownership; don't share one EPAC instance with another team's EPAC
  deployment or you will delete each other's assignments.
- Always review the plan diff before deploying — a misconfigured assignment at MG scope can
  break all child subscriptions instantly.
- Keep `epac-dev` pointed at an isolated management group with no production workloads.
- Exemptions must have an expiry and a named owner; open-ended exemptions rot into permanent
  policy holes.

## Example prompts
- `Bootstrap an EPAC repository with pacEnvironments for dev and prod.`
- `How do I federate an EPAC service principal to GitHub Actions without a client secret?`
- `Show me the EPAC folder layout for a multi-environment landing zone.`
- `Generate a GitHub Actions workflow that plans on PR and deploys on merge to main.`
- `How do I promote a policy from Audit to Deny safely using EPAC?`
- `Create an EPAC assignment for the Azure Security Benchmark initiative at management group scope.`

## Related skills
- `azure-policy` — raw policy definition and effect semantics; read before authoring custom definitions.
- `azure-landing-zone` — management group hierarchy that EPAC targets.
- `azure-diagnostics-at-scale` — DINE-based diagnostic settings policies EPAC deploys.
- `sentinel` — the Log Analytics workspace that DINE assignments route logs to.

## Microsoft Learn
- EPAC overview: https://azure.github.io/enterprise-azure-policy-as-code/
- Azure Policy overview: https://learn.microsoft.com/azure/governance/policy/overview
- GitHub OIDC federation: https://learn.microsoft.com/azure/active-directory/workload-identities/workload-identity-federation-create-trust
- Remediation tasks: https://learn.microsoft.com/azure/governance/policy/how-to/remediate-resources
- CAF governance: https://learn.microsoft.com/azure/cloud-adoption-framework/govern/
