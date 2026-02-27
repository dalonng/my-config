---
name: route-expansion
description: 在 wasai iOS 中新增或修改 AppRouter 路由，确保注册一致、参数校验完善，并完成回归检查。用于新增路由、扩展导航流或将新的 Screen 绑定到 Route 的场景。
---

# 路由扩展

当你处理以下目录下的路由变更时，使用此 skill：
- `wasai/Common/Navigator/Routes`

## 目标产出

交付的路由变更需要满足：
- 已注册，且可从预期入口到达。
- 对异常/缺失参数安全（不崩溃，回退行为明确）。
- 已通过轻量回归检查清单验证。

## 工作流程

1. 确认目标路由形态：
- `makeViewController(params:from:)` 路由：返回用于 push/present 的视图控制器。

2. 检查当前接线关系：
- 检查 `Screen` case 的使用位置与调用方（`push(to: .xxx)` 或 `AppRouter.shared.go(.xxx)`）。
- 检查 `wasai/Common/Navigator/Routes/ARouter.swift` 中的路由注册。

3. 实现路由：
- 在 `wasai/Common/Navigator/Routes` 中新增文件，或更新已有路由。
- 保持职责聚焦：一个路由文件只负责一个导航意图。
- 当目标页面应全屏显示时，设置 `hidesBottomBarWhenPushed = true`。

4. 注册路由：
- 将路由实例加入 `ARouter.swift` 的 `allRoutes`。
- 对于参数化变体（如 `TaskRoute(accessPath: .home/.video/.profile)`），显式注册每个需要的实例。

5. 防御式参数校验：
- 对必填参数做严格类型校验（`as? Int`、`as? Feed` 等）。
- 对非法输入按现有风格返回 `UIViewController()` 或 `nil`（`makeViewController`）。
- 禁止对路由参数使用强制转换（`as!`）。
- 若路径需要登录，导航前必须做鉴权拦截。

6. 如任务包含调用方改造，需同步接线：
- 更新调用方，确保传入完整参数。
- 参数 key 命名保持稳定，并与路由文件一致。

## 路由模板

```swift
import AAGComponents
import AANModels
import AARInfra
import Foundation

final class ExampleRoute: Route {
  var screen: Screen { .example }

  func makeViewController(params: [String: Any]?, from: UIViewController?) -> UIViewController {
    guard let id = params?["id"] as? Int else { return UIViewController() }
    let vc = ExampleViewController(id: id)
    vc.hidesBottomBarWhenPushed = true
    return vc
  }
}
```

## 参数校验清单

- 必填参数在使用前已完成 guard 校验。
- 可选参数有明确默认值。
- 类型转换显式且安全。
- 非法参数有确定性回退（no-op、空 VC 或 `nil`）。
- 需鉴权路径在 push/present 前强制登录校验。

## 回归检查清单

- 路由改动后可成功编译。
- 路由已出现在 `ARouter.swift` 注册列表中。
- 入口调用（`push`）可到达预期页面。
- 非法/缺失参数不会导致崩溃。
- 登录门禁路径在已登录与未登录状态下行为正确。
- 底部栏显隐符合产品预期。
- 邻近已有路由仍正常（至少做一条相关链路冒烟检查）。

## 完成标准

以下条件全部满足，路由任务才算完成：
- 代码改动已落地，且注册已接通。
- 已具备防御式参数处理。
- 回归清单已执行，或阻塞项已明确说明。
