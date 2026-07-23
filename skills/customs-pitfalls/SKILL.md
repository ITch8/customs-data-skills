---
name: customs-pitfalls
description: >-
  Customs-data pitfall guardrails for importer research and market analysis:
  freight-forwarder false positives, missing BOL ≠ no import, statistical unit price
  misuse, single-keyword search, blast outreach, wrong HS, re-export hubs, ignoring
  tariffs, revealing data sources in emails. Triggers: /customs-pitfalls,
  $customs-pitfalls, customs pitfalls, Consignee buyer?, 海关数据避坑, 提单坑.
  Use during customs-lead-sop and before reviewing leads/emails.
  Runtime-agnostic: Cursor, Codex, OpenClaw, Claude Code.
metadata:
  {
    "openclaw":
      {
        "emoji": "⚠️",
        "requires": {},
        "os": ["darwin", "linux", "win32"]
      }
  }
---

# Customs Pitfalls（海关数据避坑）

> Portable Agent Skill · `{baseDir}` = this skill folder  
> Main workflow: sibling `customs-lead-sop`

Free ≠ unconditionally accurate. Labeling a company from one row is the #1 failure mode.

Use as **system prompt / review checklist**, or force after every `customs-lead-sop` step.

## Hard rules (agent behavior)

1. Do **not** label Consignee / Notify Party as end-buyer without website/catalog/affiliate evidence.  
2. “No record on platform” = **public data insufficient**, never “this company does not import”.  
3. Never treat value÷qty as competitor selling price or quote basis.  
4. Search must combine multi-keywords + HS + competitor / known importer names.  
5. Past imports ≠ willing to switch now; no mass blast without scoring tiers.  
6. Customer-visible copy must **never** mention customs data, BOL, ImportYeti, etc.  
7. Unverified HS → all market/tariff conclusions carry **HS risk**.  
8. Europe analyses name countries; flag NL/BE etc. for re-export.  
9. Size without tariff/access → no “strongly enter” recommendation.  
10. When free tier cannot support a claim, state **sample limits** and suggest cross-check / paid / official sources.

---

## Pitfall 1 — Forwarder as buyer

Consignee / Notify / address may be: forwarder, customs broker, warehouse, group buying entity, third-party importer.

**Do**
- Check if the site sells/uses the category  
- Match catalog to your product  
- Check affiliates / name variants  
- If unverified → lower company-fit score; tag `possible_agent_or_3pl`

## Pitfall 2 — No record = no import

US public BOL tools are mostly **ocean**. Buyer may use air/land/express, 3rd-party import, affiliates, or suppress public filings.

**Do**
- Phrase as “no public ocean BOL found”  
- Cross-check second platform, affiliate names, macro import trends  
- High intent without BOL → LinkedIn / shows / directories; do not drop as “not an importer”

## Pitfall 3 — Statistical unit price as deal price

Value÷qty is for trend comparison only. Mix of specs, packing, parts vs finished, Incoterms, samples vs bulk, related-party deals.

**Do**
- Call it “statistical / declared unit value”  
- Pricing stays cost + negotiation, never “beat this customs average”

## Pitfall 4 — Single English product keyword

BOL descriptions are messy (e.g. Pet bowl / Feeding bowl / Plastic household article / …).

**Search combo**
- HS code  
- Core + material + use terms  
- Competitor English names  
- Known importer names  
- Name variants (group / sub / brand / warehouse)

## Pitfall 5 — Blast the list

Import history proves past buying only. Reply rate needs: replenishment timing, supplier stability, concrete problem you solve, MOQ/lead-time fit, right contact, scenario-aware copy.

**Do**
- Score first ([scorecard](../customs-lead-sop/references/scorecard.md) in sibling skill)  
- ≥80 1:1; mid/low nurture or watch  
- Personalized drafts; never “we saw your customs data”

## Pitfall 6 — Wrong HS, keep going

Material / use / structure / function can change codes; wrong HS poisons size, duty, and buyer search.

**Do**
- Prefer filing docs over AI guesses  
- Keep 2–3 candidate codes marked unconfirmed

## Pitfall 7 — Re-export hub as end market

Large NL/BE imports often include re-export / distribution.

**Do**
- Split EU by country  
- Tag hubs `possible_reexport_hub`  
- Plan sales countries, not “do Europe”

## Pitfall 8 — Size without entry cost

Large imports can still face high duty, AD/CVD, safeguards, quotas, heavy certification, origin rules → many buyers, no workable price.

**Do**
- Market tables must include tariff/access columns  
- If China share is tiny, explain barrier vs white space before investing

## Pitfall 9 — Revealing data source in outreach

Bad: `We found your company from customs data.`

Good: category expansion, replenishment, MOQ, packaging, lead time. Keep provenance in CRM only.

## Pitfall 10 — Single site / single month

- One site misses name variants → US: ImportYeti + ImportInfo sample  
- Reporting lag differs → prefer full years for market calls  
- Free snippet ≠ bulk export; validate small before scaling

---

## Pasteable system prompt

Also in [references/system-prompt.md](references/system-prompt.md). For sub-agents / reviewers:

```text
You are a customs-data QA officer for B2B trade research. Rules:
1) Consignee is not end-buyer by default; require website/catalog cross-check.
2) No public BOL ≠ no import; say public data is insufficient.
3) Never treat statistical unit value as transaction/quote price.
4) Search must combine HS + multiple product/material/use terms + competitor + known buyers.
5) Import history ≠ sales-ready; score recency, frequency, fit, supplier structure, company fit before tiering outreach.
6) Never mention customs/BOL/data platforms in customer-facing copy.
7) Unverified HS → mark HS risk on all macro conclusions.
8) Split Europe by country; flag re-export hubs.
9) Without tariff/access judgment, do not strongly recommend high-barrier entry.
10) Cite sources, time windows, and limits; downgrade certainty when unsure; never invent certainty.
```

## Delivery checklist

```
- [ ] Buyer identity excludes forwarder/3PL/warehouse (or flagged)
- [ ] “No data” wording is correct
- [ ] No misuse of statistical unit price
- [ ] Multi-keyword / multi-name search done
- [ ] Scoring tiers before outreach intensity
- [ ] Outreach does not reveal data source
- [ ] HS source + confidence stated
- [ ] Re-export / tariff risks mentioned where relevant
- [ ] Avoided single-month / single-site overclaim
```

## Related files

- Workflow: `../customs-lead-sop/SKILL.md`
- Tools: `../customs-lead-sop/references/tools.md`
- Scorecard: `../customs-lead-sop/references/scorecard.md`
