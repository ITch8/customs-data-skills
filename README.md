# Customs Data Skills

用**公开海关 / 贸易数据**做外贸客户开发的可复用 Agent Skills。

| Skill | 作用 |
|---|---|
| [`customs-lead-sop`](./skills/customs-lead-sop/) | 完整 SOP：HS → 市场分层 → 真实采购商 → 评分 → 个性化开发信草稿 |
| [`customs-pitfalls`](./skills/customs-pitfalls/) | 避坑质检 + 可粘贴系统提示词 |

**多运行时：** Cursor · Codex · OpenClaw · Claude Code / Agent Skills 兼容客户端

License: [MIT](./LICENSE)

---

## 为什么开源这一套

很多团队还在「搜公司 → 群发同一封开发信」。海关数据真正的价值是回答：

1. 哪个市场在买  
2. 哪些公司确实买过  
3. 现在有没有切入供应链的机会  

本仓库把流程与避坑规则写成 **Agent 可调用的 Skill**，而不是又一篇收藏向文章。

---

## 快速安装

### 一键脚本

```powershell
# Windows
cd customs-data-skills
.\install.ps1                          # 尝试写入 Cursor / Codex / OpenClaw / Agents
.\install.ps1 -Targets codex,openclaw -Global
.\install.ps1 -Targets cursor -RepoRoot ..\   # 指定 monorepo 根
```

```bash
# macOS / Linux
cd customs-data-skills
chmod +x install.sh
./install.sh
GLOBAL=1 ./install.sh codex openclaw
REPO_ROOT=.. ./install.sh cursor
```

### 手动复制

把 `skills/customs-lead-sop` 与 `skills/customs-pitfalls` 复制到：

| 运行时 | 目录 |
|---|---|
| Codex | `~/.codex/skills/` 或项目 `.codex/skills/` |
| OpenClaw | `~/.openclaw/skills/` 或工作区 `skills/` / `.agents/skills/` |
| Cursor | 项目 `.cursor/skills/` |
| Agents 标准 | `~/.agents/skills/` 或项目 `.agents/skills/` |

### OpenClaw CLI（可选）

```bash
openclaw skills install ./skills/customs-lead-sop --as customs-lead-sop
openclaw skills install ./skills/customs-pitfalls --as customs-pitfalls
# 或整包复制到 workspace skills/
```

### Codex

安装后可用 `$customs-lead-sop` / `$customs-pitfalls`。  
项目级说明见 [`AGENTS.md`](./AGENTS.md)；Codex UI 元数据见各 skill 下 `agents/openai.yaml`。

---

## 怎么用

```text
/customs-lead-sop
产品：宠物碗；目标：US/UK/CA；同行：Xxx Co Ltd
按完整 SOP 执行，强制 customs-pitfalls 质检，报告写入 ./hunt_result/
```

Codex：

```text
$customs-lead-sop 产品 LED 工矿灯，目标德国/波兰，先确认 HS 再做市场分层与采购商评分
```

OpenClaw：加载 skill 后下达同样任务；可选 `agent.json` 作为 Agent 配置模板。

---

## 目录结构

```text
customs-data-skills/
├── README.md
├── LICENSE
├── AGENTS.md                 # 跨运行时操作手册（Codex / OpenClaw 常读）
├── agent.json                # OpenClaw 风格 Agent 配置模板
├── install.ps1 / install.sh
└── skills/
    ├── customs-lead-sop/
    │   ├── SKILL.md
    │   ├── agents/openai.yaml
    │   ├── references/tools.md
    │   ├── references/scorecard.md
    │   └── examples/pet-products.md
    └── customs-pitfalls/
        ├── SKILL.md
        ├── agents/openai.yaml
        └── references/system-prompt.md
```

符合 [Agent Skills](https://agents.md/) / OpenClaw `SKILL.md` 约定：YAML frontmatter + 正文；OpenClaw 可用 `{baseDir}`；支持 `metadata.openclaw`。

---

## 与付费数据平台的关系

本 Skill **不绑定**任何付费海关库。文中工具（ImportYeti、Comtrade、UK Trade Info 等）为公开/半公开入口示例；免费额度与页面会变，以官网为准。你已有付费账号时，把同一 SOP 套到你的数据源即可。

---

## 合规

- 仅使用公开贸易 / 提单 / 统计与公开网页  
- **不自动群发邮件**；只产出草稿  
- 开发信禁止暴露「查了你们海关数据」  
- 不做绕过登录墙、伪造官方名单、承诺审核通过等行为  

---

## 贡献

见 [CONTRIBUTING.md](./CONTRIBUTING.md)。欢迎补充国家工具、评分案例与多语言开发信红线。
