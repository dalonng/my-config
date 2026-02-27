//
//  {{FEATURE_NAME}}HostingController.swift
//  AAAFeatures
//
//  Created by d on {{DATE}}.
//

import Foundation
import SwiftUI
import UIKit

final class {{FEATURE_NAME}}HostingController: UIHostingController<{{FEATURE_NAME}}View> {
  var viewController: UIViewController?

  init(viewModel: {{FEATURE_NAME}}ViewModel) {
    super.init(rootView: {{FEATURE_NAME}}View(viewModel: viewModel))

    rootView.onBack = { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
