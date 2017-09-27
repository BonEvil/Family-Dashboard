//
//  SettingsViewController.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/27/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
        case cancelButton:self.dismiss(animated: true, completion: nil)
        default:break
        }
    }
}
