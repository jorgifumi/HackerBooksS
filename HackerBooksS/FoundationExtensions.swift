//
//  FoundationExtensions.swift
//  HackerBooks
//
//  Created by Jorge Miguel Lucena Pino on 11/12/15.
//  Copyright © 2015 Jorge Miguel Lucena Pino. All rights reserved.
//


import Foundation

extension NSBundle{
    
    func URLForResource(fileName: String)->NSURL?{
        
        // deberes para casa: gestionar errores en caso de que no sea del tipo nombre.extension
        let tokens = fileName.componentsSeparatedByString(".")
        
        return self.URLForResource(tokens.first, withExtension: tokens.last)
    }
}