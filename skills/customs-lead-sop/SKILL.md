---
name: customs-lead-sop
description: >-
  Customs-data B2B lead SOP: verify HS codes, prioritize markets, find real importers
  from bills of lading / trader registries, score buyers, then draft personalized outreach.
  Triggers: /customs-lead-sop, $customs-lead-sop, customs data, ImportYeti, UK Trade Info,
  Comtrade, bill of lading, find importers, 海关数据找客户, 提单反查.
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

1. Which markets are buying?
2. Which companies have actually imported?
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

Tools (any available): web search, web fetch, browser. No paid API required for the methodology.

## Data types (pick before querying)

| Type | What you see | Use for | Not for |
|---|---|---|---|
| **A. Bill / buyer-level** | Importer, shipper, dates, product text, ports | Reverse-engineer competitors' buyers; real importers; cadence & supplier mix | Full air/land/express coverage |
| **B. National trade stats** | Country, value, qty, trends | Market size, growth, China share, priority | Buyer emails |
| **C. Tariff / access** | MFN / bound rates, limits, quotas | Post-entry price competitiveness | Contact lists |

Tool map: [references/tools.md](references/tools.md)

## Workflow (execute in order)

```
Task Progress:
- [ ] 0. Collect inputs
- [ ] 1. Confirm HS / HTS / CN codes
- [ ] 2. Rank markets (Priority / Opportunity / Caution)
- [ ] 3. Check tariff barriers
- [ ] 4. Find real buyers (market-specific tools)
- [ ] 5. Score & tier buyers
- [ ] 6. Find contacts + personalized outreach drafts
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
| `output_dir` | no | Default `./hunt_result/` under current workspace |

### Step 1 — HS codes

Do **not** treat AI-guessed codes from Chinese names as final.

Prefer (in order): historical export declarations → customer clearance docs → forwarder/broker records → comparable filed shipments → destination official tariff lookup.

Output: `hs_codes[]` + `confidence` (`confirmed` \| `candidate`) + `source`.  
If unconfirmed, tag later market/tariff analysis with **HS risk**.

### Step 2 — Market priority

Use stats tools (China Customs, UN Comtrade, USITC DataWeb, Eurostat Comext, Canada CIMT).

Compare: import value, 3y growth, imports from China, China share, monthly seasonality, rough unit value.

| Tier | Rule of thumb |
|---|---|
| **Priority** | Large + growing + China supply competitive |
| **Opportunity** | Fast growth but low China share (explain tariff/cert vs white space) |
| **Caution** | Declining, high duty/barriers, or re-export hub mistaken for end market |

Split Europe by country. NL/BE hub imports ≠ end consumption.

### Step 3 — Tariffs

WTO Tariff & Trade Data: MFN Applied / Bound, etc. Put size and duty in one table before recommending entry.

Order-level truth = latest national tariff + FTAs + AD/CVD + broker advice. This step is screening only.

### Step 4 — Real buyers

| Market | Primary | Secondary |
|---|---|---|
| US | ImportYeti | ImportInfo cross-check |
| UK | UK Trade Info | Google / LinkedIn for contacts |
| Other | Lock market via stats | Google, LinkedIn, associations, trade shows, B2B directories |

US reverse lookup:
1. Competitor English name → importers with ≥2 shipments in last 12 months
2. Or diligence known accounts: continuity, origin countries, supplier concentration, product fit, arrivals in last 6 months
3. Cross-check: address, name variants, affiliates, product text

UK: code/description → import → time window → firm + address → website catalog. Order: recent repeat related trade > traded ~1y ago > website only.

Markets without public firm-level data: finish market ranking, then broaden via search / trade shows / directories (optional sibling B2B skills if present).

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

### Step 6 — Contacts & outreach

Customs data answers “who buys”, not “who to email”. Roles: Purchasing / Buyer / Sourcing / Category / Supply Chain / Product Manager / Owner / MD.

Hard rules:
- Never write: “We found you from customs data / bill of lading…”
- Write business value: category expansion, replenishment cycle, MOQ, packaging, lead time
- Keep data provenance internal

Angle by buyer type: see [examples/pet-products.md](examples/pet-products.md)

### Step 7 — Report output

Write under `output_dir` (default `./hunt_result/`).

Filename: `customs-YY-MM-DD-{slug}.md` (append `-2` on same-day collision). Optional `.jsonl` / `.csv` of scored buyers.

```markdown
# Customs Lead SOP — {product} / {markets}

## 1. HS codes
## 2. Market tiers + key metrics
## 3. Tariff / access summary
## 4. Buyer list (source, evidence, score, tier)
## 5. Outreach order + angles
## 6. Draft emails (optional, high tier only)
## 7. Risks & data limits (customs-pitfalls)
## 8. Next three actions
```

Each buyer needs: source tool + time window + product/HS evidence + supplier-structure signal if any.

## Optional handoffs

If these skills exist in the host workspace, you may chain them after scoring:

| Stage | Skill (optional) |
|---|---|
| Fill company pool | `b2b-search` / `b2b-trade-show-hunter` |
| Contacts / emails | `b2b-linkedin-outreach` / `b2b-lead-extract` |
| Email drafts | `b2b-email-craft` |
| Negotiation | `b2b-sales-negotiation` |
| QA (required) | `customs-pitfalls` |

## Compliance

- Public trade/BOL/stats + public web only
- **Drafts only** — never auto-send email
- No fake “official customs buyer list” claims
- Free tiers are sample-limited: validate small, then scale

## Minimum start pack (same day)

1. Confirm one accurate HS from filing docs  
2. Compare three target countries on UN Comtrade  
3. Score ~20 recent buyers from firm-level tools  
