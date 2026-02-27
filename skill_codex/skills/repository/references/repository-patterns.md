# Repository Patterns (AAMServices)

## 1. Actor Skeleton

```swift
import AANModels
import AARInfra
import ErrorKit
import Foundation

public actor ExampleRepository {
  public private(set) var items: [ExampleItem] = []

  public init() {}
}
```

## 2. WSResponse Request Pattern

```swift
@discardableResult
public func fetchItems(userId: Int) async throws -> [ExampleItem] {
  let params: [APIParameter] = [.userId(userId)]
  let response: WSResponse<[ExampleItem]> = try await APIPath.Example.items.get(parameters: params)

  if let error = response.serverError {
    throw error
  }

  guard let data = response.data else {
    throw RepositoryError.responseDataNil
  }

  items = data
  return data
}
```

## 3. APIResponseNoData Pattern

```swift
public func saveFavorite(_ id: Int) async throws {
  let response: APIResponseNoData = try await APIPath.Example.save.post(.id(id))
  if let error = response.serverError {
    throw error
  }
}
```

## 4. Domain Error Wrapping Pattern

适用于领域内统一抛错（例如 `HomeError`、`RepositoryError`）的场景。

```swift
public func fetchDetail(id: Int) async throws(HomeError) -> Detail {
  do {
    let response: WSResponse<Detail> = try await APIPath.Example.detail.get(.id(id))
    guard let data = response.data else {
      throw HomeError.responseDataNil
    }
    return data
  } catch {
    throw HomeError.caught(error)
  }
}
```

## 5. Pagination State Pattern

```swift
public private(set) var list: [ExampleItem] = []
private var pageData: ExamplePageData?

public var hasMore: Bool {
  guard let pageData else { return false }
  return pageData.current < pageData.pages
}

public func fetch() async throws -> [ExampleItem] {
  pageData = nil
  let data = try await fetchPage(page: 1)
  pageData = data
  list = data.records
  return list
}

public func fetchMore() async throws -> [ExampleItem] {
  guard hasMore, let current = pageData?.current else { return list }
  let data = try await fetchPage(page: current + 1)
  pageData = data
  list.append(contentsOf: data.records)
  return list
}
```

## 6. Cache + Notification Pattern

```swift
@Dependency(\.keyValueCache) private var keyValueCache

Task(priority: .utility) {
  await keyValueCache.setSafely(data, forKey: APIPath.Example.items.path)
}

await MainActor.run {
  NotificationKey.didUpdateSomething.post()
}
```

## 7. Dependency Injection Wiring Pattern

```swift
extension ExampleRepository {
  static let live = ExampleRepository()
}

private enum ExampleRepositoryKey: DependencyKey {
  static let liveValue = ExampleRepository.live
}

extension DependencyValues {
  public var exampleRepository: ExampleRepository {
    get { self[ExampleRepositoryKey.self] }
    set { self[ExampleRepositoryKey.self] = newValue }
  }
}
```

## 8. Review Checklist

- 新增请求是否使用正确的 `APIPath` 与参数类型。
- 是否覆盖 `serverError`/`isError` 与 `response.data == nil`。
- 是否错误地在 actor 外直接改动共享状态。
- 分页是否在首次拉取时重置游标/页数据。
- 去重策略是否与业务预期一致（按 `id` 去重或允许重复）。
- 缓存 key 是否稳定且可复用。
