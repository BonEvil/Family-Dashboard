//
//  CheckboxTableViewCell.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/28/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import UIKit

class CheckboxTableViewCell: UITableViewCell {
    
    typealias CheckboxCallback = () -> ()
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var itemLabel: UILabel!
    
    private var checkboxCallback:CheckboxCallback?
    
    var onImage:UIImage?
    var offImage:UIImage?
    var isChecked:Bool! {
        didSet {
            if isChecked {
                checkboxButton.setImage(onImage, for: .normal)
            } else {
                checkboxButton.setImage(offImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isChecked = false
        checkboxButton.addTarget(self, action: #selector(tryCallback), for: .touchUpInside)
    }

    func bindAction(callback:@escaping CheckboxCallback) {
        checkboxCallback = callback
    }
    
    func tryCallback() {
        if let cb = checkboxCallback {
            cb()
        }
    }
}
