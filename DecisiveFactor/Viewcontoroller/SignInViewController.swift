//
//  SignInViewController.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/30.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn



class SignInViewController: UIViewController, GIDSignInDelegate {
    
    var database: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Firestore.firestore()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
    }
    
    @IBAction func googleAction(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        let authentication = user.authentication
        let name = user.profile.name
        let email = user.profile.email
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!,accessToken: (authentication?.accessToken)!)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            
            print("google認証成功")
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            
            let userData = ["name": name, "email": email, "userId": uid]
            
            Firestore.firestore().collection("users").document(uid).setData(userData) { (error) in
                if let error = error {
                    print("Firestoreへの追加に失敗しました")
                } else {
                    print("Firestoreへの追加に成功しました")
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let rootViewContoroller = storyboard.instantiateViewController(withIdentifier: "rootCompanyListContoroller")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewContoroller
                }
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Sign off successfully")
    }
}


