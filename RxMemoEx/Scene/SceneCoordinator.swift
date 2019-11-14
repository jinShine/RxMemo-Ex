//
//  SceneCoordinator.swift
//  RxMemoEx
//
//  Created by Seungjin on 11/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SceneCoordinator: SceneCoordinatorType {

  private let bag = DisposeBag()

  private var window: UIWindow
  private var currentViewController: UIViewController

  init(window: UIWindow) {
    self.window = window
    currentViewController = window.rootViewController!
  }

  @discardableResult
  func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
    let subject = PublishSubject<Void>()

    let target = scene.instantiate()

    switch style {
    case .root:
      currentViewController = target
      window.rootViewController = target
      subject.onCompleted()

    case .push:
      guard let nav = currentViewController.navigationController else {
        subject.onError(TransitionError.navigationControllerMissing)
        break
      }

      nav.pushViewController(target, animated: animated)
      currentViewController = target
      subject.onCompleted()

    case .modal:
      currentViewController.present(target, animated: animated) {
        subject.onCompleted()
      }
      
      currentViewController = target
    }

    return subject.ignoreElements()
  }

  @discardableResult
  func close(animated: Bool) -> Completable {
    return Completable.create { [weak self] completable -> Disposable in

      if let presentingVC = self?.currentViewController.presentingViewController {
        self?.currentViewController.dismiss(animated: animated, completion: {
          self?.currentViewController = presentingVC
          completable(.completed)
        })
      } else if let nav = self?.currentViewController.navigationController {
        guard nav.popViewController(animated: animated) != nil else {
          completable(.error(TransitionError.cannotPop))
          return Disposables.create()
        }
        self?.currentViewController = nav.viewControllers.last!
        completable(.completed)
      } else {
        completable(.error(TransitionError.unknown))
      }

      return Disposables.create()
    }
  }
}
