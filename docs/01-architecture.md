# 架构设计（SpecBIOS Claude Code Plugin）

## 1. 设计目标

### 核心目标
将 SpecBIOS 的文档驱动工作流无缝集成到 Claude Code 中，提供原生的用户体验。

### 具体目标
1. **零摩擦集成**: 用户无需切换工具，在 Claude Code 中完成所有操作
2. **自动化**: 自动检测项目、加载上下文、更新状态
3. **简单性**: 插件结构简单，易于维护和扩展
4. **兼容性**: 与 SpecBIOS CLI 工具完全兼容，共享相同的文档格式

## 2. 分层架构

### 插件结构

```
specbios-claude-plugin/
├── plugin.json              # 插件清单（元数据）
├── skills/                  # 斜杠命令层
│   ├── init.md             # 项目初始化
│   ├── task-add.md         # 任务管理
│   ├── task-list.md        # 任务查看
│   ├── task-update.md      # 任务更新
│   └── dispatch.md         # 任务调度与执行
└── hooks/                   # 事件钩子层
    └── on-start.md         # 会话启动时自动检测
```

### 三层架构

#### Layer 1: 插件清单层（plugin.json）
- **职责**: 定义插件元数据、注册 skills 和 hooks
- **内容**: 名称、版本、描述、作者、仓库地址
- **格式**: JSON

#### Layer 2: Skills 层（命令实现）
- **职责**: 实现具体的用户命令
- **格式**: Markdown 文件 + Frontmatter
- **执行**: Claude Code 读取 Markdown 指令，由 Claude 执行

**Skills 列表**:
1. `init.md` - 创建 `.specbios.json` 和 `docs/` 结构
2. `task-add.md` - 解析任务板，添加新任务
3. `task-list.md` - 读取并格式化显示任务
4. `task-update.md` - 更新任务状态
5. `dispatch.md` - 读取文档，执行任务，更新状态

#### Layer 3: Hooks 层（自动化）
- **职责**: 在特定事件触发时自动执行
- **触发时机**: 会话启动、目录切换等
- **实现**: `on-start.md` 检测 `.specbios.json` 并提示用户

## 3. 核心工作流

### 工作流 1: 初始化项目

```
用户: /specbios-init
  ↓
Claude 读取 init.md 指令
  ↓
创建 .specbios.json
  ↓
创建 docs/ 目录和模板文件
  ↓
提示用户下一步操作
```

### 工作流 2: 添加任务

```
用户: /specbios-task-add "任务描述"
  ↓
Claude 读取 task-add.md 指令
  ↓
读取 docs/05-live-task-board.md
  ↓
解析现有任务，生成新 ID
  ↓
插入新任务行
  ↓
保存更新后的任务板
```

### 工作流 3: 调度执行（核心流程）

```
用户: /specbios-dispatch
  ↓
Claude 读取 dispatch.md 指令
  ↓
Step 1: 读取 .specbios.json（项目配置）
  ↓
Step 2: 读取 docs/05-live-task-board.md（找到 in_progress 任务）
  ↓
Step 3: 读取上下文文档
  - docs/00-project-dossier.md（项目背景）
  - docs/01-architecture.md（架构约束）
  - docs/03-scope-and-mvp.md（范围边界）
  ↓
Step 4: 执行任务
  - 理解任务需求
  - 遵守架构和范围约束
  - 编写代码/创建文件
  - 测试验证
  ↓
Step 5: 更新任务状态
  - 将任务标记为 [completed]
  - 更新"当前已完成"摘要
  - 提示用户继续下一个任务
```

### 工作流 4: 自动检测（无感知）

```
用户: cd project && claude
  ↓
Claude Code 启动
  ↓
触发 on-start.md hook
  ↓
检查 .specbios.json 是否存在
  ↓
如果存在:
  - 读取项目名称
  - 读取任务板
  - 显示当前状态
  - 建议下一步操作
```

## 4. 关键设计原则

### 原则 1: Markdown 即代码
- **理念**: 所有 skills 都是 Markdown 文件，Claude 读取后执行
- **优势**: 
  - 无需编译或构建
  - 易于阅读和修改
  - 版本控制友好
- **实现**: Frontmatter 定义元数据，正文描述执行逻辑

### 原则 2: 文档是权威
- **理念**: 所有项目信息存储在 `docs/` 中，不依赖外部数据库
- **优势**:
  - 可移植（git clone 即可）
  - 可审查（纯文本）
  - 可版本控制
- **实现**: 任务板、架构、范围都是 Markdown 文件

### 原则 3: 单一职责
- **理念**: 每个 skill 只做一件事
- **优势**:
  - 易于理解
  - 易于测试
  - 易于组合
- **实现**: 
  - `init` 只负责初始化
  - `task-add` 只负责添加任务
  - `dispatch` 负责完整的执行流程

### 原则 4: 自动化优先
- **理念**: 能自动化的就不要手动
- **优势**:
  - 减少用户操作
  - 减少出错
  - 提升体验
- **实现**:
  - Hook 自动检测项目
  - Dispatch 自动读取文档
  - 自动更新任务状态

### 原则 5: 兼容 CLI
- **理念**: 插件和 CLI 共享相同的文档格式
- **优势**:
  - 用户可以混用两种工具
  - 文档可以互通
  - 降低学习成本
- **实现**: 
  - 使用相同的 `.specbios.json` 格式
  - 使用相同的任务板格式
  - 使用相同的文档模板

### 原则 6: 渐进增强
- **理念**: 基础功能先行，高级功能后续添加
- **优势**:
  - 快速发布 MVP
  - 根据反馈迭代
  - 避免过度设计
- **实现**:
  - v1.0: 5 个核心命令
  - v1.1: 错误处理优化
  - v1.2: 依赖分析集成
  - v2.0: GUI 界面

## 5. 技术约束

### Claude Code 插件系统约束
- 插件必须有 `plugin.json` 清单文件
- Skills 必须是 Markdown 文件，带 Frontmatter
- Hooks 必须指定触发条件（trigger）
- 插件可以从 GitHub 或本地目录安装

### 文件系统约束
- 所有文档存储在 `docs/` 目录
- 配置文件是 `.specbios.json`
- 任务板是 `docs/05-live-task-board.md`
- 必须使用 UTF-8 编码

### 执行约束
- Skills 由 Claude 解释执行，不是独立进程
- 无法访问网络（除非通过 Claude 的工具）
- 依赖 Claude Code 的文件读写能力
- 需要用户授权才能修改文件

## 6. 扩展性设计

### 未来可扩展点

#### 1. 更多 Skills
- `/specbios-analyze-deps` - 依赖分析
- `/specbios-recommend-executor` - 执行器推荐
- `/specbios-split-task` - 任务拆分
- `/specbios-export` - 导出报告

#### 2. 更多 Hooks
- `pre-dispatch` - 调度前检查
- `post-task-complete` - 任务完成后通知
- `on-error` - 错误处理

#### 3. 集成其他工具
- MCP Server 集成（访问外部 API）
- LSP Server 集成（代码智能提示）
- Git Hooks 集成（自动提交）

#### 4. 配置增强
- 自定义文档模板
- 自定义任务状态
- 自定义工作流

### 保持简单
虽然有很多扩展可能，但 v1.0 保持最小化：
- 只做核心功能
- 只依赖 Claude Code 基础能力
- 不引入外部依赖
