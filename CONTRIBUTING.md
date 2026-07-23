# Contributing

Thanks for helping keep these skills accurate and portable.

## Principles

1. **Runtime-agnostic** — avoid hardcoding `.cursor/skills/` paths; use relative links and `{baseDir}`.
2. **Evidence over volume** — prefer scoring + caveats over longer unverified lists.
3. **Public sources only** — no instructions to bypass logins or scrape private data.
4. **Keep SKILL.md lean** — put long tool tables in `references/`.

## Edit where?

Canonical files live under `skills/`. After changing them:

- Update `AGENTS.md` if behavior rules change
- Re-run `install.ps1` / `install.sh` in your local runtimes to test
- If this package sits inside `onemore-search`, refresh Cursor thin wrappers under `.cursor/skills/customs-*`

## Skill checklist

- [ ] Frontmatter has `name` + `description` (EN triggers + 中文 triggers)
- [ ] OpenClaw `metadata.openclaw` still valid JSON object
- [ ] Codex `agents/openai.yaml` default_prompt still makes sense
- [ ] Cross-links between the two skills remain relative
- [ ] No secrets, no private company data in examples

## Suggesting new country tools

Add to `skills/customs-lead-sop/references/tools.md` with: URL, free scope, best use, main pitfall, one concrete action.
