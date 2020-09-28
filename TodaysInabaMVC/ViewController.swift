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
        
        
        
        //APIリクエスト
        let provider = MoyaProvider<API>()
        provider.request(
            .CustomSearch(
                query: "ちみたん" + randomQuery.randomElement()!,
                startIndex: Int.random(in: 1...10))) { (result) in
            switch result {
            case let .success(moyaResponse):
                do {
                    let _googleData = try! JSONDecoder().decode(GoogleData.self, from: moyaResponse.data)
                                        
                    let storyboard: UIStoryboard = UIStoryboard(name: "ResultViewController", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                    vc.modalPresentationStyle = .overCurrentContext
                    
                    vc.resultImageUrl = _googleData.items[Int.random(in: 0...9)].link
                    
                    self.present(vc, animated: true)
                }catch {
                    print("error")
                }
            case let .failure(error):
                print(error.localizedDescription)
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
        datePicker.datePickerMode = .date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = .current
        dateTextField.inputView = datePicker
        dateTextField.inputView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        dateTextField.inputAccessoryView = toolBar
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if !(dateTextField.text?.isEmpty ?? true) && !(nameTextField.text?.isEmpty ?? true) {
            print("日付と名前両方の入力が完了しました")
            
            searchRequest()
        }
        
        return true
    }
}

