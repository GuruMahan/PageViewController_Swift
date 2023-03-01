//
//  PageViewControllerXIB.swift
//  PageViewControllerPOC
//
//  Created by Guru Mahan on 28/02/23.
//

import UIKit

class DataViewControllerXIB: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    var displayText:String?
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayText
        view.backgroundColor = UIColor(red: 254/255, green: 251/255, blue: 234/255, alpha: 1)
        
        view.roundCorners([.topRight,.bottomRight], radius: 20)
      
    }
  
}
