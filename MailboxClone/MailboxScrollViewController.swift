//
//  MailboxScrollViewController.swift
//  Mailbox
//
//  Created by Mariannina Viggi on 11/15/15.
//  Copyright © 2015 Mariannina Viggi. All rights reserved.
//

import UIKit

class MailboxScrollViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var messageView: UIImageView!
    
    @IBOutlet weak var messageContainer: UIView!
    
    @IBOutlet weak var clockIcon: UIImageView!
    
    @IBOutlet weak var checkIcon: UIImageView!
    
    @IBOutlet weak var listIcon: UIImageView!
    
    @IBOutlet weak var cancelIcon: UIImageView!
    
    @IBOutlet weak var rescheduleView: UIImageView!
    
    @IBOutlet weak var listView: UIImageView!
    
    @IBOutlet weak var feedView: UIImageView!
    
    var clockCenter: CGPoint!
    
    var initialCenter: CGPoint!
    
    var checkCenter: CGPoint!
    
    var feedCenter: CGPoint!
    
    var cancelCenter: CGPoint!
    
    var listCenter: CGPoint!
    
    var ltGrey = UIColor.init(red: 220/255, green: 225/255, blue: 225/255, alpha: 1.0)
    
    var yellow = UIColor.init(red: 250/255, green: 210/255, blue: 10/255, alpha: 1.0)
    
    var green = UIColor.init(red: 100/255, green: 220/255, blue: 90/255, alpha: 1.0)
    
    var red = UIColor.init(red: 240/255, green: 80/255, blue: 40/255, alpha: 1.0)
    
    var brown = UIColor.init(red: 220/255, green: 115/255, blue: 115/255, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 1440)
        
        clockCenter = clockIcon.center
        
        initialCenter = messageView.center
        
        checkCenter = checkIcon.center
        
        cancelCenter = cancelIcon.center
        
        listCenter = listIcon.center
        
        feedCenter = feedView.center

        clockIcon.alpha = 0.0
        
        checkIcon.alpha = 0.0
        
        cancelIcon.alpha = 0.0
        
        listIcon.alpha = 0.0
        
        rescheduleView.alpha = 0.0
        
        listView.alpha = 0.0
        
    }
    func clearIcons() {
        
        clockIcon.alpha = 0.0
        
        checkIcon.alpha = 0.0
        
        listIcon.alpha = 0.0
        
        cancelIcon.alpha = 0.0
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(messageContainer)
        
        _ = sender.locationInView(messageContainer)
        
        _ = sender.velocityInView(messageContainer)

        if translation.x > -60 && translation.x < 60 {
            animateBGColor(ltGrey)
            
        }
            
        else if translation.x < -60 && translation.x > -240 {
            animateBGColor(yellow)
            
        }
            
        else if translation.x <= -240 {
            animateBGColor(brown)
            
        }
            
        else if translation.x > 60 && translation.x < 240 {
            animateBGColor(green)
            
        }
            
        else if translation.x >= 240 {
            animateBGColor(red)
            
        }

        if translation.x < 0 && translation.x > -240 {
            
            clearIcons()
            self.clockIcon.alpha = 1.0
            self.clockIcon.center = CGPoint(x: clockCenter.x + translation.x + 60, y: clockCenter.y)
            
        }
            
        else if translation.x <= -240 {
            
            clearIcons()
            self.listIcon.alpha = 1.0
            self.listIcon.center = CGPoint(x: clockCenter.x + translation.x + 60, y: clockCenter.y)
            
        }
            
        else if translation.x > 0 && translation.x < 240 {
            
            clearIcons()
            self.checkIcon.alpha = 1.0
            self.checkIcon.center = CGPoint(x: checkCenter.x + translation.x - 60, y: checkCenter.y)
            
        }
            
        else if translation.x >= 240{
            
            clearIcons()
            self.cancelIcon.alpha = 1.0
            self.cancelIcon.center = CGPoint(x: checkCenter.x + translation.x - 60, y: checkCenter.y)
            
        }
    
        if sender.state == UIGestureRecognizerState.Began{
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            
            messageView.center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y)
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {

            if translation.x < -60 && translation.x > -240 {
                self.clearIcons()
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center = CGPoint(x: self.initialCenter.x - 320, y: self.initialCenter.y)
                    
                    
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.rescheduleView.alpha = 1.0
                        })
                })
            }

            if translation.x <= -240 {
                self.clearIcons()
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center = CGPoint(x: self.initialCenter.x - 320, y: self.initialCenter.y)
                    
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.listView.alpha = 1.0
                        })
                })
                
            }
            
            if translation.x >= 240 {
                self.clearIcons()
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center = CGPoint(x: self.initialCenter.x + 320, y: self.initialCenter.y)
                    
                })
                coverMessage()
            }
            
             if translation.x > 60 && translation.x < 240 {
                self.clearIcons()
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center = CGPoint(x: self.initialCenter.x + 320, y: self.initialCenter.y)
                    
                })
                coverMessage()
            }

            if translation.x >= -60 && translation.x <= 60{
                clearIcons()
                messageView.center = CGPoint(x: initialCenter.x, y: initialCenter.y)
                clockIcon.center = CGPoint(x: clockCenter.x, y: clockCenter.y)
                checkIcon.center = CGPoint(x: checkCenter.x, y: checkCenter.y)
            }
            
        }
        
    }

    @IBAction func didTapReschedule(sender: AnyObject) {

        rescheduleView.alpha = 0.0
        
        clearIcons()
        coverMessage()
        
    }

    @IBAction func didTapListScreen(sender: UITapGestureRecognizer) {
        
        listView.alpha = 0.0
        clearIcons()
        coverMessage()
    }

    func coverMessage(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.feedView.center = CGPoint (x: self.feedCenter.x, y: self.feedCenter.y - 86)
            }) { (Bool) -> Void in
                self.resetMessage()
        }
        
    }
    
    
    

    func resetMessage(){
        delay(0.6) { () -> () in
            self.messageView.center = CGPoint(x: self.initialCenter.x, y: self.initialCenter.y)
            UIView.animateWithDuration(0.4) { () -> Void in
                self.feedView.center = CGPoint (x: self.feedCenter.x, y: self.feedCenter.y)
            }
        }
        
    }
    
    func animateBGColor(color: UIColor) {
        UIView.animateWithDuration(0.0, animations: { () -> Void in
            self.messageContainer.backgroundColor = color
        })
    }
    
}
