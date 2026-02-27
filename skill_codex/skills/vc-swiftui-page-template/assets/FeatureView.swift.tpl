//
//  {{FEATURE_NAME}}View.swift
//  AAAFeatures
//
//  Created by d on {{DATE}}.
//

import AAGComponents
import AAMServices
import Dependencies
import SwiftUI

struct {{FEATURE_NAME}}View: View {
  @ObservedObject var viewModel: {{FEATURE_NAME}}ViewModel

  var onBack: (() -> Void)?

  init(viewModel: {{FEATURE_NAME}}ViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    Text("{{FEATURE_NAME}}View")
  }
}
