# Phase 6 — Security Posture

**Skills triggered:** `defender-for-cloud-hardening`, `defender-xdr`, `defender-for-endpoint`, `defender-for-identity`, `azure-security-benchmark`
**Output:** Secure Score baseline, attack surface findings, EDR coverage gaps in `findings.md`

---

## Prompts

### 6.1 — Defender for Cloud posture

```
Assess Microsoft Defender for Cloud configuration for [CLIENT NAME].
Current state: [DESCRIBE: CSPM tier (Free/Defender CSPM), Defender plans enabled
(list), current Secure Score %, attack path analysis enabled Y/N,
multicloud connectors Y/N].
Using the defender-for-cloud-hardening skill, identify the highest-impact
hardening recommendations for their environment.
```

**What a good response covers:** Defender CSPM vs Free tier, Defender plans per
resource type, Secure Score as directional (not target), attack path analysis,
regulatory compliance dashboards, workload-specific recommendations.

---

### 6.2 — Endpoint protection coverage

```
Assess endpoint protection coverage for [CLIENT NAME].
Current state: [DESCRIBE: Defender for Endpoint onboarded devices N, OS mix
(Windows/macOS/Linux), MDE plan (P1/P2), attack surface reduction rules Y/N,
tamper protection Y/N].
Using the defender-for-endpoint skill, identify EDR coverage gaps and
attack surface reduction opportunities.
```

**What a good response covers:** Onboarding completeness, ASR rules baseline,
tamper protection, threat and vulnerability management, EDR in block mode,
automated investigation and remediation.

---

### 6.3 — Identity threat detection (Defender for Identity)

```
Assess identity threat detection for [CLIENT NAME].
Current state: [DESCRIBE: Defender for Identity deployed Y/N, AD DS sensors
installed Y/N, Entra ID connector Y/N, lateral movement alerts reviewed Y/N].
Using the defender-for-identity skill, identify detection gaps for Active
Directory and Entra ID-based attacks.
```

**What a good response covers:** Sensor deployment on DCs, Entra ID signals,
lateral movement detection, DCSync/Pass-the-Hash/Golden Ticket detection,
integration with Defender XDR incident queue.

---

### 6.4 — XDR incident response readiness

```
Assess Microsoft Defender XDR configuration and incident response readiness
for [CLIENT NAME].
Current state: [DESCRIBE: workloads onboarded to XDR (list), unified RBAC Y/N,
automatic attack disruption Y/N, AIR enabled Y/N].
Identify XDR gaps and the top three controls to enable next.
```

**What a good response covers:** All four workloads onboarded (Endpoint, Identity,
Office 365, Cloud Apps), unified RBAC before broad enablement, automatic attack
disruption scope and exclusions, AIR for analyst load reduction.

---

## Findings template for this phase

```markdown
## Phase 6 — Security Posture

| ID | Area | Finding | Severity | Remediation |
|---|---|---|---|---|
| P6-001 | Defender for Cloud | | | |
| P6-002 | Endpoint (MDE) | | | |
| P6-003 | Identity (MDI) | | | |
| P6-004 | XDR readiness | | | |
```
