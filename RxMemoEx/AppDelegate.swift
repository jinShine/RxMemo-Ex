//
//  AppDelegate.swift
//  RxMemoEx
//
//  Created by seungjin on 2019/11/09.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//    let storage = MemoryStorage()
    let storage = CoreDataStorage(modelName: "RxMemoEx")
    let coordinator = SceneCoordinator(window: window!)
    let listViewModel = MemoListViewModel(title: "나의 메모", sceneCoordinator: coordinator, storage: storage)
    let listScene = Scene.list(listViewModel)

    coordinator.transition(to: listScene, using: .root, animated: false)

    return true
  }

//  // MARK: UISceneSession Lifecycle
//
//  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//  }
//
//  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//  }
}
