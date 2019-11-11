//
//  ViewModelBindableType.swift
//  RxMemoEx
//
//  Created by Seungjin on 11/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

protocol ViewModelBindableType {
  associatedtype ViewModelType

  var viewModel: ViewModelType! { get set }
  func bindViewModel()

}

extension ViewModelBindableType where Self: UIViewController {
  mutating func bind(viewModel: Self.ViewModelType) {
    self.viewModel = viewModel
    loadViewIfNeeded()

    bindViewModel()
  }
}
