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

class MemoListViewModel: CommonViewModel {
  var memoList: Observable<[Memo]> {
    return storage.memoList()
  }
}
