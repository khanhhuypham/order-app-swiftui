//
//  MockAreaService.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 30/10/25.
//


import XCTest
@testable import My_restaurant_app

final class MockAreaRepository: AreaRepository {
    var getAreasResult: Result<APIResponse<[Area]>, Error>!
    var getTablesResult: Result<APIResponse<[Table]>, Error>!
    var moveTableResult: Result<PlainAPIResponse, Error>!
    var mergeTableResult: Result<PlainAPIResponse, Error>!
    
    func getAreas(branchId: Int, status: Int) async -> Result<APIResponse<[Area]>, Error> {
        return getAreasResult
    }
    
    func getTables(branchId: Int, areaId: Int, status: String, exclude_table_id: Int) async -> Result<APIResponse<[Table]>, Error> {
        return getTablesResult
    }
    
    func moveTable(branchId: Int, from: Int, to: Int) async -> Result<PlainAPIResponse, Error> {
        return moveTableResult
    }
    
    func mergeTable(branchId: Int, destination_table_id: Int, target_table_ids: [Int]) async -> Result<PlainAPIResponse, Error> {
        return mergeTableResult
    }
}
