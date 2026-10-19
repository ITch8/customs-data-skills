---
name: trade-follow-up
slug: trade-follow-up
description: "为已有外贸客户准备下一次跟进草稿。用户要跟进已读不回、报价后沉默、高价值未下单或流失客户时使用。不会发送邮件。"
version: 1.0.0
tool_dependencies: ["trade_list_today", "trade_request_outreach_approval"]
---

# 客户跟进

先用 `trade_list_today` 看未关闭的询盘和待审批草稿。只处理用户点名的一家，或今日列表里最靠前的一家。不要一次给多家各写一封。

## 选定原因

每封草稿只属于一种原因：

- 已读不回：对方看过但没有回复。
- 报价后沉默：按收到报价后的节奏。第 1 次确认是否收到；第 3 次补细节、包装或检测；第 7 次补交期或适销规格；第 14 次问项目是否继续。日期不清楚时先问上次报价是哪一天。
- 高价值未下单：需求清楚但仍未决定。草稿要给一个新的选择，而不是催下单。
- 流失：大约 30 天没有回复。只在用户确认仍值得联系时起草，并说明这次和上次有什么不同。
- 逾期未付：订金或尾款已过约定日期。原因分成运费、仍在谈价格，或其他。没有约定日期就先问。

## 草稿

没有新信息就停止，不要调用工具。新信息是这次才提供的细节、规格选择、交期或付款说明，不能是「有没有更新」。

用 `trade_request_outreach_approval` 保存。`gate_type` 用 follow_up，`stall` 必填，`follow_reason` 用 read_no_reply、quote_day_1、quote_day_3、quote_day_7、quote_day_14、high_value_open、lapsed 或 overdue_payment，`fresh_info` 写这次新增的信息。没有新信息就不要调用工具，空的 fresh_info 会被拒绝。带上这家客户的 `account_id`。正文先写「本次新信息：」，再写给买方的信。成功后告诉用户它在待审批里，不要说已经发出。
