# specbios-recovery-demo

这是一个内置在 SpecBIOS Claude Code Plugin 仓库中的示例项目，用来演示插件如何在长期项目中恢复上下文。

## 已演示内容
- `.specbios.json` 作为恢复配置中心
- `CLAUDE.md` 作为稳定恢复协议
- `.claude/specbios-session.local.md` 作为短期会话交接文件
- `docs/05-live-task-board.md` 的机器可解析任务区作为唯一任务真相源

## 推荐演示步骤
1. 进入本目录
2. 启动 Claude Code 并加载本插件
3. 观察 SessionStart 的恢复摘要
4. 运行 `/specbios-task-list`
5. 运行 `/specbios-dispatch` 继续下一任务
