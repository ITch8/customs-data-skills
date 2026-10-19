---
name: SQLite 业务报表
slug: mysql-reporter
description: "查询本机业务库并生成报表。当用户要统计客户、询盘、报价、审批、订单、芯片货源、知识事实等业务指标，或导出业务数据表格时使用此技能。基于 SQLite，不适用于外部 MySQL 数据源。"
version: 2026.10.07
tool_dependencies: []
---

# SQLite 业务报表

本工程的业务库是 **SQLite**（`yuxi.db`，WAL 模式），不是 MySQL。
所有查询直连本机文件，不要尝试连接外部数据库。

## 数据边界

- 业务库：`<数据目录>/yuxi.db`，`<数据目录>` 由部署方通过环境变量 `DATA_DIR` 指定（未设置时使用应用默认数据目录）
- 另有vendor 侧库 `yuxi_full.db`，两者表结构不完全一致，**不要混查**
- 库文件可能处于 WAL 模式，读写都要走 SQLite，不要用文本工具直接打开

## 常用表

| 表 | 内容 |
|---|---|
| `trade_accounts` | 客户档案 |
| `trade_inquiries` | 询盘 |
| `trade_quotes` | 报价 |
| `trade_approvals` | 审批记录 |
| `trade_orders` | 订单 |
| `trade_business_outcomes` | 业务结果 |
| `chip_parts` | 芯片型号 |
| `chip_supplier_part` | 供应商货源 |
| `knowledge_documents` / `knowledge_facts` | 知识库 |
| `audit_logs` | 审计日志 |

## 操作流程

1. 确认库路径与目标表是否存在（部分表在未启用过的功能下可能为空）
2. 生成只读 SQL 并执行
3. 用表格呈现结果，注明数据源与取数时间

## 关键约束

- **只读**。一律用 `SELECT`，不得 `INSERT` / `UPDATE` / `DELETE` / `DROP`，也不得改写业务库。
- 避免全表扫描；大表先看 `LIMIT` 与索引命中情况。
- 报数时附上 SQL，让用户能自行复核，不要只给结论。
- 涉及金额、价格、审批状态的数字如实报，**不要估算或取整**。
- 不要输出密钥类配置的值；只说明缺少哪个变量名。
- 用户要的是「外贸日报/情报简报」时，改用 `tradehot` 技能，不要用本技能硬凑。

## 允许的工具

- 终端：执行只读 SQL 查询
- `list_tables` / `describe_table`：查看表与表结构
