//
//  KCBookTag.swift
//  HackerBooks
//
//  Created by Jorge Miguel Lucena Pino on 7/12/15.
//  Copyright © 2015 Jorge Miguel Lucena Pino. All rights reserved.
//

import Foundation

class KCBookTag : Equatable, Comparable, Hashable {
    
    //MARK: - Properties
    var tagName : String
    var isFavorite : Bool{
        get{
            return tagName == "Favorite" ? true : false
        }
    }
    
    //MARK: - Hashable
    
    var hashValue: Int {
        return tagName.hashValue
    }
    
    //MARK: - Init
    init (withName aTagName: String){
        tagName = aTagName
    }
    
    convenience init (bookTagWithName name: String){
        self.init(withName: name)
    }
    
    class func favoriteBookTag()->KCBookTag{
        return KCBookTag(withName: "Favorite")
    }
    
    func normalizedName()->String{
        return self.tagName.capitalizedString
    }
    
    //MARK: - Proxies
    var proxyForComparison : String{
        
        get{
            return "\(tagName)"
        }
    }
    
    var proxyForSorting : String{
        
        get{
            return "\(tagName)"
        }
    }
}

//MARK: - Operators

func ==(lhs: KCBookTag, rhs: KCBookTag) -> Bool{
    
    // 1er caso: son el mismo objeto
    guard !(lhs === rhs) else{
        return true
    }
    
    // 2do caso: tienen clases distintas
    guard lhs.dynamicType == rhs.dynamicType else{
        return false
    }
    
    // Caso genérico
    return (lhs.proxyForComparison == rhs.proxyForComparison)
    
}

func <(lhs: KCBookTag, rhs: KCBookTag) -> Bool {
    // Favorite wins ever
    if lhs.isFavorite {
        return true
    }
    if rhs.isFavorite {
        return false
    }
    return (lhs.proxyForSorting < rhs.proxyForSorting)
}

