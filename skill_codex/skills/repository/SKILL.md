---
name: repository
description: 在 wasai iOS 中创建或修改 `AAA/AAMServices/Sources/Repositories/` 下的 Repository（含 actor 状态、APIPath 请求、错误处理、分页/缓存、Dependency 注入接线）。当用户要求新增某业务 Repository、扩展现有 Repository 方法、统一 Repository 风格或修复 Repository 并发/数据状态问题时使用。
---

# Repository

## Overview

实现与现有 AAMServices 一致的 Repository：基于 `actor` 的并发安全、清晰的 API 请求封装、稳定的错误与数据校验、以及可维护的依赖注入接线。
按“先对齐模式，再落代码，再做回归检查”的顺序执行，避免风格漂移。

## Workflow

1. 识别目标与边界：
- 确认是新增 Repository 还是扩展已有 Repository。
- 明确目标文件位于 `AAA/AAMServices/Sources/Repositories/<Domain>/`。
- 明确是否需要维护内部状态（列表、分页标记、缓存副本）。

2. 对齐目录内现有实现：
- 参考同领域或相邻领域 Repository 的 `actor`、方法命名、错误抛出方式。
- 优先复用已有 `APIPath`、`APIParameter` 组合方式，避免引入新命名体系。

3. 实现请求与响应处理：
- 使用 `WSResponse<T>` 或 `APIResponseNoData`。
- 优先检查 `response.serverError` 或 `response.isError`（按该文件既有风格）。
- 对 `response.data` 进行 `guard let` 校验，缺失时抛出 `RepositoryError.responseDataNil` 或该域错误。

4. 处理状态、缓存与通知：
- 若 Repository 持有本地状态，使用 `public private(set)` 暴露只读状态。
- 缓存写入优先放在 `Task(priority: .utility)`。
- 需要触发 UI/全局状态变更时，在 `MainActor` 或既有通知封装中发送。

5. 补齐依赖注入接线（如项目已有该模式）：
- 提供 `static let live/liveValue`。
- 定义 `DependencyKey`。
- 在 `DependencyValues` 增加属性访问器。

6. 执行回归检查：
- 新增/修改方法可被调用方接入。
- 分页/缓存/去重逻辑行为与预期一致。
- 错误路径不崩溃。

## Implementation Rules

- 保持 `public actor <Name>Repository` 结构，不改成 `class` 或 `struct`。
- 在同一个 Repository 内保持一致的错误模型；不要混用多套无关错误语义。
- 避免 `as!` 和不安全解包。
- 复用已有常量与参数构造（如 `.pageSize`, `.cursor`, `.userId` 等）。
- 涉及分页时，显式维护“是否还有更多数据”的状态字段。

## Patterns Reference

需要代码模板、错误处理片段或分页/缓存实现时，读取：
- `references/repository-patterns.md`

## Done Criteria

- Repository 文件与当前目录风格一致（命名、错误、并发模型）。
- 关键请求路径具备 `serverError`/`isError` 与 `data nil` 防御。
- 若使用状态缓存或分页，状态字段与更新时机正确。
- 若需要依赖注入，`DependencyValues` 接线完整。
