//
//  NotificationViewController.swift
//  NotificationContect
//
//  Created by Angel Papamichail on 06/12/2016.
//  Copyright © 2016 Angel Papamichail. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var unassignButton: UIButton!
    @IBOutlet weak var contactRelationField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func unassignButtonAction(_ sender: Any) {
    }
    
    
    func didReceive(_ notification: UNNotification) {
      //  self.label?.text = notification.request.content.body
        
    }

}
