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

    addButton.rx.action = viewModel.makeCreateAction()

    Observable.zip(listTableView.rx.modelSelected(Memo.self),
                   listTableView.rx.itemSelected)
      .do(onNext: { [weak self] (_, indexPath) in
        self?.listTableView.deselectRow(at: indexPath, animated: true)
      })
      .map { $0.0 }
      .bind(to: viewModel.detailAction.inputs)
      .disposed(by: rx.disposeBag)

    listTableView.rx.modelDeleted(Memo.self)
      .bind(to: viewModel.deleteAction.inputs)
      .disposed(by: rx.disposeBag)

  }
}
