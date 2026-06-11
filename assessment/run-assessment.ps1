# run-assessment.ps1
# Usage: pwsh assessment/run-assessment.ps1 -EngagementPath clients/ct-2026
# Reads CLAUDE.md from the engagement folder, fires all 8 assessment phases
# through Claude Code CLI, and writes output to findings.md automatically.

param(
    [Parameter(Mandatory)]
    [string]$EngagementPath
)

$ErrorActionPreference = "Stop"
$repoRoot = $PSScriptRoot | Split-Path -Parent
$engagementDir = Join-Path $repoRoot $EngagementPath
$claudeMd = Join-Path $engagementDir "CLAUDE.md"
$findingsMd = Join-Path $engagementDir "findings.md"
$promptsDir = Join-Path $PSScriptRoot "prompts"

# Validate
if (-not (Test-Path $claudeMd))  { throw "CLAUDE.md not found at $claudeMd" }
if (-not (Test-Path $findingsMd)) { throw "findings.md not found at $findingsMd" }
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) { throw "claude CLI not found on PATH" }

# Parse client context from CLAUDE.md
$claudeContent = Get-Content $claudeMd -Raw
$client  = if ($claudeContent -match '\*\*Client:\*\*\s*(.+)') { $Matches[1].Trim() } else { "Unknown" }
$tenant  = if ($claudeContent -match '\*\*Tenant:\*\*\s*(.+)') { $Matches[1].Trim() } else { "Unknown" }
$scope   = if ($claudeContent -match '\*\*Scope:\*\*\s*(.+)')  { $Matches[1].Trim() } else { "Unknown" }
$phase   = if ($claudeContent -match '\*\*CAF phase:\*\*\s*(.+)') { $Matches[1].Trim() } else { "Unknown" }
$mgs     = if ($claudeContent -match '(?s)## In-scope subscriptions.*?\n(.*?)##') { $Matches[1].Trim() } else { "Not specified" }

Write-Host ""
Write-Host "CloudTwyst Security Assessment Runner" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Client  : $client"
Write-Host "Tenant  : $tenant"
Write-Host "Scope   : $scope"
Write-Host "CAF     : $phase"
Write-Host "MGs     : $mgs"
Write-Host "Output  : $findingsMd"
Write-Host ""

# Phase definitions: file, title, skills
$phases = @(
    @{ File="01-scoping.md";      Title="Phase 1 — Scoping & Architecture";      Skills="security-architecture, threat-modelling" },
    @{ File="02-identity.md";     Title="Phase 2 — Identity & Access";            Skills="entra-id, conditional-access-mfa, azure-pim, entra-id-protection" },
    @{ File="03-landing-zone.md"; Title="Phase 3 — Landing Zone & Governance";    Skills="azure-landing-zone, epac, azure-policy" },
    @{ File="04-network.md";      Title="Phase 4 — Network Security";             Skills="azure-network-security-design, azure-firewall" },
    @{ File="05-monitoring.md";   Title="Phase 5 — Monitoring & SIEM";            Skills="sentinel, azure-diagnostics-at-scale" },
    @{ File="06-posture.md";      Title="Phase 6 — Security Posture";             Skills="defender-for-cloud-hardening, defender-xdr, defender-for-endpoint" },
    @{ File="07-compliance.md";   Title="Phase 7 — Compliance & Data Protection"; Skills="purview-dlp-policy, purview-data-classification, purview-audit" },
    @{ File="08-remediation.md";  Title="Phase 8 — Remediation & Roadmap";        Skills="epac, security-architecture" }
)

function Invoke-Phase {
    param($PhaseNum, $PhaseTitle, $PromptFile, $Skills)

    Write-Host "Running $PhaseTitle..." -ForegroundColor Yellow

    $promptPath = Join-Path $promptsDir $PromptFile
    $promptTemplate = Get-Content $promptPath -Raw

    # Inject client context into every [DESCRIBE: ...] and [CLIENT NAME] placeholder
    $prompt = $promptTemplate `
        -replace '\[CLIENT NAME\]', $client `
        -replace '\[CLIENT\]', $client `
        -replace '\[SCOPE:.*?\]', $scope `
        -replace '\[DESCRIBE:.*?\]', "See engagement context: client=$client, tenant=$tenant, scope=$scope, CAF phase=$phase, MGs=$mgs" `
        -replace '\[DESCRIBE.*?\]', "See engagement context: client=$client, tenant=$tenant, scope=$scope, CAF phase=$phase, MGs=$mgs"

    # Build the claude prompt: inject engagement context + skills instruction + phase prompts
    $fullPrompt = @"
ENGAGEMENT CONTEXT (from CLAUDE.md):
- Client: $client
- Tenant: $tenant
- Scope: $scope
- CAF phase: $phase
- In-scope management groups: $mgs

INSTRUCTIONS:
You are running $PhaseTitle of a CAF-aligned security assessment.
Use the following skills to ground your responses: $Skills
Work through every prompt in this phase. For each prompt:
1. Provide structured, specific findings for the CloudTwyst environment above.
2. Rate each finding Critical / High / Medium / Low.
3. End with a findings table in this exact Markdown format:
   | ID | Area | Finding | Severity | Remediation |
   |---|---|---|---|---|

PHASE PROMPTS:
$prompt
"@

    # Run through claude CLI with --print flag (non-interactive output)
    $output = $fullPrompt | claude --print 2>&1

    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Phase $PhaseNum returned non-zero exit. Output captured anyway."
    }

    # Append to findings.md
    $section = @"

---

## $PhaseTitle

$output
"@
    Add-Content -Path $findingsMd -Value $section
    Write-Host "  Done — findings written to findings.md" -ForegroundColor Green
}

# Stamp the run
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
Add-Content -Path $findingsMd -Value "`n---`n`n> Assessment run: $timestamp | Runner: run-assessment.ps1`n"

# Run all phases
for ($i = 0; $i -lt $phases.Count; $i++) {
    $p = $phases[$i]
    Invoke-Phase -PhaseNum ($i+1) -PhaseTitle $p.Title -PromptFile $p.File -Skills $p.Skills
}

Write-Host ""
Write-Host "Assessment complete." -ForegroundColor Cyan
Write-Host "Findings: $findingsMd"
Write-Host ""
Write-Host "Next: copy assessment/templates/report.md to $engagementDir/reports/ and paste findings." -ForegroundColor Gray
