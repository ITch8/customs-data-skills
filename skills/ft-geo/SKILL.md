---
name: ft-geo
slug: ft-geo
description: "审计外贸独立站的 AI 引用可见性，输出 llms.txt、结构化数据、抓取规则和 P0/P1/P2 清单。用户要做 GEO、写 llms.txt 或让 AI 引用网站时使用。不用于站内 SEO 排名承诺。（本技能原先声明的 present_artifacts 工具依赖已移除：它们由特定宿主平台提供，在通用环境中不可用。）"
version: 1.0.0
tool_dependencies: ["web_search"]
---

# 外贸站 GEO 审计

让独立站更容易被 AI 引擎抓取和引用。方法来自 [ft-geo](https://github.com/Elvinaskill/foreign-trade-suite/tree/main/ft-geo)。本环境没有 `scripts/geo_audit.py` 或 `llms_generate.py`，不要运行它们。用 `web_search` 查看公开页面、`robots.txt`、`llms.txt` 和 sitemap。页面打不开就写未验证，不要编造扫描结果。

不承诺排名，也不处理 Amazon、1688、阿里国际站的站内页面。

## 输入

一个网站 URL。没有 URL 时先问。

## 检查

1. 根目录是否有 `llms.txt`。它应是给 AI 看的索引：品牌一句定位、核心页面、重点产品、关于和证书。过长的宣传文案要改短。`llms-full.txt` 若存在，提醒控制体积。
2. `robots.txt` 是否放行 GPTBot、ClaudeBot、PerplexityBot、Google-Extended、anthropic-ai、Bytespider。被 Disallow 挡住、或 `llms.txt` 被屏蔽，标为 P0。
3. 首页、产品页、关于页是否有与可见文字一致的 JSON-LD。首页用 Organization 和 WebSite；产品页用 Product 和 Offer；文章用 Article；FAQ 用 FAQPage。名称、H1 和 URL 不一致就标为问题，不要建议堆砌无关 schema。
4. 关于页、证书、规格书、真人团队和联系方式是否构成可核对的经验、专业、外部引用和信任信号。没有证据的证书和案例不要写成已有。
5. 内链是否能从分类走到产品。只优化首页要指出来。

## 输出

用中文给出三段清单，每项写明依据 URL：

- P0，7 天内：缺 `llms.txt`、AI 爬虫被拒绝、首页没有 Organization 标记。
- P1，30 天内：产品页 Product/Offer、关于页主体信息、文章作者信息。
- P2，90 天内：更完整的 `llms-full.txt`、主题内链、引用监测。

需要可保存的 `llms.txt` 初稿时，根据已核到的页面来写，品牌定位留给用户改，然后用 `present_artifacts` 交付。自动草稿必须标明待人工审阅。
