//
//  CompanyDataAddViewController.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/30.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit
import Firebase

class CompanyDataAddViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var addCompanyNameTextField: UITextField!
    @IBOutlet weak var addIndustryTextField: UITextField!
    var database: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Firestore.firestore()
        addIndustryTextField.delegate = self
        addCompanyNameTextField.delegate = self
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addCompanyNameTextField.resignFirstResponder()
        addIndustryTextField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func returnRootCompanyListContoroller(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rootViewContoroller = storyboard.instantiateViewController(withIdentifier: "rootCompanyListContoroller")
        UIApplication.shared.keyWindow?.rootViewController = rootViewContoroller
    }
    
    @IBAction func addCompanyData(_ sender: Any) {
        let addcompanyname = addCompanyNameTextField.text!
        let addindustry = addIndustryTextField.text!
        let saveCompanyData = Firestore.firestore().collection("Companies").document()
        saveCompanyData.setData(["companyName": addcompanyname, "industry": addindustry, "postID": saveCompanyData.documentID]) { (error) in
            if let error = error {
                print("Companydataの追加に失敗しました")
            } else {
                print("Companydataの追加に成功しました")
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let rootViewContoroller = storyboard.instantiateViewController(withIdentifier: "rootCompanyListContoroller")
                UIApplication.shared.keyWindow?.rootViewController = rootViewContoroller
            }
        }
        
    }
}



