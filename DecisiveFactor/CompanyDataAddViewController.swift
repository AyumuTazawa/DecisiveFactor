//
//  CompanyDataAddViewController.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/30.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit
import Firebase

class CompanyDataAddViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
     var database: Firestore!
    
    @IBOutlet weak var addCompanyNameTextField: UITextField!
    @IBOutlet weak var addIndustryTextField: UITextField!
    @IBOutlet weak var addOverviewTextView: UITextView!
    @IBOutlet weak var pickImageView: UIImageView!
    
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
    @IBAction func selectImage(_ sender: Any) {
        let picker = UIImagePickerController() 
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
        self.present(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func returnRootCompanyListContoroller(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rootViewContoroller = storyboard.instantiateViewController(withIdentifier: "rootCompanyListContoroller")
        UIApplication.shared.keyWindow?.rootViewController = rootViewContoroller
    }
    
    @IBAction func addCompanyData(_ sender: Any) {
        let storage = Storage.storage()
        let refrrence = storage.reference(forURL: "gs://decisivefactor-1007c.appspot.com")
        guard let companyImage = pickImageView.image else { return }
        guard let upimage = companyImage.jpegData(compressionQuality: 0.3) else { return }
        let imageName = NSUUID().uuidString
        let storegeRef = Storage.storage().reference().child("companyImage").child(imageName)
        storegeRef.putData(upimage, metadata: nil) { (metadata, err) in
            if let err = err {
                print("Firestorageへの追加に失敗しました")
            } else {
                print("Firesotrageへの追加に成功しました")
                storegeRef.downloadURL { (url, err) in
                    if let err = err {
                        print("Firestorへの追加に失敗しました")
                    } else {
                        
                        let addcompanyname = self.addCompanyNameTextField.text!
                        let addindustry = self.addIndustryTextField.text!
                        let addoverview = self.addOverviewTextView.text!
                        guard let addcompanyImageUrl = url?.absoluteString else { return }
                        let saveCompanyData = Firestore.firestore().collection("companies").document()
                        saveCompanyData.setData(["companyName": addcompanyname, "industry": addindustry, "overview": addoverview, "postID": saveCompanyData.documentID, "companyImageUrl": addcompanyImageUrl]) { (error) in
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
            }
        }
        
    }
    
    // 画像が選択された時に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        if let selectedImage = info[.originalImage] as? UIImage {
            pickImageView.image = selectedImage  //imageViewにカメラロールから選んだ画像を表示する
            
        }
        self.dismiss(animated: true)  //画像をImageViewに表示したらアルバムを閉じる
    }
    
    // 画像選択がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}



