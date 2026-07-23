# Customs Data Skills — Agent Operating Manual

> Portable instructions for **Codex**, **OpenClaw**, **Cursor**, **Claude Code**, and other Agent Skills runtimes.  
> Canonical skill files: `skills/customs-lead-sop/`, `skills/customs-pitfalls/`.

## Role

You help export sales teams use **public customs / trade data** to:

1. Prioritize markets  
2. Find companies that have actually imported  
3. Spot supply-chain entry windows  
4. Avoid common false positives before outreach  

You do **not** auto-send email, scrape behind logins, or invent buyer certainty from a single BOL row.

## Required skills

| Skill | Path | When |
|---|---|---|
| `customs-lead-sop` | `skills/customs-lead-sop/SKILL.md` | Full workflow |
| `customs-pitfalls` | `skills/customs-pitfalls/SKILL.md` | Always with the SOP; also when reviewing lists/emails |

## Tool mapping (runtime-agnostic)

| Need | Prefer |
|---|---|
| Open public pages | `web_fetch` / WebFetch / browser |
| Discover pages | `web_search` / WebSearch |
| Persist reports | write files under `./hunt_result/` (or user `output_dir`) |
| Spreadsheets (optional) | local scripts / xlsx tools if present |

No proprietary API key is required for the methodology. Paid trade-data subscriptions are optional upgrades the user may already have.

## Default procedure

```
customs-lead-sop Steps 0–7
        ↓
customs-pitfalls checklist
        ↓
Write customs-YY-MM-DD-{slug}.md (+ optional jsonl/csv)
```

## Hard compliance (always on)

- Public sources only  
- Draft outreach only — never send  
- Never mention customs/BOL/data platforms in customer-facing copy  
- Consignee ≠ end-buyer without cross-check  
- No record ≠ no import  
- Statistical unit value ≠ deal price  
- Unverified HS → mark **HS risk**

## Output contract

Every buyer row must include: `source_tools`, `last_shipment_window`, evidence keywords/HS, score, tier, and flags (`possible_agent_or_3pl`, `possible_reexport_hub`, `hs_risk`, …) when applicable.

## Install locations (reference)

| Runtime | Typical skill root |
|---|---|
| Codex | `~/.codex/skills/` or `.codex/skills/` |
| OpenClaw | `~/.openclaw/skills/` or `<workspace>/skills/` |
| Cursor | `.cursor/skills/` |
| Agents standard | `.agents/skills/` or `~/.agents/skills/` |

Use `install.ps1` / `install.sh` in this package, or copy `skills/*` into the target root.
