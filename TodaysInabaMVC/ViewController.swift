//
//  ViewController.swift
//  TodaysInaba
//
//  Created by 深瀬 貴将 on 2020/09/27.
//

import UIKit
import Moya
import PKHUD

class ViewController: UIViewController {
    var randomQuery = ["かわいい", "たまらん", "おしり", "シュール", "笑顔"]
    var toolBar = UIToolbar()
    var datePicker = UIDatePicker()

    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateTextField.delegate = self
        dateTextField.returnKeyType = .done
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
        
        setupToolBar()
        setupDatePicker()
    }

    func searchRequest() {
        
        HUD.show(.progress)
        
        //APIリクエスト
        let provider = MoyaProvider<API>()
        provider.request(
            .CustomSearch(
                query: "ちみたん" + randomQuery.randomElement()!,
                startIndex: Int.random(in: 1...10))) { (result) in
            
            HUD.hide()
            
            switch result {
            case let .success(moyaResponse):
                do {
                    self.nameTextField.text = ""
                    
                    let googleData = try! JSONDecoder().decode(GoogleData.self, from: moyaResponse.data)
                                        
                    let storyboard: UIStoryboard = UIStoryboard(name: "ResultViewController", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    vc.modalPresentationStyle = .overCurrentContext
                    
                    vc.resultImageUrl = googleData.items[Int.random(in: 0...9)].link
                    
                    self.present(vc, animated: true)
                }catch {
                    print("error")
                }
            case let .failure(error):
                print(error.localizedDescription)
                
                let alert = UIAlertController(title: "通信に失敗しました。", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "閉じる", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true)
                
                break
            }
        }
    }
    
    func setupToolBar() {
        toolBar.sizeToFit()
        let spacerItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolBar.setItems([spacerItem, doneItem], animated: true)
    }
    
    @objc func done() {
        view.endEditing(true)
    }
    
    func setupDatePicker() {
//        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .compact
            datePicker.frame = dateTextField.frame
            dateTextField.backgroundColor = .clear
            dateTextField.addSubview(datePicker)
            dateTextField.placeholder = ""
//        }
        datePicker.datePickerMode = .date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = .current
        datePicker.tintColor = UIColor(red: 33/255, green: 173/255, blue: 182/255, alpha: 1)
        dateTextField.inputView = datePicker
        dateTextField.inputView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        dateTextField.inputAccessoryView = toolBar
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
//        if #available(iOS 14.0, *) {
            if !(nameTextField.text?.isEmpty ?? true) {
                print("名前の入力が完了しました")
                searchRequest()
            }
//        }else {
//            if !(dateTextField.text?.isEmpty ?? true) && !(nameTextField.text?.isEmpty ?? true) {
//                print("日付と名前両方の入力が完了しました")
//                searchRequest()
//            }
//        }
        
        return true
    }
}

