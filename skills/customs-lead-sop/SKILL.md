---
name: customs-lead-sop
description: >-
  Customs-data B2B lead SOP: verify HS codes, prioritize markets with trade stats,
  find real importers from bills of lading (esp. US) or secondary leads where BOL
  is not public, score buyers, translate evidence into outreach drafts. Supports
  manual CSV/Excel handoff when scraping hits login/anti-bot walls.
  Triggers: /customs-lead-sop, $customs-lead-sop, customs data, ImportYeti,
  UK Trade Info, Comtrade, bill of lading, find importers, 海关数据找客户, 提单反查.
  Pair with customs-pitfalls for QA. Runtime-agnostic: Cursor, Codex, OpenClaw, Claude Code.
metadata:
  {
    "openclaw":
      {
        "emoji": "📦",
        "requires": {},
        "os": ["darwin", "linux", "win32"]
      }
  }
---

# Customs Lead SOP（海关数据开发客户）

> Portable Agent Skill · `{baseDir}` = this skill folder  
> Companion QA skill: sibling `customs-pitfalls` (same `skills/` parent)

## Goal

Answer three questions with public trade data:

1. Which markets are buying? *(Type B — national / HS stats)*  
2. Which companies have actually imported? *(Type A — firm-level BOL, or secondary leads where A is closed)*  
3. Is there a supply-chain entry window now?

Customs data is a **lead signal**, not a closed deal. Conversion still depends on research, contacts, value prop, and follow-up.

**Before every delivery**, run the checklist in sibling skill `customs-pitfalls`.

## Runtime notes

| Runtime | How to invoke |
|---|---|
| Cursor | `/customs-lead-sop` or natural language triggers |
| Codex | `$customs-lead-sop` or description match; see `agents/openai.yaml` |
| OpenClaw | Slash / skill discover; install this folder or parent `skills/` |
| Claude Code / others | Load this `SKILL.md` + sibling `customs-pitfalls` |

Tools (any available): web search, web fetch, browser, read local CSV/Excel. No paid API required for the methodology.

## Data types (pick before querying)

| Type | What you see | Use for | Not for |
|---|---|---|---|
| **A. Bill / buyer-level** | Importer, shipper, dates, product text, ports | Reverse-engineer competitors' buyers; cadence & supplier mix | Treating every Consignee as end-buyer; full air/land coverage |
| **B. National trade stats** | Country, HS, value, qty, trends | Market size, growth, China share, priority | **Any company name / email** — Comtrade has **zero** buyers |
| **C. Tariff / access** | MFN / bound rates, limits, quotas | Post-entry price competitiveness | Contact lists |

**Hard split:** Step 2 uses **B**; Step 4 needs **A** (or paid A export / secondary leads). Never invent firm names from B.

Tool map: [references/tools.md](references/tools.md)

## Workflow (execute in order)

```
Task Progress:
- [ ] 0. Collect inputs (+ optional CSV/Excel exports)
- [ ] 1. Confirm HS / HTS / CN codes
- [ ] 2. Rank markets with Type B stats (Priority / Opportunity / Caution)
- [ ] 3. Check tariff barriers
- [ ] 4. Find real buyers (Type A where public; else secondary leads / user export)
- [ ] 5. Score & tier buyers
- [ ] 6. Find contacts + translate evidence into outreach drafts
- [ ] 7. Write report to disk
- [ ] 8. QA with customs-pitfalls
```

### Step 0 — Inputs

| Field | Required | Notes |
|---|---|---|
| `product_name` | yes | EN + ZH if available |
| `hs_codes` | preferred | Verified codes; else produce candidates marked unconfirmed |
| `target_markets` | yes | e.g. US / UK / CA / EU members |
| `competitor_names` | no | English legal names for reverse lookup |
| `known_buyers` | no | Existing accounts to diligence |
| `buyer_types` | no | Brand / wholesale / retail chain / ecommerce / dropship / general importer |
| `target_buyer_count` | no | Default 20 |
| `bol_export_files` | no | User-provided CSV/Excel from ImportYeti / paid platforms / in-house export |
| `output_dir` | no | Default `./hunt_result/` under current workspace |

### Step 1 — HS codes

Do **not** treat AI-guessed codes from Chinese names as final.

Prefer (in order): historical export declarations → customer clearance docs → forwarder/broker records → comparable filed shipments → destination official tariff lookup.

Output: `hs_codes[]` + `confidence` (`confirmed` \| `candidate`) + `source`.  
If unconfirmed, tag later market/tariff analysis with **HS risk**.

### Step 2 — Market priority (Type B only)

Use stats tools (China Customs, UN Comtrade, USITC DataWeb, Eurostat Comext, Canada CIMT).

Compare: import value, 3y growth, imports from China, China share, monthly seasonality, rough unit value.

| Tier | Rule of thumb |
|---|---|
| **Priority** | Large + growing + China supply competitive |
| **Opportunity** | Fast growth but low China share (explain tariff/cert vs white space) |
| **Caution** | Declining, high duty/barriers, or re-export hub mistaken for end market |

Split Europe by country. NL/BE hub imports ≠ end consumption.  
**Comtrade output stops here** — it never feeds Step 4 company rows.

### Step 3 — Tariffs

WTO Tariff & Trade Data: MFN Applied / Bound, etc. Put size and duty in one table before recommending entry.

Order-level truth = latest national tariff + FTAs + AD/CVD + broker advice. This step is screening only.

### Step 4 — Real buyers

#### 4a — Where public firm-level ocean BOL is usable

| Market | Primary | Secondary |
|---|---|---|
| US | ImportYeti (ocean manifest) | ImportInfo cross-check; user CSV export if crawl blocked |

US reverse lookup:
1. Competitor English name → importers with ≥2 shipments in last 12 months  
2. Or diligence known accounts: continuity, origin countries, supplier concentration, product fit, arrivals in last 6 months  
3. Cross-check: address, name variants, affiliates, product text  
4. Drop / flag: `To Order`, Bank, masked consignee, forwarder, customs broker (see `customs-pitfalls`)

#### 4b — UK / EU / most markets without public firm BOL

Due to privacy regimes (e.g. GDPR), **most UK/EU official sources no longer publish US-style shipment-level consignee manifests**. Do **not** treat UK Trade Info (or similar) as ImportYeti-for-Europe.

For these markets:
1. Finish Step 2–3 ranking with Type B stats  
2. Build company pool via **secondary leads**: trade shows / exhibitor lists, industry directories, LinkedIn, association members, news of openings/expansions, optional sibling B2B skills  
3. If the user has a **paid customs platform** covering that market, ask for export CSV/Excel and run 4c  
4. Label evidence as `secondary_lead` or `paid_export`, never fake “BOL confirmed”

A few jurisdictions historically publish more open firm-level trade data (coverage changes — verify before claiming). Prefer stating limits over guessing.

#### 4c — Manual export handoff (anti-bot / login / paid tools)

When browser/fetch hits Cloudflare, login walls, captchas, or free-tier caps:

1. Stop scraping; **do not invent buyers**  
2. Ask the user to export CSV/Excel from ImportYeti / paid library / internal dump  
3. Accept `bol_export_files` (or pasted tables) → parse → dedupe → filter pitfalls → score → draft  
4. Note in the report: `source=user_export` + filename + row count + date

This path is the **preferred production path** for teams that already pay for customs software: Skill owns cleaning, scoring, and drafts; the platform owns raw data.

### Step 5 — Score buyers

Full rubric: [references/scorecard.md](references/scorecard.md)

| Dimension | Max |
|---|---|
| Recency | 20 |
| Frequency | 20 |
| Product fit | 20 |
| Supplier structure (multi / shifting preferred) | 20 |
| Company fit (channel, scale, MOQ, certs, price band) | 20 |

Tiers: **≥80** 1:1 focus · **60–79** normal follow-up · **40–59** nurture · **&lt;40** deprioritize

Secondary leads without shipment proof: cap confidence; do not invent frequency/recency scores from thin air — mark `evidence_thin`.

### Step 6 — Contacts & outreach (translate, don’t expose)

Customs data answers “who buys”, not “who to email”. Roles: Purchasing / Buyer / Sourcing / Category / Supply Chain / Product Manager / Owner / MD.

Hard rules:
- Never write: “We found you from customs data / bill of lading / ImportYeti…”  
- Never cite container counts, named Chinese shippers, or BOL IDs in customer copy  
- **Translate** internal fields → product / replenishment / capability observations (see pitfalls Pitfall 12)  
- Keep provenance in CRM / report only

Angle by buyer type: see [examples/pet-products.md](examples/pet-products.md)

### Step 7 — Report output

Write under `output_dir` (default `./hunt_result/`).

Filename: `customs-YY-MM-DD-{slug}.md` (append `-2` on same-day collision). Optional `.jsonl` / `.csv` of scored buyers.

```markdown
# Customs Lead SOP — {product} / {markets}

## 1. HS codes
## 2. Market tiers + key metrics (Type B sources)
## 3. Tariff / access summary
## 4. Buyer list (source type A/export/secondary, evidence, score, tier, flags)
## 5. Outreach order + translated angles
## 6. Draft emails (optional, high tier only)
## 7. Risks & data limits (customs-pitfalls)
## 8. Next three actions
```

Each buyer needs: `source_tools` or `source=user_export` + time window + product/HS evidence + supplier-structure signal if any + flags (`possible_agent_or_3pl`, `possible_customs_broker`, `consignee_masked_or_to_order`, `possible_reexport_hub`, `hs_risk`, `evidence_thin`, …).

## Optional handoffs

If these skills exist in the host workspace, you may chain them after scoring:

| Stage | Skill (optional) |
|---|---|
| Fill company pool (non-BOL markets) | `b2b-search` / `b2b-trade-show-hunter` |
| Contacts / emails | `b2b-linkedin-outreach` / `b2b-lead-extract` |
| Email drafts | `b2b-email-craft` |
| Negotiation | `b2b-sales-negotiation` |
| QA (required) | `customs-pitfalls` |

## Compliance

- Public trade/BOL/stats + public web only (plus user-owned exports they already have rights to use)  
- **Drafts only** — never auto-send email  
- No fake “official customs buyer list” claims  
- Free tiers are sample-limited; anti-bot is normal — hand off to CSV rather than bypass walls  
- Do not instruct bypassing login walls or captchas

## Minimum start pack (same day)

1. Confirm one accurate HS from filing docs  
2. Compare three target countries on UN Comtrade (**macro only**)  
3. US: score ~20 recent buyers from ImportYeti/ImportInfo **or** user CSV; other markets: secondary leads + clear “no public BOL” caveat  
