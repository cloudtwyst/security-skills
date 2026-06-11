# Phase 1 — Scoping & Architecture Review

**Skills triggered:** `security-architecture`, `threat-modelling`
**Output:** Scope statement, architecture diagram gaps, threat surface summary in `findings.md`

---

## How to use

Paste each prompt into Claude Code in order. After each response, copy the relevant
findings into `findings.md` under `## Phase 1 — Scoping`.

---

## Prompts

### 1.1 — Zero Trust architecture scope

```
We are conducting a CAF-aligned security assessment for [CLIENT NAME].
Their environment covers [SCOPE: Azure landing zone / M365 / Hybrid].
Using the security-architecture skill, define the Zero Trust review scope across
the six pillars (identity, endpoints, data, apps, infrastructure, network) and
identify which pillars are in scope for this engagement.
```

**What a good response covers:** Six Zero Trust pillars mapped to client environment,
explicit in-scope vs out-of-scope boundaries, reference to MCRA and CAF Secure methodology.

---

### 1.2 — Threat surface enumeration

```
For [CLIENT NAME]'s environment, run a STRIDE threat model scoped to their cloud
boundary. Identify the key trust boundaries, data flows, and the top five threat
categories relevant to their Azure + M365 footprint. Flag which STRIDE categories
represent the highest risk given their CAF phase.
```

**What a good response covers:** DFD trust boundaries, STRIDE categories applied to
cloud, prioritised threat list with mitigations, iterative re-model note.

---

### 1.3 — Assessment risk register seed

```
Based on the Zero Trust scope and STRIDE threat surface for [CLIENT NAME],
produce a risk register seed table with columns: Risk ID, Pillar, STRIDE category,
Likelihood (H/M/L), Impact (H/M/L), Initial mitigation hypothesis.
Format as a Markdown table. This will be refined as each phase completes.
```

**What a good response covers:** Structured table, pillar-aligned risks, STRIDE mapping,
clear hypotheses that can be confirmed or refuted in later phases.

---

## Findings template for this phase

Append to `findings.md`:

```markdown
## Phase 1 — Scoping & Architecture

| ID | Pillar | Finding | Severity | Notes |
|---|---|---|---|---|
| P1-001 | | | | |
```
