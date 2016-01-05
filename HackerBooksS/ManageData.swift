//
//  ManageData.swift
//  HackerBooksS
//
//  Created by Jorge Miguel Lucena Pino on 13/12/15.
//  Copyright © 2015 Jorge Miguel Lucena Pino. All rights reserved.
//

import Foundation
import UIKit

func downloadJSON(){
    
    let firstRun = "madreMiaConLaPractica"
    
    //comprobar si hay datos locales
    
    let ud = NSUserDefaults.standardUserDefaults()
        let isFirstRun = ud.objectForKey(firstRun)
    
    if isFirstRun == nil {
        // Primera vez que se arranca
        let url = NSURL(string: "https://t.co/K9ziV0z3SJ")
        let fm = NSFileManager.defaultManager()

        // Descargar JSON
        if let data = NSData(contentsOfURL: url!) {
            // Guardarlo en Documents
            if let dataUrl = fm.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).first?.URLByAppendingPathComponent("books_readable.json") {
                data.writeToURL(dataUrl, atomically: true)
                print("Downloading...")
                // Marcamos que ya se ha iniciado alguna vez
                ud.setBool(true, forKey: firstRun)
            }
        }
    }else{
        // Ya existen datos
        print("Loading data from disk...")
    }
}



//
//        
//    
//        if let tempUrl = fm.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).first?.URLByAppendingPathComponent("books_readable.json") {
//            url = tempUrl
//        }
//        print("Error al crear la URL")
//      
//    }
//    
//    //Leer Datos
//    //let data = data_request(url)
//    
//    do{
//        try "prueba".writeToURL(url!, atomically: true, encoding: NSUTF8StringEncoding)
//        var str:AnyObject?
//        
//        downloadFile(fromURL: url!, toURL: <#T##String#>)
//    }catch{
//        print("Error al guardar los datos")
//        
//    }
    

//
//
//func downloadFile(fromURL url: NSURL, toURL: String) {
//    
//    let task = NSURLSession.sharedSession().dataTaskWithURL( url, completionHandler: {
//        (data, response, error) -> Void in
//        dispatch_async(dispatch_get_main_queue()) {
//            if let data = data {
//                
//                data.writeToFile(toURL, atomically: true)
//                
//            }
//        }
//    })
//    task.resume()
//
//}

