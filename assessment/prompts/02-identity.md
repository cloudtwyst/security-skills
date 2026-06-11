# Phase 2 — Identity & Access

**Skills triggered:** `entra-id`, `conditional-access-mfa`, `azure-pim`, `entra-id-protection`, `entra-id-governance`, `windows-hello`
**Output:** Identity posture findings, CA gaps, PIM standing access list in `findings.md`

---

## Prompts

### 2.1 — Entra ID foundation

```
Assess the Entra ID configuration for [CLIENT NAME] against the Zero Trust identity
baseline. Their current setup is: [DESCRIBE: cloud-only / hybrid with Entra Connect /
federation, MFA enabled Y/N, passwordless Y/N, break-glass accounts Y/N].
Identify gaps against the recommended baseline and rate each Critical / High / Medium / Low.
```

**What a good response covers:** Hybrid identity model, authentication method policy,
break-glass account hygiene, legacy authentication blocking, illicit consent grant risk.

---

### 2.2 — Conditional Access coverage

```
Review Conditional Access policy coverage for [CLIENT NAME].
They currently have: [LIST EXISTING POLICIES or "no CA policies"].
Using the conditional-access-mfa skill, identify which named CA policy templates
are missing and what risk each gap represents. Produce a gap table.
```

**What a good response covers:** Named Microsoft CA policy templates, MFA registration
policy, sign-in risk policy, device compliance policy, legacy auth block, admin MFA.

---

### 2.3 — PIM and standing access

```
Assess privileged access management for [CLIENT NAME].
Current state: [DESCRIBE: PIM enabled Y/N, standing Global Admin accounts N,
standing Owner at subscription N].
Using the azure-pim skill, identify all standing privileged assignments that should
be converted to eligible/JIT, and recommend the approval workflow for each role tier.
```

**What a good response covers:** Standing vs eligible assignments, JIT activation,
approval workflow, MFA on activation, access reviews, emergency access exclusions.

---

### 2.4 — Identity Protection and governance

```
For [CLIENT NAME], assess Entra ID Protection configuration and identity governance maturity.
Current state: [risky sign-in policy Y/N, risky user policy Y/N, access reviews Y/N,
entitlement management Y/N].
Identify gaps and prioritise remediation.
```

**What a good response covers:** Risk-based CA policies, SSPR, access reviews cadence,
entitlement management packages, lifecycle workflows.

---

## Findings template for this phase

```markdown
## Phase 2 — Identity & Access

| ID | Area | Finding | Severity | Remediation |
|---|---|---|---|---|
| P2-001 | Entra ID | | | |
| P2-002 | Conditional Access | | | |
| P2-003 | PIM | | | |
| P2-004 | Identity Protection | | | |
```
