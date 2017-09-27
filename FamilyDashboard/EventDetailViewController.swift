//
//  EventDetailViewController.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/26/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import UIKit
import EventKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    var event:EKEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let event = self.event {
            print(event)
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
        case closeButton:self.dismiss(animated: true, completion: nil)
        default:break
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
