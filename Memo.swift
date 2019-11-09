//
//  Memo.swift
//  RxMemoEx
//
//  Created by seungjin on 2019/11/09.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

struct Memo: Equatable {
  var content: String
  var insertDate: Date
  var identity: String
  
  init(content: String, insertDate: Date = Date()) {
    self.content = content
    self.insertDate = insertDate
    self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
  }
  
  init(original: Memo, updatedContent: String) {
    self = original
    self.content = updatedContent
  }
}
