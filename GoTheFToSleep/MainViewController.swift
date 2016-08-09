//
//  ViewController.swift
//  GoTheFToSleep
//
//  Created by Tim Sawtell on 14/03/2016.
//  Copyright © 2016 Tim Sawtell. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {

    let preferences = Preferences()
    
    @IBOutlet weak var wakeButton: UIButton!
    @IBOutlet weak var sleepButton: UIButton!
    @IBOutlet weak var wakeDatePicker: UIDatePicker!
    @IBOutlet weak var sleepDatePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferences.populateFromDefaults()
        sleepDatePicker.addTarget(self, action: #selector(MainViewController.sleepDatePickerUpdated(_:)), forControlEvents: UIControlEvents.ValueChanged)
        wakeDatePicker.addTarget(self, action: #selector(MainViewController.wakeDatePickerUpdated(_:)), forControlEvents: UIControlEvents.ValueChanged)
        sleepDatePicker.backgroundColor = UIColor.whiteColor()
        wakeDatePicker.backgroundColor = UIColor.whiteColor()
        let tapperoo = UITapGestureRecognizer(target: self, action: #selector(MainViewController.tapped(_:)))
        view.addGestureRecognizer(tapperoo)
        let timer = NSTimer(timeInterval: 60, target: self, selector: #selector(MainViewController.tick), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
        tick() // don't wait a whole minute before it first runs
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        sleepDatePicker.hidden = true
        wakeDatePicker.hidden = true
        updateButtons()
    }
    
    @IBAction func sleepButtonTapped(sender: AnyObject) {
        sleepDatePicker.hidden = false
    }
    
    @IBAction func wakeButtonTapped(sender: AnyObject) {
        wakeDatePicker.hidden = false;
    }
    
    func tick() {
        preferences.updateWithNewDate(NSDate())
        switch preferences.state {
            case .asleep:
                imageView.image = UIImage(named: "moon")
                break
            case .awake:
                imageView.image = UIImage(named: "sun")
                break
            default:
                break;
        }
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        switch preferences.state {
        case .asleep:
            return UIStatusBarStyle.LightContent
        case .awake:
            return UIStatusBarStyle.Default
        default:
            return UIStatusBarStyle.Default
        }
    }
    
    func tapped(sender: UITouch) {
        sleepDatePicker.hidden = true
        wakeDatePicker.hidden = true
    }
    
    func sleepDatePickerUpdated(sender: UIControl) {
        preferences.setSleepTime(sleepDatePicker.date)
        wakeDatePicker.maximumDate = sleepDatePicker.date
        updateButtons()
        tick()
    }
    
    func wakeDatePickerUpdated(sender: UIControl) {
        preferences.setWakeTime(wakeDatePicker.date)
        sleepDatePicker.minimumDate = wakeDatePicker.date
        updateButtons()
        tick()
    }

    func updateButtons() {
        let wakeTime = preferences.wakeTime()
        let wakeTitle = NSString(format: "Wake: %@", wakeTime!.toShortTimeString())
        wakeButton.setTitle(wakeTitle as String, forState: .Highlighted)
        wakeButton.setTitle(wakeTitle as String, forState: .Normal)
        wakeDatePicker.date = wakeTime!
        
        let sleepTime = preferences.sleepTime()
        let sleepTitle = NSString(format: "Sleep: %@", sleepTime!.toShortTimeString())
        sleepButton.setTitle(sleepTitle as String, forState: .Highlighted)
        sleepButton.setTitle(sleepTitle as String, forState: .Normal)
        sleepDatePicker.date = sleepTime!
    }

}

