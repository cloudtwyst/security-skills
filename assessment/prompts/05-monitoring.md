# Phase 5 — Monitoring & SIEM

**Skills triggered:** `sentinel`, `azure-diagnostics-at-scale`, `unified-secops-platform`
**Output:** Log coverage gaps, SIEM design findings, DINE pipeline status in `findings.md`

---

## Prompts

### 5.1 — Sentinel workspace design review

```
Review Microsoft Sentinel workspace design for [CLIENT NAME].
Current state: [DESCRIBE: Sentinel deployed Y/N, single workspace Y/N,
workspace region, data connectors enabled (list), estimated daily ingestion GB].
Using the sentinel skill, identify workspace design gaps, cost optimisation
opportunities, and missing data connectors against the recommended baseline.
```

**What a good response covers:** Single central workspace, region co-location,
Content Hub connector onboarding, Commitment Tier vs PAYG, duplicate ingestion risk,
table-level RBAC vs multiple workspaces.

---

### 5.2 — Diagnostic settings pipeline (DINE) coverage

```
Assess the diagnostic settings pipeline for [CLIENT NAME].
Current state: [DESCRIBE: diagnostic settings configured manually Y/N, DINE policy
assigned Y/N, AMA deployed to VMs Y/N, activity logs forwarded Y/N,
resource types with no diagnostic settings (list if known)].
Using the azure-diagnostics-at-scale skill, identify coverage gaps and produce
a prioritised list of resource types to remediate.
```

**What a good response covers:** DINE policy assignment at Landing Zones MG,
managed identity Monitoring Contributor role, remediation tasks for existing
resources, AMA + DCR for VM guest logs, activity log forwarding at MG scope.

---

### 5.3 — Analytics rules and detection coverage

```
Review Sentinel analytics rule coverage for [CLIENT NAME].
Current state: [DESCRIBE: built-in rules enabled Y/N, custom KQL detections Y/N,
UEBA enabled Y/N, MITRE ATT&CK coverage assessed Y/N].
Identify the highest-priority rule gaps for their threat profile.
```

**What a good response covers:** Built-in scheduled and Microsoft Security rule
templates, entity mapping, UEBA enablement, MITRE ATT&CK matrix gaps, alert
fatigue from untuned rules.

---

### 5.4 — Incident response automation

```
Assess Sentinel automation and incident response readiness for [CLIENT NAME].
Current state: [DESCRIBE: automation rules configured Y/N, playbooks deployed Y/N,
SOAR integrations Y/N, mean time to triage estimate].
Identify automation gaps and recommend the top three playbooks to implement first.
```

**What a good response covers:** Automation rules for triage, Logic Apps playbooks
for enrichment/containment, MITRE ATT&CK mapping, Teams/email notification,
playbook permission model.

---

## Findings template for this phase

```markdown
## Phase 5 — Monitoring & SIEM

| ID | Area | Finding | Severity | Remediation |
|---|---|---|---|---|
| P5-001 | Sentinel workspace | | | |
| P5-002 | DINE pipeline | | | |
| P5-003 | Detection coverage | | | |
| P5-004 | IR automation | | | |
```
