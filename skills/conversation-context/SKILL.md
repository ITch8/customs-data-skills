---
name: conversation-context
slug: conversation-context
description: "跨 Email 与 WhatsApp 的统一客户沟通上下文与 Trade Case 解析。用户要梳理客户沟通历史、把邮件与消息归入同一 Trade Case 时使用。"
version: 1.0.0
tool_dependencies: []
---

# Conversation Context

## 核心对象
Conversation 是 Customer 与企业围绕一个业务主题的连续上下文；Message 是不可变的渠道消息；Email 与 WhatsApp 只是 channel，不是 Customer 或 Trade Case。

## Context
分析时读取 Customer、Contact、Trade Case、Conversation、最近消息、TradeActivity、Knowledge/Evidence、Draft、Quote、Open Questions 与 Next Action。

## Case Assignment
已有 Conversation、唯一活跃 Case 或强显式产品引用可作为 high confidence；多个可能 Case 为 medium 并要求人工确认；无法可靠判断进入 unassigned。禁止只凭公司名自动合并客户。

## Requirements / Conflicts
跨渠道需求必须保留来源 message IDs。数量、交期、价格等冲突不能自动覆盖，进入 conflict review。

## Human Boundary
禁止自动发送 Email/WhatsApp、自动批准报价、自动修改 Case 关键事实、将 AI inference 当作业务事实。所有外部 Draft 必须通过 Business Response Guard 与 Human Review。

## Privacy
消息全文仅用于授权的上下文；普通日志只保存引用 ID、状态、延迟和错误码，不记录客户消息全文。原始消息不可变。
