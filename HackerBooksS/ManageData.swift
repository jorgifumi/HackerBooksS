//
//  ManageData.swift
//  HackerBooksS
//
//  Created by Jorge Miguel Lucena Pino on 13/12/15.
//  Copyright © 2015 Jorge Miguel Lucena Pino. All rights reserved.
//

import Foundation

func downloadJSON(){
    
    let previousDataKey = "madreMiaConLaPractica"
    
    //comprobar si hay datos locales
    
    //NSUserDefaults
    let ud = NSUserDefaults.standardUserDefaults()
    var url = NSURL(string: "https://t.co/K9ziV0z3SJ")
    
    if ud.objectForKey(previousDataKey) !== nil {
        // Ya existen datos, poner ruta local
        let fm = NSFileManager.defaultManager()
    
        if let tempUrl = fm.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).first?.URLByAppendingPathComponent("books_readable.json") {
            url = tempUrl
        }
        print("Error al crear la URL")
      
    }
    
    //Leer Datos
    //let data = data_request(url)
    
    do{
        try "prueba".writeToURL(url!, atomically: true, encoding: NSUTF8StringEncoding)
        var str:AnyObject?
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://httpbin.org/get")!, completionHandler: { (data, response, error) -> Void in
            
            str = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            print(str)
        })
        task.resume()
        
    }catch{
        print("Error al guardar los datos")
        
    }
    
    
    

}

