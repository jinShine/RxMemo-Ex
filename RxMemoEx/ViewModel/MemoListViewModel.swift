//
//  MemoListViewModel.swift
//  RxMemoEx
//
//  Created by Seungjin on 11/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoListViewModel: CommonViewModel {
  var memoList: Observable<[Memo]> {
    return storage.memoList()
  }

  func performUpdate(memo: Memo) -> Action<String, Void> {
    return Action { input in
      return self.storage.update(memo: memo, content: input).map { _ in }
    }
  }

  func performCancel(memo: Memo) -> CocoaAction {
    return Action {
      return self.storage.delete(memo: memo).map { _ in }
    }
  }

  func makeCreateAction() -> CocoaAction {
    return CocoaAction { _ in
      return self.storage.createMemo(content: "")
        .flatMap { memo -> Observable<Void> in
          let composeViewModel = MemoComposeViewModel(title: "새 메모",
                                                      sceneCoordinator: self.sceneCoordinator,
                                                      storage: self.storage,
                                                      saveAction: self.performUpdate(memo: memo),
                                                      cancelAction: self.performCancel(memo: memo))

          let composeScene = Scene.compose(composeViewModel)
          return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map { _ in }
      }
    }
  }

  lazy var detailAction: Action<Memo, Void> = {
    return Action { memo in

      let detailViewModel = MemoDetailViewModel(memo: memo, title: "메모 보기", sceneCoordinator: self.sceneCoordinator, storage: self.storage)

      let detailScene = Scene.detail(detailViewModel)
      return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map { _ in }
    }
  }()

 }
