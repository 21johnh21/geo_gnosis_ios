//
//  ViewControler.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//

import Foundation
import UIKit

class ViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = LocationData().locations
        
        print(data)
    }
    
}
