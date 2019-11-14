//
//  MemoComposeViewController.swift
//  RxMemoEx
//
//  Created by Seungjin on 11/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MemoComposeViewController: UIViewController, ViewModelBindableType {

  var viewModel: MemoComposeViewModel!

  @IBOutlet weak var cancelButton: UIBarButtonItem!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var contentTextView: UITextView!

  override func viewDidLoad() {
      super.viewDidLoad()


  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    contentTextView.becomeFirstResponder()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    if contentTextView.isFirstResponder {
      contentTextView.resignFirstResponder()
    }
  }


  func bindViewModel() {
    viewModel.title
      .drive(navigationItem.rx.title)
      .disposed(by: rx.disposeBag)

    viewModel.initialText
      .drive(contentTextView.rx.text)
      .disposed(by: rx.disposeBag)

    cancelButton.rx.action = viewModel.cancelAction

    saveButton.rx.tap
      .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
      .withLatestFrom(contentTextView.rx.text.orEmpty)
      .bind(to: viewModel.saveAction.inputs)
      .disposed(by: rx.disposeBag)
  }
}
