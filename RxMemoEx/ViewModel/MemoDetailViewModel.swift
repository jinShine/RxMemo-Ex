//
//  MemoDetailViewModel.swift
//  RxMemoEx
//
//  Created by Seungjin on 11/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoDetailViewModel: CommonViewModel {
  let memo: Memo

  private var formatter: DateFormatter = {
    let f = DateFormatter()
    f.locale = Locale(identifier: "Ko_kr")
    f.dateStyle = .medium
    f.timeStyle = .medium
    return f
  }()

  var contents: BehaviorSubject<[String]>

  init(memo: Memo, title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
    self.memo = memo

    contents = BehaviorSubject<[String]>(value: [
      memo.content,
      formatter.string(from: memo.insertDate)
    ])

    super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
  }

  lazy var popAction = CocoaAction { _ in
    return self.sceneCoordinator.close(animated: true).asObservable().map{ _ in }
  }
}
