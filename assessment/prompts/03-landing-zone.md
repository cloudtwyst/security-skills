# Phase 3 — Landing Zone & Governance

**Skills triggered:** `azure-landing-zone`, `epac`, `azure-policy`, `azure-role-selector`
**Output:** MG hierarchy gaps, policy coverage gaps, EPAC maturity rating in `findings.md`

---

## Prompts

### 3.1 — Management group hierarchy review

```
Review the Azure management group hierarchy for [CLIENT NAME] against the CAF landing
zone design. Their current structure is:
[PASTE HIERARCHY or describe: flat / partial / no MGs].
Using the azure-landing-zone skill, identify deviations from the recommended CAF
hierarchy (Platform / Landing Zones / Sandboxes / Decommissioned) and the risk
each deviation introduces.
```

**What a good response covers:** Platform MG with Connectivity/Identity/Management
subscriptions, Corp vs Online archetype separation, Sandboxes isolation, policy
inheritance implications of the current structure.

---

### 3.2 — Azure Policy coverage assessment

```
Assess Azure Policy governance coverage for [CLIENT NAME].
Current state: [DESCRIBE: Azure Security Benchmark assigned Y/N, custom initiatives Y/N,
Deny policies in place Y/N, remediation tasks running Y/N].
Using the azure-policy skill, identify which policy initiatives are missing at which
MG scope and the compliance risk of each gap.
```

**What a good response covers:** Azure Security Benchmark initiative, Deny vs Audit
effects, remediation task hygiene, over-exclusion risk, management group scope.

---

### 3.3 — EPAC maturity assessment

```
Assess the policy-as-code maturity for [CLIENT NAME].
Current state: [DESCRIBE: policies managed in portal / some ARM templates / EPAC pipeline
/ no IaC for policy].
Using the epac skill, rate their EPAC maturity (Ad-hoc / Defined / Managed / Optimised)
and produce a roadmap to reach Managed maturity with a CI/CD pipeline, pacEnvironments,
and GitHub OIDC service principals.
```

**What a good response covers:** pacEnvironment design, EPAC folder structure,
GitHub OIDC vs client secrets, Audit-to-Deny promotion discipline, epac-dev isolation.

---

### 3.4 — Subscription vending and tagging

```
Review subscription provisioning and tagging hygiene for [CLIENT NAME].
Current state: [DESCRIBE: manual portal creation / scripted / Landing Zone Accelerator,
tagging policy Y/N, cost centre tags Y/N].
Identify gaps against the CAF subscription vending pattern and tag policy requirements.
```

**What a good response covers:** Automated vending, mandatory tags (environment,
cost-centre, owner), Policy enforce tagging at creation, MG landing on creation.

---

## Findings template for this phase

```markdown
## Phase 3 — Landing Zone & Governance

| ID | Area | Finding | Severity | Remediation |
|---|---|---|---|---|
| P3-001 | MG Hierarchy | | | |
| P3-002 | Azure Policy | | | |
| P3-003 | EPAC maturity | | | |
| P3-004 | Subscription vending | | | |
```
