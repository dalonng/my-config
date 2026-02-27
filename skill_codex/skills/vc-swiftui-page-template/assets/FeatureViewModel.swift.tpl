//
//  {{FEATURE_NAME}}ViewModel.swift
//  AAAFeatures
//
//  Created by d on {{DATE}}.
//

import Foundation

@MainActor
final class {{FEATURE_NAME}}ViewModel: ObservableObject {
  @Published var title: String = "{{FEATURE_NAME}}"

  init() {}
}
