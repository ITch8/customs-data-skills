---
name: b2b-reddit-engagement
slug: b2b-reddit-engagement
description: "为外贸 B2B 写 Reddit 社区评论和帖子草稿。用户要 Reddit 评论、社区引流或行业讨论回复时使用。不用于 Facebook 或 LinkedIn。"
version: 1.0.0
tool_dependencies: []
---

# Reddit 社区互动

通过有实质内容的评论和帖子建立行业信任。来源为 [b2b-reddit-engagement](https://github.com/chefroger/smart-trade-ai/tree/main/skills/b2b-reddit-engagement)。

## 输入

- 产品或行业
- 目标帖子的链接或正文；若要发帖，则给出话题方向

## 铁律

- 先提供价值，再考虑曝光。不要硬广。
- 评论必须有专业内容。不要写 “Great post!” 这类空回复。
- 不主动留联系方式，不直接发链接，不把草稿说成已经发出。
- 每个 subreddit 规则不同。没有版规时，提醒用户先看置顶帖。
- 正文使用目标社区语言，默认英语。

## 流程

### 1. 推荐社区

按行业从这些方向里选，并说明理由：

- r/supplychain、r/logistics、r/manufacturing
- r/internationaltrade、r/importexport
- r/smallbusiness、r/entrepreneur
- r/AskEngineers、r/Procurement

行业更具体时，可以补充更贴近的 subreddit，并标明这是建议而不是已核实的版规。

### 2. 写评论

1. 确认帖子在讨论什么。
2. 找到能贡献的经验、数据或判断。
3. 第一句认同或延伸楼主观点，主体给见解，收尾用一个开放问题。
4. 标出敏感角度或可能引来负面讨论的风险。

### 3. 写帖子（仅当用户要求发帖）

标题要有信息量，例如从业经验里买家常犯的具体错误。正文分享经验或数据，语气是分享，不是推销。并建议如何回复评论把讨论留住。

## 输出

```markdown
## 推荐社区

- r/...：理由

## 评论草稿

...

**注意**：风险或版规提醒

## 帖子草稿

**标题**：
**正文**：
```

用户只要求评论时，不要输出帖子草稿。
