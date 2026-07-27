# 实操案例：宠物碗 / 饮水器（美英加）

不要一上来搜 “pet products importer”。按序：

1. **HS**：从历史报关确认不同材质、功能对应编码  
2. **Comtrade（仅宏观）**：比较美/英/加进口规模、增长、从中国采购比例——**到此为止，不出公司名**  
3. **USITC + CIMT**：月度趋势与供应国结构  
4. **WTO**：基础关税  
5. **美国（Type A）**：ImportYeti + ImportInfo——搜同行、已知进口商、多组产品描述；过滤 `To Order` / 货代 / 清关行；遇反爬则改用手动导出 CSV  
6. **英国 / 加拿大企业池**：官方通常**没有**美式逐票 Consignee 提单可挖——用展会展商、协会名录、LinkedIn、公开新闻做二次线索；有付费库则导出后交给 Skill  
7. **分型**：品牌商 / 批发商 / 连锁零售 / 电商供货 / Dropship / 综合进口商  
8. **评分**：频率、匹配度、供应商数、最近采购时间（见 scorecard.md）；二次线索标 `evidence_thin`  
9. **切入点**：

| 类型 | 切入点 |
|---|---|
| 品牌商 | 新品开发、模具与包装定制 |
| 批发商 | SKU 组合、库存周转、稳定交期 |
| 电商平台 | 小批量补货、低客诉包装 |
| 连锁零售 | 认证、质量一致性、供应稳定 |
| Dropship | 高周转 SKU、产品数据、仓配适配 |

名单数量可能少于群发名单，但成交概率更高。

## 开发信：禁止暴露 + 必须转译

错误（暴露数据源）：
> We found your company from customs data / bill of lading records…

错误（把提单事实原样甩给客户）：
> I saw you imported two containers of pet bowls from Company A three months ago…

正确（把海关字段转译为产品 / 供应链观察）：
> I noticed that your company has been expanding its range in this product category — especially stainless dual-bowl designs. We may be able to support you with a more flexible MOQ and several packaging options for your next replenishment cycle.

转译原则：内部可见「品名/材质/补货节奏/多供应商」；客户可见「品类观察 + 你能解决的问题」。不点名其现有中国供应商，不报柜量。
