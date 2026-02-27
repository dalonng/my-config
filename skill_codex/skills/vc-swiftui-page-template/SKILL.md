---
name: vc-swiftui-page-template
description: 在 wasai iOS 中按 `AAA/AAAFeatures/Sources/HomeNew/` 风格生成新业务页面骨架：`UIViewController` 外壳 + `UIHostingController` + SwiftUI View + ViewModel。用于每次新增业务页面、快速起页、统一新页面结构或替换手写样板代码时。
---

# VC SwiftUI Page Template

## Overview

按 HomeNew 模式一次性创建 4 个文件：`<Feature>ViewController`、`<Feature>HostingController`、`<Feature>View`、`<Feature>ViewModel`。
优先用脚本生成，再只改业务逻辑，避免每次重复手写样板。

## Workflow

1. 确认输入参数：
- `feature_name`：业务名（例如 `ProfileCenter`）。
- `directory_name`（可选）：目标目录名；默认与 `feature_name` 一致。
- `nav_title`（可选）：导航栏标题；默认使用 `feature_name`。

2. 运行脚本生成模板：

```bash
python3 .codex/skills/vc-swiftui-page-template/scripts/create_feature_page.py \
  --feature-name ProfileCenter \
  --directory-name ProfileCenter \
  --nav-title "Profile"
```

3. 检查生成结果：
- `AAA/AAAFeatures/Sources/<directory_name>/` 下应有 4 个 Swift 文件。
- 类名与文件名前缀一致。
- `ViewController` 中包含 `CustomNavigationBarViewController` + `UIHostingController` 组合。

4. 填充业务逻辑：
- 在 `<Feature>View` 中替换占位 UI。
- 在 `<Feature>ViewModel` 中添加业务状态与异步请求。
- 在 `<Feature>HostingController` 中补充路由/回调逻辑（如返回、事件上报）。

## Rules

- 保持 4 文件结构完整，不跳过 HostingController。
- 不要把 SwiftUI View 直接塞进 UIViewController，而是通过 `UIHostingController` 承载。
- 默认保留 `@MainActor` + `ObservableObject` 的 ViewModel 结构。
- 若目标目录已存在，先确认是否允许覆盖；默认不覆盖已有文件。

## Resources

- `scripts/create_feature_page.py`：按参数生成页面骨架。
- `assets/*.swift.tpl`：HomeNew 风格模板文件，脚本会替换占位符。
