//
//  MockAreaService.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 30/10/25.
//


import XCTest
@testable import My_restaurant_app


final class MockAreaRepository: AreaRepository {
    var getAreasResult: Result<[Area], Error> = .success([])
    var getTablesResult: Result<[Table], Error> = .success([])
    var moveTableResult: Result<Void, Error> = .success(())
    var mergeTableResult: Result<Void, Error> = .success(())

    func getAreas(branchId: Int, status: Int) async -> Result<[Area], Error> {
        getAreasResult
    }
    func getTables(branchId: Int, areaId: Int, status: String, excludeTableId: Int) async -> Result<[Table], Error> {
        getTablesResult
    }
    func moveTable(branchId: Int, from: Int, to: Int) async -> Result<Void, Error> {
        moveTableResult
    }
    func mergeTable(branchId: Int, destinationTableId: Int, targetTableIds: [Int]) async -> Result<Void, Error> {
        mergeTableResult
    }
}
