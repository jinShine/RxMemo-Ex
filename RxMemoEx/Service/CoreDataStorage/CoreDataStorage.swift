//
//  CoreDataStorage.swift
//  RxMemoEx
//
//  Created by Seungjin on 15/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxCoreData
import CoreData

class CoreDataStorage: MemoStorageType {

  let modelName: String

  init(modelName: String) {
    self.modelName = modelName
  }

  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: self.modelName)
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
  }()

  private var mainContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }

  @discardableResult
  func createMemo(content: String) -> Observable<Memo> {
    let memo = Memo(content: content)

    do {
      _ = try mainContext.rx.update(memo)
      return Observable.just(memo)
    } catch {
      return Observable.error(error)
    }
  }

  @discardableResult
  func memoList() -> Observable<[MemoSectionModel]> {
    mainContext.rx.entities(Memo.self, predicate: nil, sortDescriptors: [NSSortDescriptor(key: "insertDate", ascending: false)])
      .map { [MemoSectionModel(model: 0, items: $0)] }
  }

  @discardableResult
  func update(memo: Memo, content: String) -> Observable<Memo> {
    let updated = Memo(original: memo, updatedContent: content)

    do {
      _ = try mainContext.rx.update(updated)

      return Observable.just(updated)
    } catch {
      return Observable.error(error)
    }
  }

  @discardableResult
  func delete(memo: Memo) -> Observable<Memo> {
    do {
      _ = try mainContext.rx.delete(memo)
      return Observable.just(memo)
    } catch {
      return Observable.error(error)
    }
  }

}
