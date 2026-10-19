# 外贸 AI 技能库（Agent Skills）

**关键词：** 外贸、跨境电商、B2B 获客、询盘、开发信、客户背调、供应商寻源、海关数据、提单、HS 编码、芯片贸易、工厂出海、社媒获客、独立站、外贸 Agent、AgentOS、Agent Skills、SKILL.md

**Keywords:** foreign trade, cross-border ecommerce, B2B lead generation, inquiry follow-up, supplier sourcing, customs data, bill of lading, HS code, chip trade, factory export, agent skills, LLM skills

42 个面向外贸/跨境业务的 Agent 技能，覆盖 **寻源获客 → 线索筛选 → 供应商核验 → 询价跟进** 的完整链路。

其中 [`customs-lead-sop`](./skills/customs-lead-sop/) 与 [`customs-pitfalls`](./skills/customs-pitfalls/) 保留本仓库原有的多运行时版本（Cursor、Codex、OpenClaw、Claude Code），含 `agents/openai.yaml` 与 OpenClaw metadata。其余技能按同一 `skills/<name>/` 目录并入。操作手册见 [`AGENTS.md`](./AGENTS.md)。

这些技能从外贸专家的公开视频和文章中提取、蒸馏而成。原始材料里的判断、步骤和案例被收成可执行的方法论，并带上**证据纪律**：要求来源链接，区分"已核实"与"自述"，拒绝在无证据时编造结论。

整理不易。我正在做外贸 AgentOS，欢迎行业大佬交流沟通。

更多文章关注公众号：**AI在忙**

<p align="center"><img src="./assets/ai-zaimang.jpg" alt="AI在忙" width="180"></p>

## 来源

材料是从业者已经公开的视频（口播）和文章，覆盖获客、寻源、海关、芯片、跟进和行业视角。

蒸馏时做三件事：抽出能重复使用的判断和步骤，写成 `SKILL.md`，把数字、个案和当时的平台规则标成个例。行业视角保留说话人的框架，人物匿名为外贸专家甲至寅。技能回答业务问题的时候，依据来自这批专家材料，再按证据纪律标明哪些已经核对、哪些仍是假设。

---

## 为什么有这套技能

做外贸最常见的失败不是不会找客户，而是**在错误的对象上浪费了时间**：

- 找到一个"工厂"，其实是贸易商；
- 拿到一份报价，比的却不是同口径的数字；
- 相信了平台的"源头厂家"标签，没有回溯主体身份；
- 把"查过但没证据"写成了"查过，结果是零"。

所以这批技能共享同一条纪律：**无 URL 的判断只能算假设；平台自填信息只是自述；未经核验不构成结论。**

---

## 安装

把 `skills/` 下的技能目录复制到你的 Agent 技能目录即可。

每个技能是一个包含 `SKILL.md` 的文件夹，`SKILL.md` 的 YAML frontmatter 声明元数据：

```yaml
---
name: 供应链寻源与初筛          # 显示名
slug: sourcing-discover         # 唯一标识（ASCII）
description: "..."              # 触发说明
version: "1.0.0"
tool_dependencies: [sourcing_search]     # 需要宿主提供的工具
skill_dependencies: [chip-supplier-check] # 依赖的其他技能
---
```

部分宿主把 `slug` 与 `version` 当作必需项，缺失会把技能标成数据质量问题。`customs-lead-sop` 与 `customs-pitfalls` 使用通用 frontmatter（`name`、`description`、OpenClaw metadata），不依赖这两个字段。

### 依赖说明

- `skill_dependencies` 指向本仓库内的其他技能，闭包会自动展开。
- `tool_dependencies` 指向**宿主环境**提供的工具。若你的环境没有同名工具，该技能仍可加载，但相关步骤无法执行。

若干技能去掉了宿主专有工具声明（如 `present_artifacts`、`list_kbs`），因为它们由特定平台提供。`customs-lead-sop` 仍按原版使用网页检索、网页抓取和本地 CSV/Excel。

### 安装到 Cursor / Codex / OpenClaw

`install.ps1` / `install.sh` 只安装海关这一对技能：

```powershell
cd customs-data-skills
.\install.ps1
.\install.ps1 -Targets codex,openclaw -Global
```

```bash
chmod +x install.sh
./install.sh
GLOBAL=1 ./install.sh codex openclaw
```

其余技能把对应目录复制到运行时的 skills 根目录即可。Codex 里海关技能可用 `$customs-lead-sop` / `$customs-pitfalls`。

---

## 技能清单

### B2B 获客与内容（6）

| 技能 | 版本 | 说明 |
|---|---|---|
| `b2b-fast-builder` | 1.0.0 | 规划或审计无 CMS 的外贸 B2B 静态站：每个网址预生成完整 HTML，询盘先记录再通知。用户要建独立站、国家站或 SEO 专题站时使用。不用于需要后台实时发文的 CMS。 |
| `b2b-reddit-engagement` | 1.0.0 | 为外贸 B2B 写 Reddit 社区评论和帖子草稿。用户要 Reddit 评论、社区引流或行业讨论回复时使用。不用于 Facebook 或 LinkedIn。 |
| `b2b-short-video` | 1.0.0 | 生成外贸 B2B 短视频分镜脚本，适用于 TikTok、YouTube Shorts、Instagram Reels。用户要短视频脚本、带货分镜或产品/工厂视频文案时使用。不用于长视频脚本。 |
| `outreach` | 1.0.0 | Decide whether a qualified prospect is ready for a guarded, human-approved first touch. 用户要判断该不该联系潜客、准备首次触达时使用 |
| `sales-copilot` | 1.0.0 | AI 外贸销售副驾驶：围绕 Trade Case 提供可追溯、需人工确认的分析与建议。用户要销售判断、跟进策略或话术建议时使用。 |
| `product-coaching` | 2026.09.29 | 外贸产品理解教练。用于场景判断、参数推理、质量与供应链风险识别。先追问用户理由，不直接给答案；禁止发送客户消息或发布知识。 |
### 寻源与供应商核验（9）

| 技能 | 版本 | 说明 |
|---|---|---|
| `sourcing-discover` | 1.0.0 | 按品类/HS编码/目标国家检索并初筛工厂与供应商候选，逐条标注证据等级与来源链接。不编造供应商、不把平台自填信息当已核实、贸易商与工厂的区分交给人工。 |
| `chip-bom-sourcing` | 2026.09.23 | 把芯片询价或 BOM 整理成可核对的 MPN、规格、批次、供货和替代要求；用于询价、比价和采购准备。 |
| `chip-supplier-check` | 2026.09.23 | 核对芯片供应商身份、授权路径、库存证据、批次追溯和质量文件；不会仅凭网站或照片宣布芯片真伪。 |
| `customs-lead-sop` | 1.0.0 | 用公开海关/贸易数据做外贸客户开发：确认 HS 编码 → 用宏观统计给市场分层 → 从提单反查真实采购商 → 评分分级 → 把证据转译成开发信草稿。反爬或登录墙时支持用户导出 CSV/Excel 交接。用户提到海关数据、 |
| `customs-pitfalls` | 1.0.0 | 海关数据避坑护栏：货代/报关行假阳性、To Order 与 AMS 隐私遮蔽、统计≠买家、无提单≠不进口、统计单价误用、单词关键词检索、群发轰炸、HS 选错、转口枢纽、无视关税、暴露数据来源、把关务字段生硬转译。做进口商 |
| `prospect-qualification` | 1.1.0 | Qualify a prospect with explainable fit dimensions, evidence and confidence. |
| `icp-architect` | 1.0.0 | Build an evidence-aware ideal customer profile from product knowledge and target market constraints. |
| `trade-buyer-check` | 1.0.0 | 为外贸客户做公开信息背调，并写入客户档案。用户要核验买家身份、采购角色或风险时使用。不用于国际站信用分或付费海关数据。 |
| `expert-yin-trade-perspective` | 2026.09.27 | 以外贸专家寅的身份回答外贸实战、获客和订单判断。基于公开口播蒸馏，数字都是个例。用户要外贸专家寅视角时使用。 |
### 芯片与电子行业（5）

| 技能 | 版本 | 说明 |
|---|---|---|
| `chip-trade-start` | 2026.09.23 | 带芯片贸易新手从能力盘点、细分方向选择到首批询价和风险检查逐步起步；内贸、外贸或尚未决定路线均适用。 |
| `chip-trade-compliance` | 2026.09.23 | 为芯片内贸或跨境交易整理主体、货物、目的地、最终用户/用途和申报核验项；法规结论必须依据当前官方来源并由负责人确认。 |
| `expert-gui-chip-trade-perspective` | 2026.10.06 | 以外贸专家癸的身份回答芯片贸易、库存行情、代理备货和客户成交。基于其公开口播蒸馏，数字都是个例。用户要外贸专家癸视角或芯片生意时使用。 |
| `expert-zi-chip-procurement-perspective` | 2026.10.06 | 以外贸专家子的身份回答芯片采购、电子元器件识别、原装辨别和行情判断。基于其公开口播蒸馏，数字都是个例。用户要外贸专家子视角或芯片采购时使用。 |
| `expert-chou-semiconductor-sales-perspective` | 2026.10.06 | 以外贸专家丑的身份回答半导体ToB销售、新人入行、客户开发和付款提成。基于其公开口播蒸馏，数字都是个例。用户要外贸专家丑视角或半导体销售时使用。 |
### 贸易执行与协作（6）

| 技能 | 版本 | 说明 |
|---|---|---|
| `trade-desk` | 2026.09.22 | 处理外贸客户、询盘诊断和待审批开发信。当用户要建客户档案、判断询盘、起草对外邮件时使用。 |
| `trade-inquiry-reply` | 1.0.0 | 诊断外贸询盘卡点，并保存一封待审批回复。用户要回复询盘、处理价格异议或判断该不该报价时使用。不会发送邮件。 |
| `trade-follow-up` | 1.0.0 | 为已有外贸客户准备下一次跟进草稿。用户要跟进已读不回、报价后沉默、高价值未下单或流失客户时使用。不会发送邮件。 |
| `trade-simulation-coach` | 2026.09.29 | 外贸全流程业务沙盘教练。解释当前情境、按用户能力控制提示、分析决策后果与因果风险。不替用户决策；禁止把模拟数据写入真实客户、报价或公司知识库。 |
| `conversation-context` | 1.0.0 | 跨 Email 与 WhatsApp 的统一客户沟通上下文与 Trade Case 解析。用户要梳理客户沟通历史、把邮件与消息归入同一 Trade Case 时使用。 |
| `tradehot` | 1.1.0 | 整理外贸与跨境电商中文简报，覆盖平台动态、市场、HS Code、关税准入、物流、汇率和风险。用户要外贸日报、市场机会或风险雷达时使用。 |
### 行业视角（匿名专家）（9）

| 技能 | 版本 | 说明 |
|---|---|---|
| `expert-jia-social-trade-perspective` | 2026.09.27 | 以外贸专家甲的身份回答社媒获客、工厂外贸、选品和市场选择。基于其公开口播蒸馏，数字都是个例。选他如果你在起步阶段、预算有限、要先小步验证再投入。用户要外贸专家甲视角时使用。 |
| `expert-yi-social-trade-perspective` | 2026.09.28 | 以外贸专家乙的身份回答社媒获客、外贸创业与订单跟进。基于公开口播蒸馏，数字都是个例。选他如果你从零起步做社媒、关心内容怎么做、订单怎么跟。用户要外贸专家乙视角时使用。 |
| `expert-bing-brand-overseas-perspective` | 2026.10.05 | 以外贸专家丙的身份回答中国品牌出海、西方买家沟通、展会成交和销售培训。基于公开口播蒸馏，数字都是个例。用户要外贸专家丙视角时使用。 |
| `expert-ding-social-trade-perspective` | 2026.10.05 | 以外贸专家丁的身份回答社媒外贸、轻资产获客、选品测试与谈单收款。基于其公开口播蒸馏，数字都是个例。选他如果你想轻资产试水、关心选品测试和收款风险。用户要外贸专家丁视角时使用。 |
| `expert-wu-factory-overseas-perspective` | 2026.10.05 | 以外贸专家戊的身份回答工厂出海、社媒获客、AI外贸和独立站。基于其公开口播蒸馏，数字都是个例。用户要外贸专家戊视角或工厂出海时使用。 |
| `expert-ji-foreign-trade-perspective` | 2026.10.05 | 以外贸专家己的身份回答外贸起步、社媒获客、选品、工厂出海和谈单避坑。基于公开口播蒸馏，数字都是个例。用户要外贸专家己视角时使用。 |
| `expert-geng-foreign-trade-perspective` | 2026.10.05 | 以外贸专家庚的身份回答 Facebook 投流、WhatsApp 跟进、客资筛选、独立站和工厂出海。基于其公开口播蒸馏，数字都是个例。选他如果你已有产品、要把公域投流和私域跟进跑通。用户要外贸专家庚视角时使用。 |
| `expert-xin-b2b-perspective` | 2026.09.27 | 以做了 15 年 B2B 的外贸专家辛的身份回答获客、内容、独立站、广告投放和团队落地问题。用户要外贸专家辛视角，或判断外贸做法是否务实时使用。数字都是公开口播中的个例。 |
| `expert-ren-overseas-perspective` | 2026.10.05 | 以外贸专家壬的身份回答工厂出海、社媒外贸、选品根据地和谈单成交。基于公开口播蒸馏，数字都是个例。用户要外贸专家壬视角时使用。 |
### 研究与数据（4）

| 技能 | 版本 | 说明 |
|---|---|---|
| `deep-research` | 2026.09.19 | 深度研究编排方法论：澄清范围、拆解规划、并行调度子智能体调研、对抗式核验、综合成带引用的结构化报告。当任务需要多来源、可追溯、需事实核查的深度研究时使用此技能。 |
| `foreign-trade-research` | 1.0.0 | 对目标国家和产品做外贸市场调研，覆盖品牌商、制造商和经销商，给出竞争格局、定价、渠道和进入建议。用户要海外市场分析或竞品调研时使用。 |
| `mysql-reporter` | 2026.10.07 | 查询本机业务库并生成报表。当用户要统计客户、询盘、报价、审批、订单、芯片货源、知识事实等业务指标，或导出业务数据表格时使用此技能。基于 SQLite，不适用于外部 MySQL 数据源。 |
| `ft-geo` | 1.0.0 | 审计外贸独立站的 AI 引用可见性，输出 llms.txt、结构化数据、抓取规则和 P0/P1/P2 清单。用户要做 GEO、写 llms.txt 或让 AI 引用网站时使用。不用于站内 SEO 排名承诺。 |
### 知识与产物（3）

| 技能 | 版本 | 说明 |
|---|---|---|
| `knowledge-base` | 2026.06.24 | 使用已配置的知识库进行检索、打开文档、文档内定位和查看思维导图。当用户需要基于已配置知识库回答问题、核验资料或引用文档内容时使用此技能。 |
| `html-preview` | 2026.07.23 | 使用 Markdown `html:preview` 围栏输出轻量静态 HTML/CSS 可视化。当普通 Markdown 难以清晰表达数值对比、层级关系、流程、时间线、关键指标或布局示意，或用户明确要求可视化 HTML |
| `image-gen` | 2026.06.02 | 在 Agent 沙盒中生成图片并保存到 outputs。当用户要求生成图片、海报、插画、文生图，或指定 Qwen-Image、其它兼容图片生成接口时使用此技能。 |

完整机器可读清单见 [`manifest.json`](./manifest.json)。

---

## 设计原则

1. **证据分级，不给单一分数。**
   区分「已核实事实/供应商自述/未核实/存在冲突」，而不是把候选压成一个总分——
   90 分和 40 分看起来都"够格发邮件"，而差别是看不见的。

2. **无证据维度留 `null`，不得填 `0`。**
   `null` 表示"没查"，`0` 表示"查了确实为零"。把没查写成 0，等于用假数据提前淘汰本该继续核验的线索。

3. **二次线索有天花板。**
   展会名录、协会会员、黄页、领英能证明公司存在，**不能证明它做这个品类**。
   这类线索单独不足以支撑"可推进"的结论。

4. **不越界下结论。**
   技能会明确说明自己**不判断**什么（例：谁是工厂、是否正品、是否可以付款），
   这类判断本质上无法靠公开信息证明，必须交给人。

5. **失败要响亮。**
   检索源未配置时明确报错，而不是返回空列表——"还没查"和"查了没有"是两回事，
   混淆二者会导致对整个品类的误判。

---

## 已做的处理

为便于在其他环境使用，本仓库对 10 个技能做了调整（详见 `manifest.json`）：

- `b2b-fast-builder`：移除不可用工具声明 present_artifacts
- `customs-lead-sop`、`customs-pitfalls`：保留本仓库原有多运行时版本，未用精简改编稿覆盖
- `deep-research`：移除不可用工具声明 present_artifacts；补充 slug 字段
- `foreign-trade-research`：移除不可用工具声明 present_artifacts
- `ft-geo`：移除不可用工具声明 present_artifacts
- `html-preview`：补充 slug 字段
- `image-gen`：移除不可用工具声明 present_artifacts；补充 slug 字段
- `knowledge-base`：移除不可用工具声明 list_kbs, query_kb, find_kb_document, open_kb_document, get_mindmap, search_file, download_kb_file
- `mysql-reporter`：去除部署特定路径引用
- `tradehot`：移除不可用工具声明 present_artifacts
- 行业视角人物已匿名为外贸专家甲至寅，并去掉院校、雇主、账号名和个人社交账号

**已排除**：备份目录（`shared/`）、`__pycache__`、以及所有含本机绝对路径的内容。

---

## 免责声明

- 行业视角类技能已匿名为「外贸专家甲」至「外贸专家寅」，基于专家公开视频和文章蒸馏的讨论方式，
  **不代表任何特定个人**，也不表示获得本人授权或背书。其中的数字、成交和投流效果均为个例，不可作为基准。
- 视频转写和文章摘录可能有误差，平台规则、税率、汇率、物流和法规都会变。使用前以当时的官方文本和一手来源为准。
- 关税归类、出口管制、制裁筛查、外汇、税务、合同和付款安排，须由具备资质的专业人士确认。技能输出不能当作申报、放行或付款依据。
- 技能不鉴定芯片真伪，不确认谁是工厂，不评估买家信用，也不决定能不能付款。这些结论要由人根据合同、样品、文件和付款记录作出。
- 开发信、跟进和社媒内容默认是草稿，发出前由使用人审核。发出后的报价、承诺和客户关系由使用人负责。
- 海关统计、提单和公开网页只是线索，统计不等于买家名单。无来源链接的判断只是假设。采集、保存客户个人信息，须符合所在地法律和目标平台条款。
- 本仓库不提供任何"认证"或"担保"，不承诺询盘、成交、排名或利润。技能的作用是让判断过程更可追溯，不是替代尽调。
- 技能中出现的平台、品牌和工具名称属于各自权利人。使用者需自行确保数据采集与使用符合目标平台的服务条款与所在地的法律法规。

## License

MIT — 见 [LICENSE](./LICENSE)。
