//
//  DetailViewController.swift
//  HackerBooksS
//
//  Created by Jorge Miguel Lucena Pino on 13/12/15.
//  Copyright © 2015 Jorge Miguel Lucena Pino. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var authors: UILabel!
    @IBOutlet weak var photo: UIWebView!
    @IBOutlet weak var favButton: UIBarButtonItem!
    @IBAction func favorite(sender: AnyObject) {
        
        if detailModel!.isFavorite {
            // Notification
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "delFav", object: detailModel!))
        }else{
            // Notification
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "addFav", object: detailModel!))

        }

        
        
    }

    var detailModel: KCBook? {
        willSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let model = self.detailModel{
            self.title = model.title
            self.photo.loadRequest(NSURLRequest(URL: model.image))
            if let authors = model.authors,
                tags = model.tags{
                    self.authors.text = authors.joinWithSeparator(", ")
                    self.tags.text = tags.map({$0.tagName}).joinWithSeparator(", ")
                    
            }
            // TODO: Cargar estado del interruptor
            if model.isFavorite {
                favButton.tintColor = UIColor.blueColor()
            }else{
                favButton.tintColor = UIColor.grayColor()
            }
            
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "bookChanged:", name: "bookDidChange", object: nil)
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "readBook" {
            
            if let controller = segue.destinationViewController as? PDFViewController {
                if let model = self.detailModel{
                    controller.title  = model.title
                    controller.pdfUrl = model.pdf
                }
            }
            
        }
    }
    
    func bookChanged(notification : NSNotification) {
        self.configureView()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

