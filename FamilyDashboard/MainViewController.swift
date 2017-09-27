//
//  MainViewController.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/25/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import UIKit
import EventKit

class MainViewController: UIViewController {

    @IBOutlet weak var weatherWebView: UIWebView!
    @IBOutlet weak var eventTableView: UITableView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var shoppingButton: UIButton!
    @IBOutlet weak var dinnerButton: UIButton!
    @IBOutlet weak var toDoButton: UIButton!
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var trafficButton: UIButton!
    
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    let formatter = DateFormatter()
    let timeFormatString = "h:mm:ss a"
    let dateFormatString = "EEEE, MMMM dd, YYYY"
    
    var location:CLLocation?
    var eventIndex:Int = -1
    
    var mainModel = MainViewModel(name: "Alpharetta, GA")
    
    var events:[EKEvent]! {
        didSet {
            self.eventTableView.reloadData()
        }
    }
    
    var weatherHTML:String! {
        didSet {
            weatherWebView.loadHTMLString(weatherHTML, baseURL: nil)
        }
    }
    
    var time:String! {
        didSet {
            timeLabel.text = time
        }
    }
    
    var date:String! {
        didSet {
            dateLabel.text = date
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableView.delegate = self;
        eventTableView.dataSource = self;
        weatherWebView.delegate = self
        
        mainModel.bindWeatherHTML { [unowned self](html,location) in
            self.weatherHTML = html
            self.location = location
        }
        
        mainModel.bindTime { [unowned self](time) in
            self.time = time
        }
        
        mainModel.bindDate { [unowned self](date) in
            self.date = date
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainModel.bindEvents(callback: { [unowned self](events) in
            self.events = events
        })
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
        case calendarButton:break
        case settingsButton:break
        case shoppingButton:break
        case dinnerButton:break
        case toDoButton:break
        case notesButton:break
        case homeButton:break
        case trafficButton:break
        default:break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, let location = self.location {
            switch id {
            case "showTrafficView":
                let dest = segue.destination as! TrafficViewController
                dest.location = location
            case "showEventDetailView":
                let dest = segue.destination as! EventDetailViewController
                dest.event = events[eventIndex]
            case "showCalendarView":break
            default:break
            }
        }
    }
}

extension MainViewController: UIWebViewDelegate {
    
//    func webViewDidStartLoad(_ webView: UIWebView) {
//        print("loading webview")
//    }
//    
//    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
//        print("error loading webviw: "+error.localizedDescription)
//    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        
        let currenEvent = events[indexPath.row]
        cell.titleLabel.text = currenEvent.title
        if let todayDate = dateLabel.text {
            formatter.dateFormat = dateFormatString
            let currentEventDate = formatter.string(from: currenEvent.startDate)
            if todayDate == currentEventDate {
                formatter.dateFormat = timeFormatString
                cell.dateTimeLabel.text = formatter.string(from: currenEvent.startDate) + " Today"
            } else {
                formatter.dateFormat = timeFormatString + " " + dateFormatString
                cell.dateTimeLabel.text = formatter.string(from: currenEvent.startDate)
            }
        }
        
        return cell;
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        eventIndex = indexPath.row
    }
}
