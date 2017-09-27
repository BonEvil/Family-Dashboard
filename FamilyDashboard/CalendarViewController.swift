//
//  CalendarViewController.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/26/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
        case closeButton:self.dismiss(animated: true, completion: nil)
        default:break
        }
    }
    
}
