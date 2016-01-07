//
//  Book.swift
//  HackerBooks
//
//  Created by Jorge Miguel Lucena Pino on 21/11/15.
//  Copyright © 2015 Jorge Miguel Lucena Pino. All rights reserved.
//

import Foundation

class KCBook : Equatable, Hashable {
    
    //MARK - Properties
    let title       : String
    let authors     : [String]?
    var tags        : [KCBookTag]?
    let image       : NSURL
    let pdf         : NSURL
    
    //MARK: - Computed Properties
    var isFavorite  : Bool{
        get{
            return tags!.contains(KCBookTag.favoriteBookTag())
        }
        set{
            if newValue {
                self.tags?.append(KCBookTag(withName: "Favorite"))
            }else{
                //TODO : Implementar que elimine el tag favorito, ahora presuponemos que es el último pero podría no serlo...
                self.tags?.removeLast()
            }
            
        }
    }
    
    //MARK: - Hashable
    
    var hashValue: Int {
        return title.hashValue
    }
    
    //Mark - Init
    init(title: String,
        authors: [String]?,
        tags: [KCBookTag],
        imageUrl: NSURL,
        pdfUrl: NSURL){
            
            self.title = title
            self.authors = authors
            self.tags = tags
            self.image = imageUrl
            self.pdf = pdfUrl
    }
    
    //MARK: - Proxies
    var proxyForComparison : String{
        
        get{
            return "\(title)\(authors)\(tags)\(image)\(pdf)"
        }
    }

}

//MARK: - Operators

func ==(lhs: KCBook, rhs: KCBook) -> Bool{
    
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