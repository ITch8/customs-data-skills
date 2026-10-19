---
name: prospect-qualification
slug: prospect-qualification
description: "Qualify a prospect with explainable fit dimensions, evidence and confidence."
version: 1.1.0
tool_dependencies: []
skill_dependencies: ["icp-architect", "customs-pitfalls"]
---

# Prospect Qualification

Input: ProspectCandidate, ICP, product knowledge and research evidence.

Output: qualification verdict, score, fit dimensions, reasons, positive/negative signals, evidence, missing information and confidence.

Possible verdicts: `qualified`, `possible`, `needs_research`, `rejected`, `existing_relationship`, `suppressed`.

A score without reasons or evidence is invalid. **Qualification never grants send permission.**

## 海关数据线索的评分口径

线索来自海关/提单数据时，本技能按`customs-lead-sop` 的评分卡执行。
评分卡全文见依赖技能 `customs-lead-sop` 的 `references/scorecard.md`。

五个维度，满分 100：

| 维度 | 满分 | 依据 |
|---|---|---|
| Recency 采购新鲜度 | 20 | 近 3 个月 / 6 个月 / 12 个月 / 更久 |
| Frequency 采购频次 | 20 | 近 12 个月出货次数 |
| Product fit 产品匹配 | 20 | 官网/目录交叉验证，**不是舱单关键词命中** |
| Supplier structure 供应商结构 | 20 | 多供应商、近 6 个月新供应商加分 |
| Company fit 公司匹配 | 20 | 渠道、规模、认证、价格带 |

分层：≥80 一对一 · 60–79 常规跟进 · 40–59 培育 · <40 降优先级。

## 三条不可绕过的约束

这些来自依赖技能 `customs-pitfalls`，与上面那句"评分不授予发送许可"是同一条链上的护栏：

1. **无证据的维度必须留空**（`null`），**不得填 0**。
   `null` 表示"没查"，`0` 表示"查了确实是零"。把没证据写成 0 分，
   等于用假数据把一个本该 `needs_research` 的线索压成低分淘汰。

2. **二次线索总分上限 59，且必须标 `evidence_thin`**。
   展会名录、协会会员、LinkedIn、新闻都属于二次线索——
   它们证明公司存在，不证明它买过。分数再高也不该进一对一。

3. **必须区分角色**：Consignee / Notify Party 默认不是终端买家。
   货代、报关行、3PL、仓库要单独打标（`possible_agent_or_3pl`、
   `possible_customs_broker`）；`To Order`、银行、遮蔽收货人
   一律标 `consignee_masked_or_to_order`，**不作为买家评分**。

## 表述纪律

- 「查不到公开记录」只能写成**公开数据不足**，
  不能写成「该公司不进口」——美国公开舱单主要是海运，
  空运、陆运、第三方进口、关联公司都不会出现在那里。
- 金额÷数量是**统计单位价值**，只能用于趋势比较，
  **不是**成交价或竞品报价，不得作为定价基准。
- UN Comtrade 与各国统计**没有公司名**，不得从统计反推买家名单。
- 面向客户的文案不得提及海关数据、提单或任何数据平台，
  必须把关务字段转译成产品/供应链观察。

## 输出要求

每个候选必须附带：`source`（工具名或 `user_export`）、`evidence_window` 时间窗、
各维度分值与理由、正负信号、置信度（`high` / `medium` / `thin`）、`flags` 列表。
缺任一项即本次评分无效。