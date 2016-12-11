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

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
      //  self.label?.text = notification.request.content.body
        
    }

}
