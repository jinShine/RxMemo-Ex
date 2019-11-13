//
//  MemoListViewController.swift
//  RxMemoEx
//
//  Created by Seungjin on 11/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {

  var viewModel: MemoListViewModel!
  @IBOutlet weak var listTableView: UITableView!
  @IBOutlet weak var addButton: UIBarButtonItem!

  override func viewDidLoad() {
      super.viewDidLoad()



  }

  func bindViewModel() {
    viewModel.title
      .drive(navigationItem.rx.title)
      .disposed(by: rx.disposeBag)

    viewModel.memoList
      .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { row, memo, cell in
        cell.textLabel?.text = memo.content
      }
    .disposed(by: rx.disposeBag)
  }
}
