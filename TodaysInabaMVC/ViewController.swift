//
//  ViewController.swift
//  TodaysInaba
//
//  Created by 深瀬 貴将 on 2020/09/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateTextField.delegate = self
        dateTextField.returnKeyType = .done
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
    }


}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if !(dateTextField.text?.isEmpty ?? true) && !(nameTextField.text?.isEmpty ?? true) {
            print("日付と名前両方の入力が完了しました")
            
            let storyboard: UIStoryboard = UIStoryboard(name: "ResultViewController", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
        
        return true
    }
}

