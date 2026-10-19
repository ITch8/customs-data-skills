---
name: b2b-short-video
slug: b2b-short-video
description: "生成外贸 B2B 短视频分镜脚本，适用于 TikTok、YouTube Shorts、Instagram Reels。用户要短视频脚本、带货分镜或产品/工厂视频文案时使用。不用于长视频脚本。"
version: 1.0.0
tool_dependencies: []
---

# 外贸短视频脚本

生成适合竖屏短视频的分镜脚本。来源为 [b2b-short-video](https://github.com/chefroger/smart-trade-ai/tree/main/skills/b2b-short-video)。

## 输入

- 产品名称或类型
- 目标市场
- 视频主题：产品展示、工厂参观、安装教程、客户案例等
- 目标平台

缺产品或目标市场时先问，不要编造卖点。

## 铁律

- 前 3 秒必须抓住注意力。
- B2B 可以用工厂实拍、产品测试、安装过程展示专业度。
- 每支视频只讲一个核心点。
- 按竖屏 9:16 写画面。
- 文案使用目标市场语言，默认英语。卖点必须来自用户给出的资料，不要替产品发明参数。

## 结构

### 开场（0–3 秒）

用其中一种开场：

- 问题型：`Did you know...?` / `Why do most [product] fail in [condition]?`
- 视觉冲击：产品测试、安装过程、对比演示
- 行业洞察：`Here's something most buyers don't know about [product]`
- 结果展示：直接给出成品效果

### 主体（3–30 秒）

只展示 1–2 个卖点，并配上工厂或产线、安装使用、或对比画面。

### 收尾（30–60 秒）

给出评论、私信或访问网站中的一个动作，重复品牌或产品关键词，字幕写清下一步。不要写成已经发布。

## 输出

```markdown
## [视频主题]

**平台**：TikTok / YouTube Shorts / Instagram Reels
**时长**：15s / 30s / 60s

### 分镜脚本

| 时间 | 画面 | 文案/配音 | 字幕 |
|------|------|----------|------|
| 0-3s |  |  |  |

### 拍摄建议

- 场景：
- 设备：手机或相机
- 灯光：自然光或补光
```
