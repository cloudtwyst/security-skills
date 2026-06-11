# Phase 8 — Remediation & Roadmap

**Skills triggered:** `epac`, `azure-landing-zone`, `azure-diagnostics-at-scale`, `security-architecture`
**Output:** Prioritised remediation roadmap, EPAC pipeline design, 90-day plan in `findings.md`

---

## Prompts

### 8.1 — Consolidated findings prioritisation

```
We have completed a CAF-aligned security assessment for [CLIENT NAME].
Here are all findings from Phases 1-7:

[PASTE consolidated findings table from findings.md]

Using the security-architecture skill, prioritise these findings into three
remediation waves:
- Wave 1 (0-30 days): Critical and High — stop the bleeding
- Wave 2 (30-90 days): Medium — reduce attack surface
- Wave 3 (90+ days): Low + strategic improvements

For each finding, assign an owner (Identity / Network / Platform / SecOps / Compliance).
```

**What a good response covers:** Risk-based prioritisation, dependency ordering
(identity before network before posture), owner assignment, quick wins vs strategic.

---

### 8.2 — EPAC governance pipeline design

```
For [CLIENT NAME], design an EPAC governance pipeline that enforces the top five
policy-based remediations identified in the assessment.
Their current state: [DESCRIBE: MG hierarchy from Phase 3, existing policy coverage,
GitHub/ADO pipeline availability].
Using the epac skill, produce:
1. The pacEnvironment definition for dev and prod
2. The policyAssignments/ structure targeting the correct MG scopes
3. The GitHub Actions workflow outline (plan on PR, deploy on merge)
4. The service principal OIDC federation requirements
```

**What a good response covers:** pacEnvironment per environment, OIDC vs client
secrets, plan diff on PR, Deploy-RolesPlan for managed identities, Audit-first
rollout for new Deny policies.

---

### 8.3 — DINE log pipeline remediation plan

```
For [CLIENT NAME], produce a step-by-step remediation plan to close the
diagnostic settings gaps identified in Phase 5.
Using the azure-diagnostics-at-scale skill, produce:
1. The EPAC policyAssignments entry for the built-in DINE initiative
2. The ordered remediation task list by resource type priority
3. The log tiering recommendation (Analytics vs Auxiliary) for each type
4. The AMA + DCR design for VM guest log collection
```

**What a good response covers:** Assignment at Landing Zones MG, workspace
parameter, Deploy-RolesPlan execution order, remediation task batching,
Analytics vs Auxiliary tier decision per resource type.

---

### 8.4 — 90-day executive summary

```
Based on the completed assessment for [CLIENT NAME], produce a 90-day
executive summary with:
1. Current security posture rating (1-5 scale per Zero Trust pillar)
2. Top three critical risks requiring immediate action
3. The 90-day roadmap table (Wave 1/2/3)
4. Expected posture improvement after Wave 1 completion
5. Recommended next engagement (e.g. implementation sprint, re-assessment date)

Format as a Markdown section suitable for inclusion in the client report.
```

**What a good response covers:** Per-pillar maturity rating, risk narrative for
executives (not technical), measurable outcomes, clear next steps, re-assessment
recommendation.

---

## Findings template for this phase

```markdown
## Phase 8 — Remediation Roadmap

### Wave 1 — 0 to 30 days (Critical / High)

| ID | Finding | Owner | Effort | Skill |
|---|---|---|---|---|
| | | | | |

### Wave 2 — 30 to 90 days (Medium)

| ID | Finding | Owner | Effort | Skill |
|---|---|---|---|---|
| | | | | |

### Wave 3 — 90+ days (Strategic)

| ID | Finding | Owner | Effort | Skill |
|---|---|---|---|---|
| | | | | |
```
