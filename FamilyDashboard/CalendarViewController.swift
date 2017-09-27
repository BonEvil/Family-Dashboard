//
//  CalendarViewController.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/26/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import UIKit
import GCCalendar

class CalendarViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var calendarView: GCCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendarView.delegate = self
        calendarView.displayMode = .month
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

extension CalendarViewController: GCCalendarViewDelegate {
    
    func calendarView(_ calendarView: GCCalendar.GCCalendarView, didSelectDate date: Date, inCalendar calendar: Calendar) {
        print("selected date: \(date)")
    }
    
    func calendar(calendarView: GCCalendarView) -> Calendar {
        return Calendar.current
    }
    
    func weekdayLabelFont(calendarView: GCCalendar.GCCalendarView) -> UIFont {
        return UIFont.systemFont(ofSize: 20.0)
    }
    
    func weekdayLabelTextColor(calendarView: GCCalendar.GCCalendarView) -> UIColor {
        return UIColor.green
    }
    
    func pastDatesEnabled(calendarView: GCCalendar.GCCalendarView) -> Bool {
        return true
    }
    
    func pastDateFont(calendarView: GCCalendar.GCCalendarView) -> UIFont {
        return UIFont.systemFont(ofSize: 17.0)
    }
    
    func pastDateEnabledTextColor(calendarView: GCCalendar.GCCalendarView) -> UIColor {
        return UIColor.darkGray
    }
    
    func pastDateDisabledTextColor(calendarView: GCCalendar.GCCalendarView) -> UIColor {
        return UIColor.lightGray
    }
    
    func pastDateSelectedFont(calendarView: GCCalendar.GCCalendarView) -> UIFont {
        return UIFont.systemFont(ofSize: 19.0)
    }
    
    func pastDateSelectedTextColor(calendarView: GCCalendar.GCCalendarView) -> UIColor {
        return UIColor.black
    }
    
    func pastDateSelectedBackgroundColor(calendarView: GCCalendar.GCCalendarView) -> UIColor {
        return UIColor.white
    }
    
    func currentDateFont(calendarView: GCCalendar.GCCalendarView) -> UIFont {
        return UIFont.systemFont(ofSize: 20.0)
    }
    
    func currentDateTextColor(calendarView: GCCalendar.GCCalendarView) -> UIColor {
        return UIColor.black
    }
    
    func currentDateSelectedFont(calendarView: GCCalendar.GCCalendarView) -> UIFont {
        return UIFont.systemFont(ofSize: 24.0)
    }
    
    func currentDateSelectedTextColor(calendarView: GCCalendar.GCCalendarView) -> UIColor {
        return UIColor.white
    }
    
    func currentDateSelectedBackgroundColor(calendarView: GCCalendar.GCCalendarView) -> UIColor {
        return UIColor.red
    }
    
    func futureDateFont(calendarView: GCCalendar.GCCalendarView) -> UIFont {
        return UIFont.systemFont(ofSize: 20.0)
    }
    
    func futureDateTextColor(calendarView: GCCalendar.GCCalendarView) -> UIColor {
        return UIColor.black
    }
    
    func futureDateSelectedFont(calendarView: GCCalendar.GCCalendarView) -> UIFont {
        return UIFont.systemFont(ofSize: 20.0)
    }
    
    func futureDateSelectedTextColor(calendarView: GCCalendar.GCCalendarView) -> UIColor {
        return UIColor.darkGray
    }
    
    func futureDateSelectedBackgroundColor(calendarView: GCCalendar.GCCalendarView) -> UIColor {
        return UIColor.white
    }
}
