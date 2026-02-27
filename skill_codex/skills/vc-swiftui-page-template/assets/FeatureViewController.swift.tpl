//
//  {{FEATURE_NAME}}ViewController.swift
//  AAAFeatures
//
//  Created by d on {{DATE}}.
//

import AAGComponents
import Align
import SwiftUI
import UIKit

final class {{FEATURE_NAME}}ViewController: CustomNavigationBarViewController {
  private let navigationBar = BackNavigationBar(title: "{{NAV_TITLE}}")
  private let hostingController: {{FEATURE_NAME}}HostingController

  var viewController: UIViewController?

  @objc func forceEnableInteractivePopGestureRecognizer() -> Bool {
    true
  }

  init(viewModel: {{FEATURE_NAME}}ViewModel) {
    hostingController = {{FEATURE_NAME}}HostingController(viewModel: viewModel)
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    addCustomNavigationBar(navigationBar)
    setupHostingController()
  }

  private func setupHostingController() {
    hostingController.viewController = viewController

    addChild(hostingController)
    view.addSubview(hostingController.view)
    hostingController.didMove(toParent: self)

    hostingController.view.anchors.top.equal(navigationBar.anchors.bottom)
    hostingController.view.anchors.leading.pin()
    hostingController.view.anchors.trailing.pin()
    hostingController.view.anchors.bottom.pin()

    let leftView = UIView()
    view.addSubview(leftView)
    leftView.anchors.top.equal(navigationBar.anchors.bottom)
    leftView.anchors.leading.pin()
    leftView.anchors.bottom.pin()
    leftView.anchors.width.equal(16)
  }
}
