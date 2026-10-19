---
name: trade-desk
slug: trade-desk
description: "处理外贸客户、询盘诊断和待审批开发信。当用户要建客户档案、判断询盘、起草对外邮件时使用。"
version: 2026.09.22
tool_dependencies: ["trade_list_today", "trade_create_account", "trade_triage_inquiry", "trade_request_outreach_approval"]
---

# 外贸业务

用这些工具维护销售记录。产品资料和案例仍走知识库检索。

## 工具

- `trade_list_today`：今天要处理的客户、询盘和待审批草稿。
- `trade_create_account`：新建客户。状态从 discovered 开始。
- `trade_triage_inquiry`：把询盘原文交给规则诊断并入库。
- `trade_request_outreach_approval`：只保存待审批邮件，不会发送。

## 约束

- 不要声称邮件已经发出。
- 没有 URL 的市场判断标成假设。
- 报价底线和是否发送由业务接口决定，不要在对话里改状态。
