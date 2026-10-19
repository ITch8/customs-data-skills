---
name: trade-inquiry-reply
slug: trade-inquiry-reply
description: "诊断外贸询盘卡点，并保存一封待审批回复。用户要回复询盘、处理价格异议或判断该不该报价时使用。不会发送邮件。"
version: 1.0.0
tool_dependencies: ["trade_triage_inquiry", "trade_request_outreach_approval", "web_search"]
---

# 询盘回复

先读取客户案卷、询盘抽取字段和 **当前询盘 SKU** 对应的知识库，再写一封待审批回复。不要发送邮件。

## 输入（必须尽量带齐）

- Customer Context / Contact（姓名、职位、国家、公司）
- Inquiry 原文与抽取字段（Product、SKU、Quantity、Application、Requested、Customer Stage）
- Knowledge（仅当前 SKU；错库不得用）
- Conversation History / Previous Quote

调用本技能时走 `POST /api/trade/inquiries/{id}/draft` 或 `/reply-skill`。不要只把 `customer_message` 丢给模型。

## 知识边界

SKU 是知识库边界。询盘 SKU 与知识 SKU 不一致时必须 `PASS = false`，返回 `Knowledge mismatch`。禁止“参数差不多所以借用其他型号”。

## 卡点

规则诊断给出的缺项和风险只是起点。回复前再选定一个卡点：

- 比价：只有价格或起订量，规格不清。
- 利润：买方说贵，担心转卖没有空间。
- 规格：型号、材质、认证或交期没对齐。
- 内部：买方还要请示同事。
- 条款：样品费、付款方式或贸易术语谈不拢。

说「贵」时，不要只重复降价。先判断是不是利润空间，再在草稿里给一个可选择的规格或数量阶梯。阶梯里的价格必须来自用户给出的报价，不要自己编价格。

规格、数量、目标市场缺两项以上时，草稿只问其中两到三个问题，并写明补齐后再报价。不要生成正式报价。

## 草稿

用 `trade_request_outreach_approval` 保存。`stall` 必填，`gate_type` 用 inquiry，并带上 `inquiry_id`。规格和数量都缺时不要用 margin，否则接口会拒绝。正文用买方语言，默认英语。开头回应买方的原问题，然后只处理上面选定的那一个卡点。

调用工具前，正文里要有一行「本次依据：」并写上来源。来源可以是买方原文、用户给的报价，或 `web_search` 得到的 URL。没有依据就不要保存草稿。

退订联系人会被接口拒绝。工具成功只表示待审批，不要说邮件已发出。
