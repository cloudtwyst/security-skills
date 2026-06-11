---
name: azure-diagnostics-at-scale
description: "Guidance for deploying Azure diagnostic settings at scale across a landing zone using deployIfNotExists (DINE) Azure Policy — automatically routing resource logs and metrics to a central Log Analytics workspace for SIEM/Sentinel ingestion. Covers the DINE pattern, Azure Monitor Agent (AMA) rollout, log categories, cost tiering, and integration with EPAC pipelines. WHEN: diagnostic settings at scale, DINE diagnostic settings, deployIfNotExists logs, Azure Monitor Agent rollout, route logs to Log Analytics, automatic diagnostics policy, log collection pipeline, AMA deployment policy, Azure Monitor at scale, how do I send all resource logs to Sentinel automatically, configure diagnostic settings with policy, log forwarding landing zone."
license: MIT
metadata:
  author: CloudTwyst
  version: "1.0.0"
---

# Azure Diagnostics at Scale (DINE Pipeline)

The DINE (deployIfNotExists) diagnostic pipeline uses Azure Policy to automatically configure
diagnostic settings on every resource in a landing zone and route their logs to a central Log
Analytics workspace — without requiring workload teams to manually enable logging. It is the
standard log collection mechanism for a SIEM in an EPAC-governed landing zone.

## When to use
Standing up or operating the log collection backbone: ensuring all Azure resources across all
landing zone subscriptions send their diagnostic logs to Sentinel/Log Analytics automatically,
including new resources deployed after the policy is assigned.

## How DINE diagnostics work

A `deployIfNotExists` policy definition:
1. Evaluates whether a resource (e.g. a Key Vault, NSG, or Storage Account) has a diagnostic
   setting pointing to the target Log Analytics workspace.
2. If not, it **deploys** the diagnostic setting automatically using a **managed identity**
   that has Monitoring Contributor rights on the resource.
3. New resources are remediated on creation; existing resources need a one-time **remediation
   task** to back-fill.

## Approach

1. **Central workspace first** — Deploy a single Log Analytics workspace in the Management
   subscription before assigning any DINE policies. All landing zone subscriptions will
   forward to this workspace. See `sentinel` skill for workspace design.

2. **Use the built-in DINE initiative** — Azure provides the built-in initiative
   **"Deploy Diagnostic Settings to Log Analytics workspace for all resource types"**
   (ID: `Deploy Diagnostic Settings to Log Analytics workspace`). Assign this at the
   **Landing Zones** management group scope via EPAC so it inherits to all Corp and Online
   subscriptions automatically.

3. **Parameterise the workspace ID** — Pass the Log Analytics workspace resource ID as a
   policy assignment parameter in your EPAC `policyAssignments/` file. This keeps the
   workspace reference outside the policy definition and portable across environments.

4. **Managed identity and roles** — EPAC's `Deploy-RolesPlan.ps1` must grant the assignment's
   managed identity **Monitoring Contributor** (and **Log Analytics Contributor** if needed)
   at the target scope. Run the roles plan immediately after the policy plan.

5. **Remediate existing resources** — After initial assignment, trigger remediation tasks
   (via `az policy remediation create` or the portal) for each resource type to back-fill
   diagnostic settings on pre-existing resources. Prioritise high-value types: Key Vault,
   NSG flow logs, Azure Firewall, Activity Logs, Entra ID sign-in/audit logs.

6. **Azure Monitor Agent (AMA) for VMs** — For VM-level guest OS logs and security events,
   deploy AMA via the built-in DINE policy `"Configure Windows/Linux machines to run Azure
   Monitor Agent"`. Create a **Data Collection Rule (DCR)** that targets the same workspace
   and scopes which event channels/logs to collect.

7. **Log tiering** — Not all diagnostic logs need the Analytics tier. Route:
   - High-value security logs (sign-ins, Key Vault operations, firewall deny/allow) →
     **Analytics** tier for full KQL querying.
   - High-volume, low-fidelity logs (NSG flow logs, Storage diagnostics) →
     **Auxiliary/Basic** tier to reduce cost.
   Set table-level tier deliberately in the workspace; see `sentinel` skill.

8. **Activity logs** — Enable the **Azure Activity** log diagnostic setting at
   management group scope (not just subscription) to capture control-plane operations
   across all subscriptions into the same workspace.

## EPAC assignment example (JSONC)

```jsonc
{
  "nodeName": "diagnostics-lz",
  "scope": {
    "prod": [ "/providers/Microsoft.Management/managementGroups/landing-zones" ]
  },
  "assignment": {
    "name": "diag-to-sentinel",
    "displayName": "Deploy Diagnostic Settings — Landing Zones",
    "description": "DINE: route all resource diagnostic logs to the central Sentinel workspace."
  },
  "definitionEntry": {
    "initiativeName": "Deploy Diagnostic Settings to Log Analytics workspace"
  },
  "parameters": {
    "logAnalytics": "<workspace-resource-id-from-decisions.md>"
  }
}
```

## Guardrails
- Assign the DINE initiative at **Landing Zones** MG, not Tenant Root — platform subscriptions
  (Connectivity, Identity, Management) may have different retention or workspace targets.
- Always run `Deploy-RolesPlan.ps1` after the policy plan — without the managed identity
  roles, the DINE policy will evaluate but deployments will fail silently with a
  `roleAssignmentMissing` error.
- Don't hard-code the workspace resource ID in policy definitions; always use an assignment
  parameter so the same definition works across `epac-dev` and `prod`.
- Monitor remediation task completion — large estates can have thousands of non-compliant
  resources and tasks time out after 10 minutes per resource.
- Enable NSG flow logs via Network Watcher, not diagnostic settings — they use a different
  mechanism and a separate storage account.

## Example prompts
- `Deploy DINE diagnostic settings across all landing zone subscriptions using EPAC.`
- `How do I ensure all new Azure resources automatically send logs to Sentinel?`
- `Write an EPAC assignment for the built-in diagnostic settings initiative.`
- `How do I grant the managed identity the right roles for DINE remediation?`
- `Remediate existing resources that are missing diagnostic settings.`
- `How do I reduce cost by tiering diagnostic logs between Analytics and Auxiliary?`

## Related skills
- `epac` — pipeline that deploys this DINE assignment across management groups.
- `azure-landing-zone` — management group structure that determines the assignment scope.
- `sentinel` — the Log Analytics workspace receiving the logs; workspace design and cost.
- `azure-policy` — underlying deployIfNotExists effect semantics.

## Microsoft Learn
- Diagnostic settings overview: https://learn.microsoft.com/azure/azure-monitor/essentials/diagnostic-settings
- deployIfNotExists effect: https://learn.microsoft.com/azure/governance/policy/concepts/effects#deployifnotexists
- Azure Monitor Agent: https://learn.microsoft.com/azure/azure-monitor/agents/azure-monitor-agent-overview
- Data Collection Rules: https://learn.microsoft.com/azure/azure-monitor/essentials/data-collection-rule-overview
- Remediation tasks: https://learn.microsoft.com/azure/governance/policy/how-to/remediate-resources
- Log Analytics tiers: https://learn.microsoft.com/azure/azure-monitor/logs/log-analytics-workspace-overview
