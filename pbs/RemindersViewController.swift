//
//  RemindersViewController.swift
//  pbs
//
//  Created by Ryan Ball on 05/05/2017.
//  Copyright © 2017 Ryan Ball. All rights reserved.
//

import UIKit
import EventKit

class RemindersViewController: UIViewController {
    
    @IBOutlet weak var reminderText: UITextField!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let appDelegate = UIApplication.shared.delegate
        as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func setReminder(_ sender: AnyObject) {
        
        if reminderText.text == "" {
            
            // Create the alert controller
            let alertController = UIAlertController(title: "Information Needed", message: "Please type in the treatment and select the correct date and time you wish to be added to your Calendar before pressing the Create Appointment Reminder button.", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "Got It", style: UIAlertActionStyle.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
            
            // Add the actions
            alertController.addAction(okAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            activityIndicator.startAnimating()
            
            let eventStore = EKEventStore()
            eventStore.requestAccess(
                to: EKEntityType.event, completion: {(granted, error) in
                    if !granted {
                        print("Access to store not granted")
                        print(error!.localizedDescription)
                    } else {
                        print("Access granted")
                        self.createReminder(in: eventStore)
                    }
            })
        }
        
        self.reminderText.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func createReminder(in eventStore: EKEventStore) {
        
        let reminder = EKEvent(eventStore: eventStore)
        
        reminder.title = reminderText.text! + " " + "(Pose Beauty Salon)"
        reminder.calendar =
            eventStore.defaultCalendarForNewEvents
        let date = myDatePicker.date
        let alarm = EKAlarm(absoluteDate: date)
        reminder.addAlarm(alarm)
        
        let earlierDate = date.addingTimeInterval(-3600*24)
        let earlierAlarm = EKAlarm(absoluteDate: earlierDate)
        reminder.addAlarm(earlierAlarm)
        
        reminder.startDate = date
        reminder.endDate = date.addingTimeInterval(3600)
        
        do {
            try eventStore.save(reminder, span: .thisEvent, commit: true)
        } catch let error  {
            print("Reminder failed with error \(error.localizedDescription)")
            return
        }
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Reminder Created Successfully", message: "Your \(reminderText.text!) appointment at Pose Beauty Salon has been successfully added to your Calendar. Thank You!", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.reminderText.text = ""
            self.activityIndicator.stopAnimating()
        }
        
        // Add the actions
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        reminderText.endEditing(true)
    }
}
