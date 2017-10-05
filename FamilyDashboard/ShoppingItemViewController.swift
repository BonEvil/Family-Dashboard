//
//  ShoppingItemViewController.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/27/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import UIKit
import DPSessionManager

class ShoppingItemViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var viewModel:ShoppingItemViewModel!
    
    var items:[ShoppingItem]! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        viewModel = ShoppingItemViewModel(callback: { [unowned self](items) in
            self.items = items
        })
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
        case closeButton:self.dismiss(animated: true, completion: nil)
        default:break
        }
    }

}

extension ShoppingItemViewController:UITableViewDelegate {
    
    
}

extension ShoppingItemViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let items = self.items else {
            return 0
        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckboxCell", for: indexPath) as! CheckboxTableViewCell
        
        let currentItem = items[indexPath.row]
        
        cell.itemLabel.text = currentItem.name
        cell.onImage = UIImage(named: "CheckboxOn")
        cell.offImage = UIImage(named: "CheckboxOff")
        cell.isChecked = currentItem.purchased
        cell.bindAction(callback: { [unowned self] in
            self.updateItem(index: indexPath.row)
        })
        
        return cell
    }
    
    func updateItem(index:Int) {
        if let id = items[index].id, let purchased = items[index].purchased {
            let service = PutShoppingItemService(id: id, puchased: !purchased)
            DPSessionManager.sharedInstance().start(service) { [unowned self](err, resp) in
                if let error = err {
                    print("error updating item: "+error.localizedDescription)
                } else {
                    self.items[index].purchased = !purchased
                    self.viewModel.sortItems(items: self.items)
                }
            }
        }
    }
}
