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
                    //self.photo = photo
                    self.authors.text = model.authors!.joinWithSeparator(", ")
                    //self.tags.text = model.tags.map({$0.tagName}).joinWithSeparator(", ")
                    
                    // TODO: Cargar estado del interruptor
                    // propiedad = model.isFavorite
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

