---
name: azure-landing-zone
description: "Guidance for designing and deploying an Azure landing zone aligned to the Microsoft Cloud Adoption Framework (CAF) — management group hierarchy, platform and application landing zone subscriptions, subscription vending, hub-spoke connectivity, and governance guardrails. WHEN: Azure landing zone, CAF landing zone, management group hierarchy, subscription vending, landing zone accelerator, platform landing zone, application landing zone, connectivity subscription, identity subscription, management subscription, landing zone design, hub spoke landing zone, Azure foundation, enterprise Azure setup, how do I structure my Azure tenant, how do I set up management groups."
license: MIT
metadata:
  author: CloudTwyst
  version: "1.0.0"
---

# Azure Landing Zone (CAF)

An Azure landing zone is a repeatable, governance-first environment design that separates
platform concerns (connectivity, identity, management) from workload concerns (application
landing zones). It is the recommended foundation before deploying production workloads and
the target architecture for EPAC-governed tenants.

## When to use
Designing the Azure tenant structure, management group hierarchy, or subscription topology for
a new organisation or a governance uplift of an existing tenant.

## Management group hierarchy

```
Tenant Root Group
└── Platform
│   ├── Connectivity         (hub VNets, firewalls, gateways, DNS)
│   ├── Identity             (AD DS DCs, Entra Connect, PKI)
│   └── Management           (Log Analytics, Automation, Defender for Cloud)
└── Landing Zones
│   ├── Corp                 (workloads with private connectivity to hub)
│   └── Online               (internet-facing workloads, no hub peering)
└── Sandboxes                (dev/test with no connectivity to corp network)
└── Decommissioned           (subscriptions pending removal)
```

Each management group level inherits policy assignments from its parent, so governance
guardrails set at **Landing Zones** apply automatically to all Corp and Online subscriptions.

## Platform subscriptions

| Subscription | Purpose | Key resources |
|---|---|---|
| **Connectivity** | Hub networking | Azure Firewall, VPN/ExpressRoute GW, DNS resolver, DDoS plan |
| **Identity** | Hybrid identity | AD DS domain controllers, Entra Connect sync server |
| **Management** | Centralised operations | Log Analytics workspace, Automation Account, Defender for Cloud |

## Approach

1. **Management groups first** — Create the hierarchy before any subscriptions. Policy
   assignments inherit downward; getting the structure right is cheaper now than restructuring
   later. Align to the CAF hierarchy above; deviate only with documented justification.

2. **Platform subscriptions** — Deploy Connectivity, Identity, and Management subscriptions
   under the Platform MG. These are shared services — keep them tightly governed and
   limit who can modify them.

3. **Governance layer (EPAC)** — Assign Azure Policy initiatives at management group scope
   before landing zone subscriptions are handed to workload teams. Use EPAC to deploy the
   Azure Security Benchmark and any org-specific baselines. See `epac` skill.

4. **Hub-spoke connectivity** — Deploy the hub VNet in the Connectivity subscription; peer
   spoke VNets in Corp landing zones to the hub. Route all egress through Azure Firewall.
   Online landing zones do not peer to the hub. See `azure-network-security-design` skill.

5. **Subscription vending** — Automate subscription creation and initial policy assignment
   via Bicep + GitHub Actions (or the Azure Landing Zone Accelerator). Each vended
   subscription lands in the correct MG, gets the baseline tags, and is linked to a
   billing account. No manual portal clicks.

6. **Identity boundary** — Apply Entra ID Conditional Access, PIM, and break-glass accounts
   before granting workload teams access. Never grant standing Owner at subscription scope.

7. **Monitoring foundation** — Deploy a central Log Analytics workspace in the Management
   subscription. Use DINE policy (via EPAC) to route diagnostic logs from all landing zone
   subscriptions to this workspace automatically. See `azure-diagnostics-at-scale` skill.

## Landing zone archetypes

| Archetype | MG | Connectivity | Typical workloads |
|---|---|---|---|
| **Corp** | Landing Zones/Corp | Hub peered, private endpoints | Internal apps, databases, ERP |
| **Online** | Landing Zones/Online | Direct internet, WAF/Front Door | Public APIs, SaaS front-ends |
| **Sandbox** | Sandboxes | Isolated, no corp peering | Dev experiments, PoC |

## Guardrails
- Never deploy production workloads in platform subscriptions — they become a blast-radius
  problem and complicate governance.
- The Tenant Root Group should have minimal direct assignments; prefer targeting Landing Zones
  MG and below so platform subscriptions can have different guardrails.
- Each subscription should have a single workload team as owner — shared subscriptions
  collapse accountability.
- Tag every subscription with environment, cost-centre, and workload-owner at creation;
  retrofitting tags is painful and compliance reports are unreliable without them.

## Example prompts
- `Design a CAF-aligned management group hierarchy for a 200-subscription tenant.`
- `What goes in the Connectivity vs Management platform subscription?`
- `How do I automate subscription vending into the correct landing zone archetype?`
- `Apply governance guardrails to the Landing Zones management group before onboarding workload teams.`
- `What is the difference between Corp and Online landing zone archetypes?`

## Related skills
- `epac` — deploy policy governance across the MG hierarchy.
- `azure-network-security-design` — hub-spoke connectivity inside the landing zone.
- `azure-diagnostics-at-scale` — DINE pipeline routing logs from all subscriptions to central workspace.
- `entra-id` — identity foundation required before workload teams get access.
- `azure-policy` — raw policy definition semantics.

## Microsoft Learn
- Landing zone overview: https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/
- Management group hierarchy: https://learn.microsoft.com/azure/governance/management-groups/overview
- CAF subscription design: https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-subscriptions
- Azure Landing Zone Accelerator: https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/implementation-options
- Subscription vending: https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending
