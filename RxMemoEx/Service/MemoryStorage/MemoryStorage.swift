//
//  MemoryStorage.swift
//  RxMemoEx
//
//  Created by Seungjin on 11/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import RxSwift

final class MemoryStorage: MemoStorageType {

  private var list = [
    Memo(content: "Hello, RxSwift", insertDate: Date().addingTimeInterval(-10)),
    Memo(content: "Lorem Ipsum", insertDate: Date().addingTimeInterval(-20))
  ]

  private lazy var sectionModel = MemoSectionModel(model: 0, items: list)
  private lazy var store = BehaviorSubject<[MemoSectionModel]>(value: [sectionModel])

  @discardableResult
  func createMemo(content: String) -> Observable<Memo> {
    let memo = Memo(content: content)
    sectionModel.items.insert(memo, at: 0)

    store.onNext([sectionModel])

    return Observable.just(memo)
  }

  @discardableResult
  func memoList() -> Observable<[MemoSectionModel]> {
    return store
  }

  @discardableResult
  func update(memo: Memo, content: String) -> Observable<Memo> {
    let updated = Memo(original: memo, updatedContent: content)

    if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
      sectionModel.items.remove(at: index)
      sectionModel.items.insert(updated, at: index)
    }

    store.onNext([sectionModel])

    return Observable.just(updated)
  }

  @discardableResult
  func delete(memo: Memo) -> Observable<Memo> {
    if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
      sectionModel.items.remove(at: index)
    }

    store.onNext([sectionModel])

    return Observable.just(memo)
  }
}
