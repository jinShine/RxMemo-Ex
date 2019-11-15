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

    let willShowObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
      .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0 }

    let willHideObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
      .map { noti -> CGFloat in return 0 }

    let keyboardObservable = Observable.merge(willShowObservable, willHideObservable).share()
    keyboardObservable
      .toContentInset(of: contentTextView)
      .bind(to: contentTextView.rx.contentInset)
      .disposed(by: rx.disposeBag)

    keyboardObservable
      .toContentInset(of: contentTextView)
      .bind(to: contentTextView.rx.scrollInset)
      .disposed(by: rx.disposeBag)

  }
}

// CGFloat만 방출하는 Observable을 뜻한다.
extension ObservableType where Element == CGFloat {
  func toContentInset(of textView: UITextView) -> Observable<UIEdgeInsets> {
    return map { height in
      var inset = textView.contentInset
      inset.bottom = height
      return inset
    }
  }
}


/*

 .subscribe(onNext: { [weak self] height in
   guard let self = self else { return }

   var inset = self.contentTextView.contentInset
   inset.bottom = height

   var scrollInset = self.contentTextView.scrollIndicatorInsets
   scrollInset.bottom = height

   UIView.animate(withDuration: 0.3) {
     self.contentTextView.contentInset = inset
     self.contentTextView.scrollIndicatorInsets = scrollInset
   }
 })

 */

extension Reactive where Base: UITextView {
  var contentInset: Binder<UIEdgeInsets> {
    return Binder(self.base) { (textView, inset) in
      textView.contentInset = inset
    }
  }

  var scrollInset: Binder<UIEdgeInsets> {
    return Binder(self.base) { (textView, inset) in
      textView.scrollIndicatorInsets = inset
    }
  }
}
