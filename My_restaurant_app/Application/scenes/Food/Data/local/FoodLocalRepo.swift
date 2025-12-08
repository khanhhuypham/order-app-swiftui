//
//  FoodLocalRepo.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 8/12/25.
//

import Foundation
import SQLite3



final class FoodLocalRepo:FoodProviderRepositoryProtocol {
    
    private let dbmanager = DBManager.shared
 
    func getCategories(branchId:Int,status:Int,categoryType:String) async -> Result<[Category], Error>{
        
        return .success([])
        
    }
    
    func getFoods(branchId:Int,areaId:Int,parameter:FoodAPIParameter) async -> Result<Pagination<[Food]>, Error>{
       
        return .failure(NSError(domain: "asdsa", code:500))
        
    }

}


extension FoodLocalRepo{
    
    // Create users table
    private func createUserTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS User (
              id INTEGER PRIMARY KEY,
              name TEXT,
              email TEXT,
              password TEXT,
              address TEXT
            );
        """

        var createTableStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(dbmanager.db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
              print("User table is created successfully.")
            } else {
              print("User table creation failed.")
            }
            
        } else {
            print("User table creation failed.")
        }

        sqlite3_finalize(createTableStatement)
    }
    
    
    private func insertFood()  {

    }
    
    private func getFood()  {

    }
    
    private func updateFood()  {

    }
    
    
}
