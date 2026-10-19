---
name: trade-buyer-check
slug: trade-buyer-check
description: "为外贸客户做公开信息背调，并写入客户档案。用户要核验买家身份、采购角色或风险时使用。不用于国际站信用分或付费海关数据。"
version: 1.0.0
tool_dependencies: ["web_search", "trade_create_account", "trade_list_today"]
---

# 客户背调

把一家公司收成可核对的背调，再决定要不要建档。检索只用 `web_search`。没有 URL 的判断写成假设。

## 输入

公司名，以及邮箱、官网或国家里已有的任一项。都没有时先问，不要用名字猜一家公司。

## 记录

先查今日列表，避免重复建档。新客户用 `trade_create_account`。有官网或页面时传入 `channel_role`（importer、distributor、brand）、`evidence_text` 和 `evidence_url`。知道企业邮箱时传入 `email`。返回 `duplicate` 时打开已有的 `account_id`，没有 `account_id` 就说明全公司已有案卷、当前部门看不到，不要再建。没有 URL 的判断不要放进工具，写在回复的假设里。筛查只给带链接的证据加分。回复结构固定为：

- 公司：名称、国家、官网。
- 渠道角色：进口商、分销商或品牌商。对不上就写未知。
- 证据：每条包含事实和 URL。官网、关于页、产品页优先。
- 风险：付款方式异常、主体对不上、找不到公司页面。没有风险就写未发现。
- 假设：没有 URL 的推断单独列出。
- 下一步：补证据、可以触达，或停止。

不要把背调说成已经筛查通过。阶段仍由业务接口决定。不要起草开发信，除非用户接着要求，并且那时改走待审批草稿。
