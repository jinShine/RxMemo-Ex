//
//  SceneCoordinatorType.swift
//  RxMemoEx
//
//  Created by Seungjin on 11/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
  @discardableResult
  func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable

  @discardableResult
  func close(animated: Bool) -> Completable

}
