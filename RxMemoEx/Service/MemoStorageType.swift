//
//  MemoStorageType.swift
//  RxMemoEx
//
//  Created by Seungjin on 11/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import RxSwift

protocol MemoStorageType {
  @discardableResult
  func createMemo(content: String) -> Observable<Memo>

  @discardableResult
  func memoList() -> Observable<[MemoSectionModel]>

  @discardableResult
  func update(memo: Memo, content: String) -> Observable<Memo>

  @discardableResult
  func delete(memo: Memo) -> Observable<Memo>
}
