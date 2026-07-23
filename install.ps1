#Requires -Version 5.1
<#
.SYNOPSIS
  Install customs-data-skills into Cursor / Codex / OpenClaw / Agents skill roots.

.EXAMPLE
  .\install.ps1
  .\install.ps1 -Targets cursor,codex,openclaw
  .\install.ps1 -Targets all -Global
#>
param(
  [ValidateSet("cursor", "codex", "openclaw", "agents", "all")]
  [string[]]$Targets = @("all"),
  [switch]$Global,
  [string]$RepoRoot = "",
  [switch]$WriteAgentsHint
)

$ErrorActionPreference = "Stop"
$PackageRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillsSrc = Join-Path $PackageRoot "skills"

if (-not (Test-Path (Join-Path $SkillsSrc "customs-lead-sop\SKILL.md"))) {
  throw "Cannot find skills under $SkillsSrc"
}

if ($Targets -contains "all") {
  $Targets = @("cursor", "codex", "openclaw", "agents")
}

function Resolve-Destinations {
  param([string]$Target)
  $list = @()
  switch ($Target) {
    "cursor" {
      if ($RepoRoot) {
        $list += (Join-Path $RepoRoot ".cursor\skills")
      } else {
        # Prefer parent monorepo if present; else cwd
        $parent = Split-Path -Parent $PackageRoot
        $cursorSkills = Join-Path $parent ".cursor\skills"
        if (Test-Path (Join-Path $parent ".cursor")) {
          $list += $cursorSkills
        } else {
          $list += (Join-Path (Get-Location) ".cursor\skills")
        }
      }
    }
    "codex" {
      if ($Global -or -not $RepoRoot) {
        $list += (Join-Path $HOME ".codex\skills")
      }
      if ($RepoRoot) {
        $list += (Join-Path $RepoRoot ".codex\skills")
      } elseif (Test-Path (Join-Path (Get-Location) ".git")) {
        $list += (Join-Path (Get-Location) ".codex\skills")
      }
    }
    "openclaw" {
      if ($Global -or -not $RepoRoot) {
        $list += (Join-Path $HOME ".openclaw\skills")
      }
      if ($RepoRoot) {
        $list += (Join-Path $RepoRoot "skills")
        $list += (Join-Path $RepoRoot ".agents\skills")
      } else {
        $cwd = Get-Location
        $list += (Join-Path $cwd "skills")
      }
    }
    "agents" {
      if ($Global -or -not $RepoRoot) {
        $list += (Join-Path $HOME ".agents\skills")
      }
      if ($RepoRoot) {
        $list += (Join-Path $RepoRoot ".agents\skills")
      }
    }
  }
  return $list | Select-Object -Unique
}

function Install-SkillTree {
  param([string]$DestRoot)
  New-Item -ItemType Directory -Force -Path $DestRoot | Out-Null
  foreach ($name in @("customs-lead-sop", "customs-pitfalls")) {
    $src = Join-Path $SkillsSrc $name
    $dst = Join-Path $DestRoot $name
    if (Test-Path $dst) {
      Remove-Item -Recurse -Force $dst
    }
    Copy-Item -Recurse -Force $src $dst
    Write-Host "  + $dst"
  }
}

Write-Host "Installing customs-data-skills from: $PackageRoot"
foreach ($t in $Targets) {
  Write-Host "`n[$t]"
  foreach ($dest in (Resolve-Destinations -Target $t)) {
    Install-SkillTree -DestRoot $dest
  }
}

# Optional: copy AGENTS.md hint into repo root
$agentsSrc = Join-Path $PackageRoot "AGENTS.md"
if ($WriteAgentsHint -and $RepoRoot -and (Test-Path $agentsSrc)) {
  $hint = Join-Path $RepoRoot "AGENTS.customs-data.md"
  Copy-Item -Force $agentsSrc $hint
  Write-Host "`nWrote agent manual hint: $hint (merge into AGENTS.md if desired)"
}

Write-Host "`nDone. Invoke: /customs-lead-sop  or  `$customs-lead-sop  (+ customs-pitfalls)"
