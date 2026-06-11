# Phase 4 — Network Security

**Skills triggered:** `azure-network-security-design`, `azure-firewall`, `api-security-design`
**Output:** Network topology gaps, NSG/firewall findings, private endpoint coverage in `findings.md`

---

## Prompts

### 4.1 — Hub-spoke topology review

```
Review the Azure network topology for [CLIENT NAME] against Zero Trust network principles.
Current state: [DESCRIBE: hub-spoke / flat VNet / Virtual WAN / no VNet segmentation].
Using the azure-network-security-design skill, identify deviations from the recommended
hub-spoke design and the risk each introduces, including egress control and DNS posture.
```

**What a good response covers:** Hub-spoke vs flat design, shared services in hub,
spoke isolation, peering topology, DNS centralisation, DDoS Protection plan.

---

### 4.2 — NSG and segmentation assessment

```
Assess NSG and network segmentation for [CLIENT NAME].
Current state: [DESCRIBE: NSGs at subnet level Y/N, ASGs in use Y/N, default-deny Y/N,
management ports (RDP/SSH) exposed Y/N, Bastion deployed Y/N].
Identify every segmentation gap and rate by exploitability.
```

**What a good response covers:** Subnet-level NSGs, ASG groupings, default-deny posture,
management port exposure, Bastion vs JIT access, microsegmentation of web/app/data tiers.

---

### 4.3 — Private endpoint and PaaS exposure

```
Assess PaaS network exposure for [CLIENT NAME].
Current state: [DESCRIBE: private endpoints in use Y/N, public access disabled on
storage/KV/SQL Y/N, service endpoints vs private endpoints mix].
Using the azure-network-security-design skill, identify all PaaS resources with public
network access enabled and prioritise remediation.
```

**What a good response covers:** Private endpoints vs service endpoints preference,
public access disabled, private DNS zones, Key Vault private endpoint requirement.

---

### 4.4 — Egress control and firewall assessment

```
Review egress control and Azure Firewall configuration for [CLIENT NAME].
Current state: [DESCRIBE: Azure Firewall deployed Y/N, forced tunnelling Y/N,
FQDN rules vs IP allow-lists, threat intelligence mode].
Identify gaps in egress inspection and FQDN-based control.
```

**What a good response covers:** Azure Firewall in hub, FQDN application rules,
threat intelligence alert/deny mode, forced tunnelling from spokes, WAF on
internet-facing apps.

---

## Findings template for this phase

```markdown
## Phase 4 — Network Security

| ID | Area | Finding | Severity | Remediation |
|---|---|---|---|---|
| P4-001 | Topology | | | |
| P4-002 | NSG/Segmentation | | | |
| P4-003 | PaaS exposure | | | |
| P4-004 | Egress/Firewall | | | |
```
