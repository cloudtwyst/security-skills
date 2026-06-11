# CloudTwyst Security Assessment Report

**Client:** [CLIENT NAME]
**Prepared by:** CloudTwyst
**Assessment type:** CAF-aligned Microsoft Security Assessment
**Report date:** [YYYY-MM-DD]
**Classification:** Confidential

---

## Executive Summary

[PASTE Phase 8.4 executive summary output here]

---

## Security Posture Rating

| Zero Trust Pillar | Current (1–5) | Target (1–5) | Priority |
|---|---|---|---|
| Identity | | | |
| Endpoints | | | |
| Data | | | |
| Applications | | | |
| Infrastructure | | | |
| Network | | | |

**Overall posture:** [1–5] — [Descriptor: Initial / Developing / Defined / Managed / Optimised]

---

## Critical and High Findings

[PASTE Wave 1 findings from findings.md]

---

## Full Findings Register

[PASTE all phase findings tables from findings.md]

---

## Remediation Roadmap

[PASTE Wave 1/2/3 tables from Phase 8 findings]

---

## Recommended Next Steps

1. [Immediate action — e.g. engage CloudTwyst for EPAC implementation sprint]
2. [30-day checkpoint — review Wave 1 completion]
3. [Re-assessment date — e.g. 6 months]

---

## Appendix A — Assessment Methodology

This assessment followed the CloudTwyst CAF-aligned security assessment lifecycle:

| Phase | Scope | Skills used |
|---|---|---|
| 1 — Scoping | Zero Trust architecture, threat surface | `security-architecture`, `threat-modelling` |
| 2 — Identity | Entra ID, CA, PIM, Identity Protection | `entra-id`, `conditional-access-mfa`, `azure-pim` |
| 3 — Landing zone | MG hierarchy, Azure Policy, EPAC | `azure-landing-zone`, `epac`, `azure-policy` |
| 4 — Network | Hub-spoke, NSG, private endpoints, firewall | `azure-network-security-design`, `azure-firewall` |
| 5 — Monitoring | Sentinel, DINE pipeline, detections | `sentinel`, `azure-diagnostics-at-scale` |
| 6 — Posture | Defender for Cloud, MDE, MDI, XDR | `defender-for-cloud-hardening`, `defender-xdr` |
| 7 — Compliance | DLP, classification, audit, insider risk | `purview-dlp-policy`, `purview-data-classification` |
| 8 — Remediation | Roadmap, EPAC pipeline, 90-day plan | `epac`, `security-architecture` |

Guidance in each phase is grounded in public Microsoft Learn documentation
via the CloudTwyst Security Skills Plugin (`github.com/cloudtwyst/security-skills`).

---

## Appendix B — Scope and Limitations

- **In scope:** [List from CLAUDE.md]
- **Out of scope:** [List]
- **Assessment period:** [Date range]
- **Data sources:** [Configuration review / interviews / portal screenshots / none — no automated scanning]
- **Limitations:** This assessment is based on information provided at the time of engagement.
  Posture may change after the assessment date.
