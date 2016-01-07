//
//  MasterViewController.swift
//  HackerBooksS
//
//  Created by Jorge Miguel Lucena Pino on 13/12/15.
//  Copyright © 2015 Jorge Miguel Lucena Pino. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "favDidChangeAdd:", name: "addFav", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "favDidChangeDel:", name: "delFav", object: nil)
        
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

    func favDidChangeAdd(notification : NSNotification){
        // Añado el libro a favorito
        let updatedModel = (notification.object as? KCBook)!
        model!.addBookForTag(updatedModel, tag: KCBookTag(withName: "Favorite"))
        
        updatedModel.isFavorite = true
        self.detailViewController?.detailModel = updatedModel
        updateModel()
    }
    
    func favDidChangeDel(notification : NSNotification){
        // Quito el libro de favoritos
        let updatedModel = (notification.object as? KCBook)!
        model!.removeBookForTag(updatedModel, tag: KCBookTag(withName: "Favorite"))
        
        updatedModel.isFavorite = false
        self.detailViewController?.detailModel = updatedModel
        updateModel()
    }

    func updateModel(){
        
        self.tableView.reloadData()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let book : KCBook?
                
                if sortByTitle {
                    book = model?.books[indexPath.row]
                }else{
                    book = model?.bookAtIndex(indexPath.item, tag: KCBookTag(withName: (model?.tags[indexPath.section].tagName)!))
                }
                

                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailModel = book
                controller.navigationItem.rightBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
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
        //cell.imageView?.image = UIImage(contentsOfFile: book?.image)
        return cell
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

