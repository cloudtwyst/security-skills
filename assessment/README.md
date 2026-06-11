# CloudTwyst CAF-aligned Security Assessment

A repeatable, skill-driven assessment lifecycle for Microsoft cloud environments.
Each phase fires the relevant CloudTwyst security skills automatically — no manual
skill loading required.

## How to run an assessment

### 1. Set up the engagement folder

```
mkdir clients/[client-name]-[year]
cd clients/[client-name]-[year]
cp ../../assessment/CLAUDE.md.template CLAUDE.md
cp ../../assessment/templates/findings.md findings.md
```

Edit `CLAUDE.md` — fill in client name, tenant, scope, and CAF phase.
This file is read by Claude Code on startup and scopes every response to the engagement.

### 2. Open Claude Code in the engagement folder

```bash
cd clients/[client-name]-[year]
claude
```

Claude Code will read `CLAUDE.md` and the installed security skills are automatically available.

### 3. Work through the phases in order

| Phase | File | Time estimate |
|---|---|---|
| 1 — Scoping & architecture | `assessment/prompts/01-scoping.md` | 1–2 hrs |
| 2 — Identity & access | `assessment/prompts/02-identity.md` | 2–3 hrs |
| 3 — Landing zone & governance | `assessment/prompts/03-landing-zone.md` | 2–3 hrs |
| 4 — Network security | `assessment/prompts/04-network.md` | 1–2 hrs |
| 5 — Monitoring & SIEM | `assessment/prompts/05-monitoring.md` | 1–2 hrs |
| 6 — Security posture | `assessment/prompts/06-posture.md` | 2–3 hrs |
| 7 — Compliance & data | `assessment/prompts/07-compliance.md` | 1–2 hrs |
| 8 — Remediation & roadmap | `assessment/prompts/08-remediation.md` | 2–3 hrs |

For each phase:
1. Open the prompt file
2. Copy each prompt, fill in the `[DESCRIBE: ...]` section with client facts
3. Paste into Claude Code
4. Copy findings into `findings.md`

### 4. Generate the report

When all phases are complete:

1. Copy `assessment/templates/report.md` into `reports/[client]-assessment-[date].md`
2. Paste the Phase 8.4 executive summary output
3. Paste all findings tables
4. Send the Phase 8 remediation roadmap through Claude Code:

```
Generate the final 90-day executive summary for [CLIENT] based on these findings:
[PASTE findings.md]
```

## Skill-to-phase mapping

| Skill | Phases |
|---|---|
| `security-architecture` | 1, 8 |
| `threat-modelling` | 1 |
| `entra-id` | 2 |
| `conditional-access-mfa` | 2 |
| `azure-pim` | 2 |
| `entra-id-protection` | 2 |
| `entra-id-governance` | 2 |
| `azure-landing-zone` | 3, 8 |
| `epac` | 3, 8 |
| `azure-policy` | 3 |
| `azure-network-security-design` | 4 |
| `azure-firewall` | 4 |
| `sentinel` | 5 |
| `azure-diagnostics-at-scale` | 5, 8 |
| `defender-for-cloud-hardening` | 6 |
| `defender-xdr` | 6 |
| `defender-for-endpoint` | 6 |
| `defender-for-identity` | 6 |
| `purview-dlp-policy` | 7 |
| `purview-data-classification` | 7 |
| `purview-audit` | 7 |
| `insider-risk-baseline` | 7 |

## Folder structure per engagement

```
clients/
  contoso-2026/
    CLAUDE.md              # engagement context (from CLAUDE.md.template)
    findings.md            # running findings log (from templates/findings.md)
    decisions.md           # client decisions and derogations
    reports/
      contoso-assessment-2026-06.md   # final report (from templates/report.md)
```
