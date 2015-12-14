//
//  KCMultiDictionary.swift
//  HackerBooks
//
//  Created by Jorge Miguel Lucena Pino on 7/12/15.
//  Copyright © 2015 Jorge Miguel Lucena Pino. All rights reserved.
//

import Foundation



public struct KCMultiDictionary<KeyType: Hashable, ValueType: Hashable> {
    
    //MARK: - Alias
    typealias MultiDictionaryType = [KeyType: Set<ValueType>]
    
    private var dict = MultiDictionaryType()
    
    //MARK: - Accesors
    
    public mutating func addObject(object: ValueType, forKey key: KeyType) {
        var objs = dict[key] ?? Set<ValueType>()
        
        objs.insert(object)
       
        dict[key] = objs
    }
    
    
    public func objectsForKey(key: KeyType) -> Set<ValueType> {

        return dict[key] ?? []
    }
    
    public func allObjects() -> Set<ValueType> {
        var total = Set<ValueType>()
        for (_, value) in dict{
            total = total.union(value)
        }
        return total
    }
    
    public mutating func removeObject(object: ValueType, forKey key: KeyType) {
        if dict[key] != nil {
            dict[key]?.remove(object)
            if ((dict[key]?.isEmpty) == true) {
                dict[key]?.removeAll()
            }else{
                dict.removeValueForKey(key)
            }
        }

    }
    
    public var count : Int{
        get{
            
            return allObjects().count
        }
    }
    
    public var allKeys : [KeyType]{
        get{
            var keys = [KeyType]()
            
            for (key, _) in dict{
                keys.append(key)
            }
            return keys
        }
    }
}