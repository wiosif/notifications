//
//  NotificationService.swift
//  NotificationService
//
//  Created by Angel Papamichail on 06/12/2016.
//  Copyright © 2016 Angel Papamichail. All rights reserved.
//

import UserNotifications
import MobileCoreServices

typealias JSONDictionary = [String: Any]

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    ////////////////////////////////////////////////////////////////////////////
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        self.bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        guard let bestAttemptContent = self.bestAttemptContent,
            let notificationData = request.content.userInfo["aps"] as? JSONDictionary,
            let profilePic = notificationData["profile_pic"] as? String,
            let profilePicURL = URL(string: profilePic)
            else {
                self.contentHandler?(request.content)
                return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.downloadTask(with: profilePicURL) { (url, _, _) in
            if let url = url {
                let attachment = try! UNNotificationAttachment(identifier: "profile_pic",
                                                               url: url,
                                                               options: [UNNotificationAttachmentOptionsTypeHintKey: kUTTypePNG])
                bestAttemptContent.attachments = [attachment]
            }
            self.contentHandler?(bestAttemptContent)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
