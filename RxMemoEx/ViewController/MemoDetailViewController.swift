//
//  MemoDetailViewController.swift
//  RxMemoEx
//
//  Created by Seungjin on 11/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class MemoDetailViewController: UIViewController, ViewModelBindableType {

  var viewModel: MemoDetailViewModel!

  @IBOutlet weak var listTableView: UITableView!
  @IBOutlet weak var deleteButton: UIBarButtonItem!
  @IBOutlet weak var editButton: UIBarButtonItem!
  @IBOutlet weak var shareButton: UIBarButtonItem!

  override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
  }

  func bindViewModel() {
    
  }
}
