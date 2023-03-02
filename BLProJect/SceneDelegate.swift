//
//  SceneDelegate.swift
//  BLProJect
//
//  Created by 김도현 on 19/07/2020.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import KakaoSDKAuth
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts : Set<UIOpenURLContext>){
        
        //카카오 로그인 URL 값으로 호출
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
                
            }
        }
        
        //구글 로그인 스킴값으로 호출
//        if let url = URLContexts.first?.url.scheme{
//            if url.contains("com.googleusercontent.apps") {
//                GIDSignIn.sharedInstance()?.handle(URLContexts.first?.url)
//            }
//        }
        
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            let RootView = UIStoryboard(name: "Main", bundle: nil)
            let initalViewController = RootView.instantiateViewController(identifier: "MainView")
            let NavigationView = UINavigationController(rootViewController: initalViewController)
            self.window?.rootViewController = NavigationView
            self.window?.makeKeyAndVisible()
        }
        
        
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

