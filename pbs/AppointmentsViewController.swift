//
//  AppointmentsViewController.swift
//  pbs
//
//  Created by Ryan Ball on 05/05/2017.
//  Copyright © 2017 Ryan Ball. All rights reserved.
//

import UIKit

class AppointmentsViewController: UIViewController {
    
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork(){
            
            let url = URL(string: "https://www.posebeautysalon.com/appointment")!
            
            myWebView.loadRequest(URLRequest(url: url))
            
        }
        else{
            print("Internet Connection not Available!")
            
            let alertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                NSLog("OK Pressed")
                
            }
            
            // Add the actions
            alertController.addAction(okAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
    
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
}



