//
//  NotificationService.swift
//  NotificationService
//
//  Created by Angel Papamichail on 06/12/2016.
//  Copyright © 2016 Angel Papamichail. All rights reserved.
//

import UserNotifications
import MobileCoreServices
import CoreLocation

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.reverseGeolocation()
        
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        // Get the custom data from the notification payload
        if let notificationData = request.content.userInfo["aps"] as? [String: Any] {
//            // Grab the attachment
            if let urlString = notificationData["my-attachment"], let fileUrl = URL(string: urlString as! String ) {
                // Download the attachment
                let session = URLSession(configuration:
                    URLSessionConfiguration.default)
                let attachmentDownloadTask = session.downloadTask(with:
                    fileUrl, completionHandler: { (url, response, error) in
                        if let error = error {
                            print("Error downloading: \(error.localizedDescription)")
                        } else if let url = url {
                            // 3
                            let attachment = try! UNNotificationAttachment(identifier:
                                "foo", url: url, options:
                                [UNNotificationAttachmentOptionsTypeHintKey: kUTTypePNG])
                            self.bestAttemptContent?.attachments = [attachment]
                        }
                        // 5
                        contentHandler(self.bestAttemptContent!)
                })
                // 4
                attachmentDownloadTask.resume()
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    func reverseGeolocation() {
        let longitude: CLLocationDegrees = -122.0312186
        let latitude: CLLocationDegrees = 37.33233141
        
        let location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
        print(location)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = (placemarks?[0])! as CLPlacemark
                print(pm.locality ?? "")
            }
            else {
                print("Problem with the data received from geocoder")
            }
            
//             self.contentHandler!(self.bestAttemptContent!)
        })
    }


}
