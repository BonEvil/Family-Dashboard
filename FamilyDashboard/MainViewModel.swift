//
//  MainViewModel.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/26/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import Foundation
import EventKit
import CoreLocation

class MainViewModel {
    
    typealias EventCallback = ([EKEvent]) -> ()
    typealias StringCallback = (String) -> ()
    typealias LocationCallback = (String,CLLocation) -> ()
    
    var name:String = ""
    
    var calendars = [EKCalendar]()
    
    let eventStore = EKEventStore()
    let formatter = DateFormatter()
    let timeFormatString = "h:mm:ss a"
    let dateFormatString = "EEEE, MMMM dd, YYYY"
    
    var locationController:LocationController?
    
    var weatherCallback:LocationCallback?
    var eventCallback:EventCallback?
    var timeCallback:StringCallback?
    var dateCallback:StringCallback?
    
    init(name:String) {
        self.name = name
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateDate), userInfo: nil, repeats: true)
    }
    
    func bindWeatherHTML(callback:@escaping LocationCallback) {
        weatherCallback = callback
        
        locationController = LocationController(callback: { [unowned self](location) in
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            
            let html = "<html><body><iframe style=\"background-color:white;\" id=\"forecast_embed\" frameborder=\"0\" height=\"245\" width=\"100%\" src=\"https://forecast.io/embed/#lat="+lat+"&lon="+lon+"&name="+self.name+"&color=#00aaff&font=Arial Rounded MT Bold\"></iframe></body></html>"

            if let cb = self.weatherCallback {
                cb(html,location)
                self.locationController = nil
            }
        })
    }
    
    func bindEvents(callback:@escaping EventCallback) {
        eventCallback = callback
        checkCalendarAuthorizationStatus()
    }
    
    func bindTime(callback:@escaping StringCallback) {
        timeCallback = callback
    }
    
    func bindDate(callback:@escaping StringCallback) {
        dateCallback = callback
        updateDate()
    }
    
    @objc func updateTime() {
        formatter.dateFormat = timeFormatString
        if let cb = timeCallback {
            cb(formatter.string(from: Date()))
        }
    }
    
    @objc func updateDate() {
        formatter.dateFormat = dateFormatString
        let newDate = formatter.string(from: Date())
        if let cb = dateCallback {
            cb(newDate)
        }
        updateEvents()
    }
    
    func updateEvents(){
        checkCalendarAuthorizationStatus()
    }
    
    private func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: .event)
        
        switch  status {
        case .notDetermined:requestCalendarPermission()
        case .authorized:refreshCalendar()
        case .restricted,.denied:break
        }
    }
    
    private func refreshCalendar() {
        selectCalendars()
        setupEvents()
    }
    
    private func requestCalendarPermission() {
        eventStore.requestAccess(to: .event) { [unowned self](granted, error) in
            DispatchQueue.main.async {
                self.checkCalendarAuthorizationStatus()
            }
        }
    }
    
    private func selectCalendars() {
        let calendars = self.eventStore.calendars(for: .event)
        for calendar in calendars {
            let title = calendar.title
            switch title {
            case "Birthdays","US Holidays","FAST","Sapient","Family":
                self.calendars.append(calendar)
            default:break
            }
        }
    }
    
    private func setupEvents() {
        formatter.dateFormat = "yyyy-MM-dd"
        let start = formatter.string(from: Date())
        let startDate = formatter.date(from: start)
        guard let twoWeeks = Calendar.current.date(byAdding: .day, value: 14, to: Date()) else {
            return
        }
        
        let end = formatter.string(from: twoWeeks)
        let endDate = formatter.date(from: end)
        if let end = endDate, let start = startDate {
            let predicate = eventStore.predicateForEvents(withStart: start, end: end, calendars: calendars)
            let events = eventStore.events(matching: predicate).sorted(by: { (e1, e2) -> Bool in
                return e1.startDate.compare(e2.startDate) == ComparisonResult.orderedAscending
            })
            
            //            for event in events {
            //                print("\(event)")
            //            }
            
            if let eventCB = eventCallback {
                eventCB(events)
            }
        }
    }
}
