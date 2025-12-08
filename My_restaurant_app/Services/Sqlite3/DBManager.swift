//
//  DBManager.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 8/12/25.
//

import Foundation
import SQLite3

class DBManager{
    
    static let shared = DBManager()
    
    init(){
        db = openDatabase()
    }
    
    let dataPath: String = "MyDB"
    var db: OpaquePointer?
    
    // Create DB
    func openDatabase()->OpaquePointer?{
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dataPath)
        
        var db: OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK{
            debugPrint("Cannot open DB.")
            return nil
        }
        else{
            print("DB successfully created.")
            return db
        }
    }
    
   
}

