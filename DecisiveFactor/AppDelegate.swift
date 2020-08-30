//
//  AppDelegate.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/30.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = "794466506951-qkgpl2i349sm0uv02hv7pmklqeug2scu.apps.googleusercontent.com"
        
        /*ログインを判断
        let ud = UserDefaults.standard
        let isLogin = ud.bool(forKey: "isLogin")
        if isLogin == true {
            //ログイン中だったら
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyBorad = UIStoryboard(name: "Main", bundle: Bundle.main)
            let roodViewContorollre = storyBorad.instantiateViewController(withIdentifier: "rootCompanyListContoroller")
            self.window?.rootViewController = roodViewContorollre
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
            
        } else {
            //ログインしていなかったら
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyBorad = UIStoryboard(name: "SignInStoryboard", bundle: Bundle.main)
            let roodViewContorollre = storyBorad.instantiateViewController(withIdentifier: "SignInViewContoroller")
            self.window?.rootViewController = roodViewContorollre
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
            
        }*/
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

