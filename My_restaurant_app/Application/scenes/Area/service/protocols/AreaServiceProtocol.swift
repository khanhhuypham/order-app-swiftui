//
//  FoodServiceProtocol.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 29/10/25.
//



protocol AreaServiceProtocol {
    
    func getAreas(branchId:Int,status:Int) async -> Result<APIResponse<[Area]>, Error>
        
    func getTables(branchId:Int,areaId:Int,status:String,exclude_table_id:Int)async -> Result<APIResponse<[Table]>, Error>
    
    func moveTable(branchId:Int,from:Int,to:Int) async -> Result<PlainAPIResponse, Error>
    
    func mergeTable(branchId:Int,destination_table_id:Int,target_table_ids:[Int]) async ->  Result<PlainAPIResponse,Error>

    
}
