# Customs Lead SOP — 谐波减速器 / 人形机器人关节 · US / JP / DE

> **实跑测试报告** · 2026-07-27  
> Skill 安装：`install.ps1 -Targets cursor -RepoRoot onemore-search` ✅  
> Companion QA：`customs-pitfalls`  
> 产品：strain wave / harmonic reducer（谐波减速器），用于人形/协作关节  
> 输出目录：`./hunt_result/`

---

## 0. 测试输入

| 字段 | 值 |
|---|---|
| product_name | 谐波减速器 / harmonic reducer, strain wave gear |
| hs_codes | **候选** `8483.40`（gearing…）；部件可能落 `8483.90`（如 wave generator 示例 HTS `8483.90.5080`）→ **HS risk** |
| target_markets | US, JP, DE |
| competitor_names | Harmonic Drive LLC / Harmonic Drive Systems；Leaderdrive（绿的谐波）；Laifual |
| buyer_types | 人形本体厂、关节模组厂、协作/工业机器人厂、系统集成商、自动化分销商 |
| bol_export_files | **无**（本次故意测「纯公开抓取」路径） |

---

## 1. HS codes

| code | confidence | source | note |
|---|---|---|---|
| 8483.40 | candidate | OEC / WITS 贸易口径；行业习惯归入 HS 8483 gearing | 大类混有滚珠丝杠、变速箱等，**不能**当「仅谐波」 |
| 8483.90.* | candidate | 公开关税页将 harmonic drive wave generator 示例归入 HTS 8483.90.5080 | 成品减速器 vs 零件编码可能不同 |

**结论：** 未用历史报关单核实 → 后续宏观结论一律带 **HS risk**。实单前需清关/报关文件确认。

---

## 2. Market tiers + key metrics（Type B only）

数据源：WITS/Comtrade 镜像（中国→伙伴出口 848340）、OEC 2024 全球 848340。**无公司名。**

### 2.1 全球宏观（HS6 848340，OEC 2024）

| 指标 | 数值 |
|---|---|
| 全球贸易额 | ~$20.9B（同比约 -3.6%） |
| 最大进口国 | 美国 ~$3.68B |
| 其他大进口 | 中国 ~$1.83B；德国 ~$1.48B |
| 最大出口国 | 德国 ~$3.46B；中国 ~$3.34B |

### 2.2 中国出口到目标市场（848340，WITS，千美元）

| 伙伴 | 2023 CN→ | 2024 CN→ | 解读（带 HS risk） |
|---|---|---|---|
| US | ~428,382 | ~338,938 | 美线规模最大，但 2024 对美出口额下降；美进口仍以日欧印等多元来源为主 |
| JP | ~121,258 | （未在本次摘要聚合） | 日本既是高端谐波产地/品牌国，也是中国货进入难度高的市场 |
| DE | ~116,188 | （未在本次摘要聚合） | 德国是欧陆核心需求+本地传动强；适合二次线索/展会 |

### 2.3 分层

| 市场 | Tier | 理由 |
|---|---|---|
| **US** | Priority（带准入成本警示） | 848340 全球最大进口国；人形本体与自动化分销活跃；但中国货面临高额附加税风险 |
| **DE** | Opportunity | 欧陆机器人/自动密集；无公开逐票 Consignee；走 Automatica 等二次线索 |
| **JP** | Caution / 高壁垒机会 | 本土 Harmonic Drive Systems 等强势；中国份额叙事偏「补位/中低端」，切入需认证与客户验证周期 |

**行业定性（非 Comtrade 公司名单）：** 公开研报称谐波供给高度集中（日德系品牌+中国扩产）；美国谐波需求大量依赖进口；**不得从统计推公司名单。**

---

## 3. Tariff / access summary

| 市场 | 准入要点 | 建议 |
|---|---|---|
| US | 公开页示例：谐波相关零件 MFN 约 2.5%，**中国原产叠加 Section 301 等后有效税率可极高（示例页合计约 50%+）**——以最新 HTS/海关裁定为准 | 不可空喊「强攻美线低价」；需谈本地仓、非中国产地、或价值主张压过税差 |
| DE / EU | 行业资料称 8483 基础关税通常较低（约 0–3%），以税则为准 | 壁垒更多在认证、客户验证、日系替代惯性 |
| JP | 高端客户粘性高 | 优先样机窗口与技术文档，而非柜量叙事 |

**Step 3 结论：** 美国 = 规模 Priority，但 **关税/301 使「强烈进入」需附条件**；德国看验证周期；日本看是否接受中国方案双供。

---

## 4. Buyer list

### 4.0 抓取实况（关键测试发现）

| 动作 | 结果 |
|---|---|
| `WebFetch` ImportYeti `search?q=harmonic+drive` | 页面可打开，但 **结果列表为前端渲染**；抓到的是登录墙/API 样例壳，**无可用 Consignee 表** |
| `WebFetch` ImportYeti company 页 | **超时** |
| 搜索引擎索引到的 supplier 页 | 大量 **Premium access required**，看不到 Customers CSV |

→ 符合 Skill **Step 4c**：停止编造提单行；标注 `crawl_blocked`；下一步应 `bol_export_files` 手工导出。

### 4.1 美国 — Type A 未完成；二次线索 / 渠道线索

| company | market | source | last_shipment_window | score dims (R/F/P/S/C) | total | tier | flags | evidence |
|---|---|---|---|---|---|---|---|---|
| Motion-adjacent US distributors（如公开零售谐波的轴承/传动电商） | US | secondary_lead + website catalog | n/a | 0/0/10/5/12 | **27** | deprioritize 量产开发；可作样品渠道 | `evidence_thin` | 有售谐波商品页，**无**公开海运 Consignee 证实其为进口主体 |
| Harmonic Drive LLC（Beverly, MA） | US | company site / industry media | n/a | — | — | **竞品/本地制造**，非中国替代买家 | `competitor_not_buyer` | 美系谐波品牌与制造，默认不当「找客户」对象 |
| Figure AI 等美国人形本体（公开供应链传闻） | US | news / secondary | n/a | 0/0/15/5/18 | **38** | nurture / 展会触达；**勿写进 BOL 证实** | `evidence_thin`；供应链传闻未交叉验证 | 媒体称关节多用既有谐波品牌；对华方案切入不确定 |
| Apptronik | US | patent/industry notes | n/a | 0/0/5/5/14 | **24** | watch | `evidence_thin`；可能偏线性驱动 | 公开资料强调 proprietary linear actuators，谐波匹配度可能偏低 |

### 4.2 德国 — 无公开逐票 BOL；展会二次线索

| company / channel | market | source | score | tier | flags | evidence |
|---|---|---|---|---|---|---|
| AUTOMATICA Munich 观众/采购池（机器人&自动化） | DE | exhibitors.automatica-munich.com；Leaderdrive 等参展新闻 | n/a（渠道） | Priority **渠道** | `secondary_lead` | 绿的谐波等以展商身份出现；适合约谈模组厂/本体厂采购，非提单名单 |
| 工业机器人/自动化 OEM 生态（如公开报道中的德系机器人供应链） | DE | industry reports | evidence_thin | nurture | `possible_reexport_hub` 若仅从荷比清关 | 需官网目录匹配谐波/关节后再升分 |

### 4.3 日本 — Caution

| note | flags |
|---|---|
| 本土 Harmonic Drive Systems 等为全球供给核心；中国出口有量但高端替代难 | `hs_risk` + 高认证预期；优先「双供/成本敏感机型」叙事，勿群发 |

### 4.4 可立刻跟进的「渠道型」二次买家（有官网分销证据）

| company | market | source_tools | product_fit | company_fit | total* | tier | flags | next_action |
|---|---|---|---|---|---|---|---|---|
| Motion Control Products Ltd | UK→可辐射 EU | 官网自称 Leaderdrive 英国官方分销；谐波产品页 | 20 | 16 | **~52**（无提单频率） | nurture→normal（先确认是否进口德国客户） | `secondary_lead`, `evidence_thin` | 问清覆盖德奥瑞客户；样品认证周期 |
| Leaderdrive / Laifual **自身** | CN 出口商 | 官网+Automatica/iREX 参展 | — | — | — | 作**同行对标**非买家 | competitor | 反查其公开客户新闻，勿当 Consignee |

\*二次线索 **故意压低** Recency/Frequency（0），避免伪高精度。

---

## 5. Outreach order + translated angles

1. **先补数据：** 用户从 ImportYeti/付费库导出「harmonic / strain wave / robot joint reducer」相关 CSV → 再跑清洗评分（预期名单质量跃迁）  
2. **德国：** Automatica / SPS 线索 → 模组厂、协作臂、集成商；角度：样机 MOQ、扭矩密度、一致性批次、交期窗口  
3. **美国：** 分销商/进口商（有目录）+ 人形本体采购（LinkedIn Sourcing）——**禁止**引用未核实供应链传闻为事实  
4. **日本：** 仅在有明确 RFQ/展会意向后一对一

---

## 6. Draft emails（高意图模板；来源仅存 CRM）

### Draft A — 关节模组 / 协作臂（EN）

Subject: Prototype-scale strain-wave options for joint validation

> Hello {{Name}},  
> I noticed your team has been expanding motion components for collaborative and humanoid-style joints — especially compact, high torque-density reducers with tight backlash control.  
> We can support prototype-scale MOQs, batch consistency checks, and a clearer lead-time window for your next validation cycle. Happy to share size/ratio tables and a short comparison sheet against common interfaces.  
> Best regards,  
> {{Sender}}

### Draft B — 德系自动化集成商（EN）

Subject: Strain-wave supply for your next robot cell builds

> Hello {{Name}},  
> For integrators running mixed robot brands, spare and lead-time risk on precision reducers often shows up before price. We focus on stable batch quality and documentation packs that make incoming inspection faster.  
> If you have upcoming cell builds or retrofit windows, we can align samples to your flange/interface notes.  
> Best regards,  
> {{Sender}}

**禁止句：** customs / BOL / ImportYeti / “we saw your shipments from …”

---

## 7. Risks & data limits（customs-pitfalls QA）

```
- [x] 未把 Consignee 默认当终端买家（本次几乎无 Consignee）
- [x] 未把 Comtrade/OEC 写成公司名单
- [x] 统计单价未用作报价
- [x] HS 标记为 candidate + HS risk
- [x] 欧洲拆到德国；未写「做欧洲」
- [x] 美国关税/301 已提示，未强烈无条件进入
- [x] ImportYeti 前端墙 → 未编造提单行；要求 CSV handoff
- [x] 开发信已做字段转译模板
- [ ] Type A 美国真实买家名单：未完成（阻塞在反爬/登录）
- [ ] To Order / Broker 过滤：待有 CSV 后执行
```

**本次最大真实结论：** Skill 的「统计选市 + 关税警示 + 二次线索 + 反爬改导出」路径可跑通；**纯 Agent 裸爬 ImportYeti 拿企业级名单在当前环境失败**——这是预期内的生产路径，不是 SOP 失败。

---

## 8. Next three actions

1. **导出 CSV：** ImportYeti / 付费库检索 `strain wave` `harmonic reducer` `robot joint` 及同行英文名 → 放入 `./exports/` 再跑 `/customs-lead-sop` Step 4c–6  
2. **核实 HS：** 用一票真实报关/清关文件锁定 8483.40 vs 8483.90.*  
3. **德国展会池：** 从 Automatica 展商/观众名录抽 20 家模组/本体/集成商，标 `secondary_lead` 后 LinkedIn 找 Sourcing  

---

## 附录 · 安装与调用自检

| 检查项 | 结果 |
|---|---|
| `.cursor/skills/customs-lead-sop/SKILL.md` | 已安装 |
| `.cursor/skills/customs-pitfalls/SKILL.md` | 已安装 |
| `examples/humanoid-harmonic-reducer.md` | 已安装 |
| 报告落盘 | `hunt_result/customs-26-07-27-harmonic-reducer.md` |

**复测命令（有 CSV 后）：**

```text
/customs-lead-sop
产品：谐波减速器（strain wave），目标 US/JP/DE
已导出：./exports/us-harmonic-*.csv
跳过抓取，清洗并过滤 To Order/货代/清关行，强制 customs-pitfalls，更新本报告
```
