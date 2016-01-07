//
//  KCLibrary.swift
//  HackerBooks
//
//  Created by Jorge Miguel Lucena Pino on 21/11/15.
//  Copyright © 2015 Jorge Miguel Lucena Pino. All rights reserved.
//

import Foundation

class KCLibrary {
    
    //MARK: - Properties

    var library : KCMultiDictionary<KCBookTag,KCBook>
    
    
    
    //Array de libros únicos ordenados alfabéticamente
    var books   : [KCBook]{
        get{
            return library.allObjects().sort({$0.title < $1.title})
        }
    }
    
    //Array de tags con todas las distintas temáticas en orden alfabético. No puede haber repetidas
    var tags    : [KCBookTag]{
        get{
            return library.allKeys.sort(<)
        }
    }
    
    
    //MARK: - Computed Variables
    //Número total de libros
    var booksCount  : Int{
        get{
            return  books.count
        }
    }
    
    //Número de tags únicos
    var tagsCount : Int{
        get{
            return library.allKeys.count
        }
    }
    
    //MARK: - Init
    init(booksArray: [KCBook]){
        var lib = KCMultiDictionary<KCBookTag,KCBook>()
        
        for item in booksArray{
            for itemtag in item.tags!{
                lib.addObject(item, forKey: itemtag)

            }
        }
        library = lib
    }
    
    //Número de libros de una temática concreta, si no existe devuelve 0
    func bookCountForTag (tag: KCBookTag?) -> Int{
        if let tagV = tag {
            return library.objectsForKey(tagV).count
        }
        
        return 0
    }
    
    //Array de los libros que hay en una temática. Un libro puede pertenecer a varias temáticas. Si no hay libros para una temática, devuelve nil
    func booksForTag (tag: KCBookTag?) -> [KCBook]?{
        
        guard let tagValue = tag else{
            return nil
        }
        
        if bookCountForTag(tagValue) == 0 {
            return nil
        }

        return library.objectsForKey(tagValue).sort({$0.title < $1.title})
    }
    

    
    //Un KCBook para el libro que está en la posición "index" de aquellos bajo un cierto tag. Si el índice o el tag no existe, devuelve nil
    
    func bookAtIndex(index: Int, tag: KCBookTag?) -> KCBook?{
        
        guard let tagValue = tag,
        let books4Tag = booksForTag(tagValue) else{
            return nil
        }
        
        if  index < books4Tag.count && index >= 0{
            return books4Tag[index]
        }
        
        return nil

    }
    
    // Añade un libro en una categoría
    func addBookForTag(book: KCBook, tag: KCBookTag) {
        
        library.addObject(book, forKey: tag)
    }

    // Quita un libro de una categoría
    func removeBookForTag(book: KCBook, tag: KCBookTag) {
        
        library.removeObject(book, forKey: tag)
    }

    
}