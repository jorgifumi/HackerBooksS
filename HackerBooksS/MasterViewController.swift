//
//  MasterViewController.swift
//  HackerBooksS
//
//  Created by Jorge Miguel Lucena Pino on 13/12/15.
//  Copyright © 2015 Jorge Miguel Lucena Pino. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, AGTAsyncImageDelegate {

    var detailViewController: DetailViewController? = nil
    
    var model : KCLibrary? = KCLibrary(strictBooksArray: decodeJSON())
    
    @IBOutlet weak var sortType: UISegmentedControl!
    @IBAction func switchSort() {
        self.tableView.reloadData()
    }

    var sortByTitle : Bool{
        get{
            return sortType.selectedSegmentIndex == 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "favDidChange:", name: "switchFav", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "bookChanged:", name: "bookDidChange", object: nil)
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func favDidChange(notification : NSNotification){
        // Añado el libro a favorito
        let updatedModel = (notification.object as? KCBook)!
        if updatedModel.isFavorite {
            updatedModel.isFavorite = false
            model!.removeBookForTag(updatedModel, tag: KCBookTag(withName: "Favorite"))
            
        }else{
            updatedModel.isFavorite = true
            model!.addBookForTag(updatedModel, tag: KCBookTag(withName: "Favorite"))
            
        }
        
    }
    

    func bookChanged(notification : NSNotification){
        
        
        
        
        if let splitVC = self.splitViewController {
            if (splitVC.collapsed == false) {
                // Si está en horizontal
                if let navigationController = splitVC.viewControllers[splitVC.viewControllers.count-1] as? UINavigationController {
                navigationController.topViewController!.navigationItem.rightBarButtonItem = splitVC.displayModeButtonItem()
                }
            }else{
                self.navigationController!.showDetailViewController(detailViewController!, sender: nil)
            }
        }
        self.tableView.reloadData()
    }

    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections
        if sortByTitle {
            return 1
        }else{
            return model?.tagsCount ?? 0
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        if sortByTitle {
            return model?.booksCount ?? 0
        }else{
            return (model?.bookCountForTag(KCBookTag(withName: (model?.tags[section].tagName)!)))!
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sortByTitle{
            return nil
        }else{
            return model?.tags[section].tagName
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let book : KCBook?
        
        if sortByTitle {
            book = model?.books[indexPath.row]
        }else{
            book = model?.bookAtIndex(indexPath.item, tag: KCBookTag(withName: (model?.tags[indexPath.section].tagName)!))
        }
        
        cell.textLabel?.text = book?.title
        cell.detailTextLabel?.text = book?.authors!.joinWithSeparator(", ")
        
        let asyncImage = AGTAsyncImage(URL: book?.image, defaultImage: UIImage(named: "emptyBookCover.png"))
        asyncImage.delegate = self

        cell.imageView?.image = asyncImage.image
        return cell
    }

    func asyncImageDidChange(aImage: AGTAsyncImage!) {
        
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let book : KCBook?
        
        if sortByTitle {
            book = model?.books[indexPath.row]
        }else{
            book = model?.bookAtIndex(indexPath.item, tag: KCBookTag(withName: (model?.tags[indexPath.section].tagName)!))
        }
        
        
        //Notification
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "bookDidChange", object: book!))
        
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
