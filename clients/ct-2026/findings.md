# Security Assessment Findings — CloudTwyst

**Engagement:** CAF-aligned Security Assessment
**Assessor:** SK / CloudTwyst
**Date:** 2026-06-11
**Status:** In progress — Phase 1 complete

---

## Severity definitions

| Severity | Definition |
|---|---|
| **Critical** | Actively exploitable, immediate breach risk or compliance violation |
| **High** | Significant attack surface, exploitable with low effort |
| **Medium** | Control gap that increases risk but requires chaining to exploit |
| **Low** | Defence-in-depth improvement, minimal standalone risk |

---

## Phase 1 — Scoping & Architecture

**Scope:** Azure landing zone, Tenant Root MG `2341d713-edd5-40e8-a222-f610b1b8dc8d`, CAF Ready phase.
**Out of scope:** Endpoints, application-layer DLP, workload-specific controls (no workloads deployed yet).

### Zero Trust pillar coverage

| Pillar | In scope | Primary controls to assess |
|---|---|---|
| Identity | Yes | Entra ID, Conditional Access, PIM, break-glass |
| Infrastructure | Yes | MG hierarchy, Azure Policy, EPAC pipeline |
| Network | Yes | Hub-spoke, NSG, private endpoints, Azure Firewall |
| Data | Yes (platform) | Key Vault, storage security, CMK readiness |
| Apps | Partial | Platform readiness only — no workloads yet |
| Endpoints | No | Out of scope for this engagement |
| Visibility & analytics | Yes | Sentinel, DINE pipeline, Defender for Cloud |

### Phase 1 findings

| ID | Pillar | Finding | Severity | Notes |
|---|---|---|---|---|
| P1-001 | Identity | Standing Global Admin — no PIM, no JIT, no access review | Critical | Primary control plane unprotected |
| P1-002 | Identity | No Conditional Access baseline — phishing-resistant MFA not enforced | High | Spoofing risk at identity boundary |
| P1-003 | Infrastructure | Azure Policy managed in portal — no EPAC pipeline, no change control | High | Tampering risk — no audit trail for policy changes |
| P1-004 | Infrastructure | No diagnostic settings deployed — no audit trail of control-plane operations | High | Repudiation risk across all subscriptions |
| P1-005 | Network | PaaS public network access status unknown — private endpoints not confirmed | Medium | Information disclosure risk |
| P1-006 | Identity | Entra ID sign-in/audit logs not confirmed forwarded to Sentinel | Medium | Repudiation risk for identity events |
| P1-007 | Data | Key Vault security posture unconfirmed — RBAC, purge protection, private endpoint | Medium | Information disclosure / data loss risk |
| P1-008 | Infrastructure | No epac-dev isolation — Deny policy testing environment not confirmed | Medium | DoS risk to legitimate deployments |

### Risk register seed

| Risk ID | Pillar | STRIDE | Likelihood | Impact | Mitigation hypothesis |
|---|---|---|---|---|---|
| R-001 | Identity | Elevation of Privilege | H | H | Remove standing Global Admin; PIM with JIT + approval |
| R-002 | Identity | Spoofing | H | H | CA baseline; phishing-resistant MFA for all admins |
| R-003 | Infrastructure | Tampering | H | H | EPAC pipeline; portal read-only for policy |
| R-004 | Infrastructure | Repudiation | H | M | Sentinel workspace + DINE initiative at Landing Zones MG |
| R-005 | Network | Information disclosure | M | H | Private endpoints on PaaS; disable public access via Policy |
| R-006 | Identity | Repudiation | M | M | Forward Entra ID logs to Sentinel |
| R-007 | Data | Information disclosure | M | H | Key Vault RBAC, purge protection, private endpoint |
| R-008 | Infrastructure | Denial of service | L | H | epac-dev Audit period before any prod Deny promotion |

---

## Phase 2 — Identity & Access

| ID | Area | Finding | Severity | Remediation |
|---|---|---|---|---|
| P2-001 | Entra ID | | | |
| P2-002 | Conditional Access | | | |
| P2-003 | PIM | | | |
| P2-004 | Identity Protection | | | |

---

## Phase 3 — Landing Zone & Governance

| ID | Area | Finding | Severity | Remediation |
|---|---|---|---|---|
| P3-001 | MG Hierarchy | | | |
| P3-002 | Azure Policy | | | |
| P3-003 | EPAC maturity | | | |
| P3-004 | Subscription vending | | | |

---

## Phase 4 — Network Security

| ID | Area | Finding | Severity | Remediation |
|---|---|---|---|---|
| P4-001 | Topology | | | |
| P4-002 | NSG/Segmentation | | | |
| P4-003 | PaaS exposure | | | |
| P4-004 | Egress/Firewall | | | |

---

## Phase 5 — Monitoring & SIEM

| ID | Area | Finding | Severity | Remediation |
|---|---|---|---|---|
| P5-001 | Sentinel workspace | | | |
| P5-002 | DINE pipeline | | | |
| P5-003 | Detection coverage | | | |
| P5-004 | IR automation | | | |

---

## Phase 6 — Security Posture

| ID | Area | Finding | Severity | Remediation |
|---|---|---|---|---|
| P6-001 | Defender for Cloud | | | |
| P6-002 | Endpoint (MDE) | | | |
| P6-003 | Identity (MDI) | | | |
| P6-004 | XDR readiness | | | |

---

## Phase 7 — Compliance & Data Protection

| ID | Area | Finding | Severity | Remediation |
|---|---|---|---|---|
| P7-001 | Data classification | | | |
| P7-002 | DLP coverage | | | |
| P7-003 | Audit & eDiscovery | | | |
| P7-004 | Insider risk | | | |

---

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
