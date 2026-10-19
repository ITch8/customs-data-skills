---
name: foreign-trade-research
slug: foreign-trade-research
description: "对目标国家和产品做外贸市场调研，覆盖品牌商、制造商和经销商，给出竞争格局、定价、渠道和进入建议。用户要海外市场分析或竞品调研时使用。（本技能原先声明的 present_artifacts 工具依赖已移除：它们由特定宿主平台提供，在通用环境中不可用。）"
version: 1.0.0
tool_dependencies: ["web_search"]
---

# 外贸市场调研

对「目标国家 + 产品」做可追溯的竞争调研。方法来自 [foreign-trade-research](https://github.com/liangdabiao/exa-research-mcp-skill/tree/main/.agents/skills/foreign-trade-research)。检索使用 `web_search`，不要调用 Exa 或其他未注册的搜索工具。

## 输入

- 目标国家
- 产品领域
- 深度：快速了解、标准调研、全面深度。用户没说时按标准调研做，不要先追问。

## 证据规则

- 公司、价格、份额和网址必须来自 `web_search` 命中的页面。
- 没有 URL 的判断写成「假设」，不要写成事实。
- 搜不到的数字留空，并写明缺口。不要估算份额却假装有来源。
- 报告默认中文。英语市场的公司名和术语保留英文。

## 五步

互不依赖的检索可以并行。复杂子问题时，用 `subagent_start` 派发给 `research-explorer`，再用 `subagent_await` 收回结果。

### 1. 竞争格局

列出该市场的活跃公司，分成三类：

- 本土品牌商，最多 7 家
- 制造商（含在当地有工厂的国际制造商），最多 7 家
- 经销商、批发商、进口商，最多 6 家

每家写：公司全称、成立时间、总部、官网、市场地位。缺的字段标「未检索到」。

查询用英语，并换 2–3 种说法。例如产品是 solar panels、国家是 Thailand：

- `Thailand solar panels leading companies manufacturers brands`
- `top solar panel companies Thailand distributors`
- `Thailand solar energy industry importers wholesalers`

快速了解每类少列几家；全面深度才把每类写满。

### 2. 逐家拆解

对上一步列出的公司分别看：背景、该产品线、价格带、客户和渠道、优势与弱点。每条结论后面附来源 URL。

### 3. 对比矩阵

用表格对比：公司、角色、产品线、价格带、客户、优势、弱点。然后回答：

1. 格局更接近垄断、寡头还是分散？
2. 谁是主要对手？
3. 有哪些需求没被满足？
4. 中国供应商可以从哪里切入？

### 4. 交叉核对

对关键价格、官网和评价再搜一次。优先官网、当地 B2B 平台和公开评价页。对不上的数字降级为假设。

### 5. 成稿

不要把检索原文拼在一起。结构如下：

1. 执行摘要：3–5 条发现，并给市场机会判断
2. 市场概述：趋势、驱动因素、挑战、格局
3. 品牌商
4. 制造商
5. 经销商
6. 竞争分析：价格、渠道、技术
7. 进入建议：切入点、产品定位、定价、渠道
8. 风险与证据缺口

用户要求文件时，用 `present_artifacts` 交付。文件名用「目标国_产品_市场调研报告」。
