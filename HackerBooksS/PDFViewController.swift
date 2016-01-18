//
//  PDFViewController.swift
//  HackerBooksS
//
//  Created by Jorge Miguel Lucena Pino on 14/12/15.
//  Copyright © 2015 Jorge Miguel Lucena Pino. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var book : KCBook?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "bookChanged:", name: "bookDidChange", object: nil)
        self.syncView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bookChanged(notification : NSNotification) {
        book = notification.object as? KCBook
        self.syncView()
    }
    
    func syncView() {
       
        self.title = book?.title
        if let pdfUrl = book?.pdf {
            webView.loadRequest(NSURLRequest(URL: pdfUrl))
        }

    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
