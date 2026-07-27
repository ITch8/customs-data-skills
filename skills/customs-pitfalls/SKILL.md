---
name: customs-pitfalls
description: >-
  Customs-data pitfall guardrails for importer research and market analysis:
  forwarder/customs-broker false positives, To Order / AMS confidentiality,
  stats≠buyers, missing BOL ≠ no import, statistical unit price misuse,
  single-keyword search, blast outreach, wrong HS, re-export hubs, ignoring
  tariffs, revealing data sources, translating customs fields into product insight.
  Triggers: /customs-pitfalls, $customs-pitfalls, customs pitfalls,
  Consignee buyer?, To Order, AMS Confidentiality, 海关数据避坑, 提单坑, 清关行.
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
2. Filter or flag **`To Order` / `Bank` / blank-or-masked consignee** — real buyer often hidden.  
3. Distinguish **forwarder** vs **customs broker / 3PL / warehouse** — all may look like importers.  
4. “No record on platform” = **public data insufficient**, never “this company does not import”.  
5. Never treat value÷qty as competitor selling price or quote basis.  
6. Search must combine multi-keywords + HS + competitor / known importer names.  
7. Past imports ≠ willing to switch now; no mass blast without scoring tiers.  
8. Customer-visible copy must **never** mention customs data, BOL, ImportYeti, etc.  
9. Outreach must **translate** customs fields into product / supply-chain observations — never raw shipment facts.  
10. Unverified HS → all market/tariff conclusions carry **HS risk**.  
11. Europe analyses name countries; flag NL/BE etc. for re-export.  
12. Size without tariff/access → no “strongly enter” recommendation.  
13. **UN Comtrade / national stats ≠ buyer list** — macro only; never invent company names from stats.  
14. When free tier / anti-bot / login wall blocks fetch, ask for **manual CSV/Excel export** and continue scoring — do not invent rows.  
15. When free tier cannot support a claim, state **sample limits** and suggest cross-check / paid / official sources.

---

## Pitfall 1 — Forwarder / warehouse / 3PL as buyer

Consignee / Notify / address may be: freight forwarder, warehouse, group-buying entity, third-party importer, or logistics brand.

**Do**
- Check if the site sells/uses the category  
- Match catalog to your product  
- Check affiliates / name variants  
- If unverified → lower company-fit score; tag `possible_agent_or_3pl`

## Pitfall 2 — Customs broker as “importer”

Besides forwarders, many shipments show a **customs broker / clearance house** as consignee or notify. They file entries for clients; they are service providers, not end-buyers.

**Do**
- Spot broker/clearance language in name or site (“customs broker”, “brokerage”, “CHS”, “clearance”)  
- Tag `possible_customs_broker`  
- Try to recover the true account via Notify Party, shipper history, or paid data — do not pitch the broker as a buyer

## Pitfall 3 — `To Order` / Bank / AMS confidentiality

Two high-frequency “empty consignee” traps on US ocean manifests:

1. **Consignee = `To Order`, `To the order of …`, or a bank** — documentary credit / order B/L; true buyer often not on the public face.  
2. **AMS Confidentiality Request** — mid/large brands may suppress importer name on public manifest tools; you see masking, order language, or thin identity.

**Do**
- Do **not** treat `To Order` / Bank rows as scored buyers  
- Tag `consignee_masked_or_to_order` / `possible_ams_confidentiality`  
- Recover via: Notify Party (if a real firm), shipper reverse-lookup of other open shipments, affiliate names, trade-show / directory leads  
- Say “public consignee suppressed”, never “this brand does not import”

## Pitfall 4 — No record = no import

US public BOL tools are mostly **ocean**. Buyer may use air/land/express, 3rd-party import, affiliates, or suppress public filings.

**Do**
- Phrase as “no public ocean BOL found”  
- Cross-check second platform, affiliate names, macro import trends  
- High intent without BOL → LinkedIn / shows / directories; do not drop as “not an importer”

## Pitfall 5 — Statistical unit price as deal price

Value÷qty is for trend comparison only. Mix of specs, packing, parts vs finished, Incoterms, samples vs bulk, related-party deals.

**Do**
- Call it “statistical / declared unit value”  
- Pricing stays cost + negotiation, never “beat this customs average”

## Pitfall 6 — Stats database used as buyer source

**UN Comtrade**, China Customs stats, Eurostat, CIMT, USITC DataWeb = country / HS / value / qty. They **never** return importer legal names.

**Do**
- Use Type B stats only for market tiers (Step 2)  
- Company hunting needs Type A BOL tools, paid exports, or secondary leads (shows, directories, news)  
- Never pad a “buyer list” from Comtrade

## Pitfall 7 — Single English product keyword

BOL descriptions are messy (e.g. Pet bowl / Feeding bowl / Plastic household article / …).

**Search combo**
- HS code  
- Core + material + use terms  
- Competitor English names  
- Known importer names  
- Name variants (group / sub / brand / warehouse)

## Pitfall 8 — Blast the list

Import history proves past buying only. Reply rate needs: replenishment timing, supplier stability, concrete problem you solve, MOQ/lead-time fit, right contact, scenario-aware copy.

**Do**
- Score first ([scorecard](../customs-lead-sop/references/scorecard.md) in sibling skill)  
- ≥80 1:1; mid/low nurture or watch  
- Personalized drafts; never “we saw your customs data”

## Pitfall 9 — Wrong HS, keep going

Material / use / structure / function can change codes; wrong HS poisons size, duty, and buyer search.

**Do**
- Prefer filing docs over AI guesses  
- Keep 2–3 candidate codes marked unconfirmed

## Pitfall 10 — Re-export hub as end market

Large NL/BE imports often include re-export / distribution.

**Do**
- Split EU by country  
- Tag hubs `possible_reexport_hub`  
- Plan sales countries, not “do Europe”

## Pitfall 11 — Size without entry cost

Large imports can still face high duty, AD/CVD, safeguards, quotas, heavy certification, origin rules → many buyers, no workable price.

**Do**
- Market tables must include tariff/access columns  
- If China share is tiny, explain barrier vs white space before investing

## Pitfall 12 — Revealing data source (and failing to translate)

Bad: `We found your company from customs data.` / naming platforms / citing container counts from a named shipper.

Also bad: silence that could have been a **product insight**. Customs fields are raw; outreach needs translation.

| Customs field (internal) | Customer-facing translation |
|---|---|
| Product description / material on BOL | Category / SKU observation (“stainless dual-bowl line…”) |
| Recent replenishment cadence | Timing (“for your next replenishment cycle…”) |
| Multi-supplier pattern | Value prop (flexibility, backup capacity, MOQ) — **without** naming their suppliers |
| Port / origin mix | Capability match (packaging, lead time, compliance) — not “we saw your LA arrivals” |

**Rule:** never invent specs you did not see; never expose the surveillance path; always turn evidence into buyer benefit.

## Pitfall 13 — Single site / single month / crawl wall

- One site misses name variants → US: ImportYeti + ImportInfo sample  
- Reporting lag differs → prefer full years for market calls  
- Free snippet ≠ bulk export; validate small before scaling  
- Agent browser hit by Cloudflare / login wall → **stop inventing**; ask user for CSV/Excel from their tool or paid platform, then resume clean → score → draft

---

## Pasteable system prompt

Also in [references/system-prompt.md](references/system-prompt.md). For sub-agents / reviewers:

```text
You are a customs-data QA officer for B2B trade research. Rules:
1) Consignee is not end-buyer by default; require website/catalog cross-check.
2) Filter To Order / Bank / masked consignee; tag possible AMS confidentiality; do not score as buyers.
3) Flag freight forwarders AND customs brokers / 3PL / warehouses separately when suspected.
4) No public BOL ≠ no import; say public data is insufficient.
5) Never treat statistical unit value as transaction/quote price.
6) UN Comtrade and national stats have no company names — never invent buyers from them.
7) Search must combine HS + multiple product/material/use terms + competitor + known buyers.
8) Import history ≠ sales-ready; score before tiering outreach.
9) Never mention customs/BOL/data platforms in customer-facing copy; translate fields into product/supply-chain insight instead.
10) Unverified HS → mark HS risk on all macro conclusions.
11) Split Europe by country; flag re-export hubs.
12) Without tariff/access judgment, do not strongly recommend high-barrier entry.
13) On anti-bot / login wall, request manual CSV/Excel and continue — never fabricate rows.
14) Cite sources, time windows, and limits; downgrade certainty when unsure; never invent certainty.
```

## Delivery checklist

```
- [ ] Buyer identity excludes forwarder / broker / 3PL / warehouse (or flagged)
- [ ] To Order / Bank / masked consignee filtered or flagged
- [ ] “No data” wording is correct
- [ ] Stats tools not used as company lists
- [ ] No misuse of statistical unit price
- [ ] Multi-keyword / multi-name search done
- [ ] Scoring tiers before outreach intensity
- [ ] Outreach does not reveal data source
- [ ] Outreach translates customs evidence → product/supply insight
- [ ] HS source + confidence stated
- [ ] Re-export / tariff risks mentioned where relevant
- [ ] Avoided single-month / single-site overclaim
- [ ] Crawl failures handled via user CSV/Excel (no invented rows)
```

## Related files

- Workflow: `../customs-lead-sop/SKILL.md`
- Tools: `../customs-lead-sop/references/tools.md`
- Scorecard: `../customs-lead-sop/references/scorecard.md`
