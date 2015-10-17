//
//  Tab_Bar_Controller.swift
//  miltonmobileios
//
//  Created by Ravi Rahman on 10/17/15.
//  Copyright © 2015 Milton Academy. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.init(netHex: 0x004685);
    }
}