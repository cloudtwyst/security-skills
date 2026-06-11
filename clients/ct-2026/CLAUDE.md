# CLAUDE.md — CloudTwyst Security Assessment 2026

## Engagement context

- **Client:** CloudTwyst
- **Tenant:** cloudtwyst.onmicrosoft.com
- **Engagement type:** CAF-aligned Security Assessment
- **Scope:** Azure landing zone
- **CAF phase:** Ready (landing zone build and governance)
- **Assessment start:** 2026-06-11
- **Lead assessor:** SK

## In-scope subscriptions / management groups

- **Azure management group ID** Tenant Root Group
**Azure management group** 2341d713-edd5-40e8-a222-f610b1b8dc8d



## Known constraints

- No destructive Azure operations during assessment.
- All findings go to `findings.md` with severity (Critical / High / Medium / Low).
- All client decisions and derogations go to `decisions.md` with date.
- Redact tenant IDs, subscription IDs, and IP addresses before sharing outputs.

## Assessment phases

Work through phases in order. Do not skip ahead — each phase informs the next.

| Phase | Topic | Prompt file |
|---|---|---|
| 1 | Scoping & architecture | `prompts/01-scoping.md` |
| 2 | Identity & access | `prompts/02-identity.md` |
| 3 | Landing zone & governance | `prompts/03-landing-zone.md` |
| 4 | Network security | `prompts/04-network.md` |
| 5 | Monitoring & SIEM | `prompts/05-monitoring.md` |
| 6 | Security posture | `prompts/06-posture.md` |
| 7 | Compliance & data protection | `prompts/07-compliance.md` |
| 8 | Remediation & roadmap | `prompts/08-remediation.md` |

## Output

- Findings: `findings.md`
- Decisions: `decisions.md`
- Final report: `reports/cloudtwyst-security-assessment-2026-06.md`
