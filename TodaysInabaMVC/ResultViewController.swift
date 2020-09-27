//
//  ResultViewController.swift
//  TodaysInabaMVC
//
//  Created by 深瀬 貴将 on 2020/09/27.
//

import UIKit
import Kingfisher

class ResultViewController: UIViewController {
    
    var resultImageUrl = String()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.kf.setImage(with: URL(string: resultImageUrl))
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
