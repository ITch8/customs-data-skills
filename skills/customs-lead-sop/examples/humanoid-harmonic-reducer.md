# 实操案例：人形机器人产业链 · 谐波减速器 / 关节模组（美日德）

面向 **ToB 零部件出口**，不要一上来搜 “humanoid robot importer” 或 “robotics company list”。按序：

1. **HS**：按结构核实——谐波减速器、行星减速器、伺服关节模组、力矩传感器编码常不同；优先用历史报关/清关文件，勿用中文品名瞎猜  
2. **Comtrade（仅宏观）**：比较 US / JP / DE 进口规模、增长、从中国采购比例——**到此为止，不出公司名**  
3. **USITC + 目的国统计**：月度趋势、供应国结构（日本既是需求市场也可能是竞品来源国，分开看）  
4. **WTO / 目的国税则**：基础关税 + 是否涉及机电认证、原产地敏感；高壁垒则勿空喊「强烈进入」  
5. **美国（Type A）**：ImportYeti + ImportInfo——搜同行英文名、已知模组厂、多组品名（harmonic drive / strain wave gear / robot joint reducer / rotary actuator）；过滤 `To Order` / 货代 / 清关行；遇反爬改用手动导出 CSV  
6. **日本 / 德国企业池**：多数场景**没有**美式逐票 Consignee 提单——用机器人/自动化展会展商、协会名录、本体厂供应链新闻、LinkedIn（Sourcing / Mechanical / Motion Control）、付费库导出；证据标 `secondary_lead` 或 `user_export`  
7. **分型（ToB，不是零售）**：

| 类型 | 你在卖什么给他们 | 切入点 |
|---|---|---|
| 人形 / 协作本体厂 | 关节减速器或整关节 | 样机小批量、扭矩密度、背隙与噪音、一致性批次、验证周期交期 |
| 关节模组厂 | 减速器 / 无框电机 / 编码器 | 接口尺寸、定制比、供货稳定性、替代验证成本 |
| 工业机器人 / 协作臂厂商 | 减速与传动件 | 认证、寿命数据、备件窗口、多型号覆盖 |
| 系统集成商 | 模组或传动方案 | 技术支持、交期、现场调试配合、小批量灵活 |
| 自动化分销商 / 进口商 | 标准型号分销 | 价格带、MOQ、文档完整度、本地库存策略 |
| 高校 / 实验室采购代理 | 小批量样件 | 响应速度、参数文档、可开票与合规——勿当量产大单 |

8. **评分**：频率、匹配度、供应商结构、最近采购（见 scorecard.md）；二次线索标 `evidence_thin`；实验室/代理商降低 company-fit  
9. **内部信号 → 外部话术**：提单上的 “strain wave gear / harmonic reducer / joint actuator” 只留在 CRM；对客户谈扭矩密度、低背隙、样机交期、一致性检测

名单数量可能少于群发名单，但更接近真实采购决策链。

## 开发信：禁止暴露 + 必须转译

错误（暴露数据源）：
> We found your company from customs data / bill of lading records…

错误（把提单事实原样甩给客户）：
> I saw you imported two containers of harmonic reducers from Company A three months ago…

正确（把海关字段转译为产品 / 供应链观察）：
> I noticed your team has been expanding motion components for humanoid and collaborative applications — especially high torque-density joint solutions with tight backlash control. We can support prototype-scale MOQs, batch consistency checks, and a clearer lead-time window for your next validation cycle.

转译原则：内部可见「品名/规格关键词/补货节奏/多供应商」；客户可见「场景观察 + 验证/交期/一致性等你能解决的问题」。不点名其现有中国供应商，不报柜量。

## 同链路可替换 SKU

SOP 不变，替换产品与买家分型即可：

- 无框力矩电机 / frameless torque motor  
- 六维力/力矩传感器 / 6-axis F/T sensor  
- 行星滚柱丝杠 / planetary roller screw  
- 灵巧手驱动模组 / dexterous hand actuator module  
