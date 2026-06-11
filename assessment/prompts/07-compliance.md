# Phase 7 — Compliance & Data Protection

**Skills triggered:** `purview-dlp-policy`, `purview-data-classification`, `purview-audit`, `insider-risk-baseline`, `microsoft-priva`
**Output:** Data protection gaps, DLP coverage, audit trail findings in `findings.md`

---

## Prompts

### 7.1 — Data classification and labeling

```
Assess data classification and sensitivity labeling maturity for [CLIENT NAME].
Current state: [DESCRIBE: sensitivity labels configured Y/N, auto-labeling Y/N,
label taxonomy (list or "none"), SharePoint/Exchange/Teams scoped Y/N].
Using the purview-data-classification skill, identify classification gaps and
recommend a label taxonomy aligned to their data sensitivity profile.
```

**What a good response covers:** Sensitivity label taxonomy, auto-labeling policies,
trainable classifiers, content explorer coverage, label enforcement vs recommendation mode.

---

### 7.2 — DLP policy coverage

```
Assess Microsoft Purview DLP policy coverage for [CLIENT NAME].
Current state: [DESCRIBE: DLP policies deployed Y/N, workloads covered
(Exchange/SharePoint/Teams/Endpoint), simulation mode Y/N, policy tips Y/N,
regulatory requirements (list: GDPR / ASD ISM / PCI-DSS / other)].
Using the purview-dlp-policy skill, identify DLP gaps per workload and
recommend the priority policies to deploy.
```

**What a good response covers:** Per-workload DLP policies, simulation mode first,
SIT (sensitive information types) alignment, endpoint DLP licensing, policy tip
user education, incident management workflow.

---

### 7.3 — Audit trail and eDiscovery readiness

```
Assess audit logging and eDiscovery readiness for [CLIENT NAME].
Current state: [DESCRIBE: Purview Audit (Standard/Premium), audit retention days,
eDiscovery cases used Y/N, audit log search enabled Y/N].
Using the purview-audit skill, identify audit coverage gaps and retention risks
for their regulatory obligations.
```

**What a good response covers:** Audit Standard vs Premium, retention period for
compliance, advanced audit events (mail access, search queries), legal hold readiness.

---

### 7.4 — Insider risk baseline

```
Assess insider risk management readiness for [CLIENT NAME].
Current state: [DESCRIBE: Insider Risk Management enabled Y/N, policies configured Y/N,
HR connector Y/N, communication compliance Y/N].
Using the insider-risk-baseline skill, identify the minimum baseline policies
to deploy and the data sources required.
```

**What a good response covers:** Starter policy templates, HR connector for
leaver signals, sequence indicators, communication compliance pairing,
privacy controls and anonymisation.

---

## Findings template for this phase

```markdown
## Phase 7 — Compliance & Data Protection

| ID | Area | Finding | Severity | Remediation |
|---|---|---|---|---|
| P7-001 | Data classification | | | |
| P7-002 | DLP coverage | | | |
| P7-003 | Audit & eDiscovery | | | |
| P7-004 | Insider risk | | | |
```
