//
//  ResultViewController.swift
//  TodaysInabaMVC
//
//  Created by 深瀬 貴将 on 2020/09/27.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
