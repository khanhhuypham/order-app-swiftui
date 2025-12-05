//
//  AreaServiceProtocol.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 30/10/25.
//


import Foundation


protocol AreaRepository {
    func getAreas(branchId: Int, status: Int) async -> Result<APIResponse<[Area]>, Error>
    func getTables(branchId: Int, areaId: Int, status: String, exclude_table_id: Int) async -> Result<APIResponse<[Table]>, Error>
    func moveTable(branchId: Int, from: Int, to: Int) async -> Result<PlainAPIResponse, Error>
    func mergeTable(branchId: Int, destination_table_id: Int, target_table_ids: [Int]) async -> Result<PlainAPIResponse, Error>
}


final class AreaRepositoryImpl: AreaRepository {
    func getAreas(branchId: Int, status: Int) async -> Result<APIResponse<[Area]>, Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .areas(branch_id: branchId, status: status))
    }

    func getTables(branchId: Int, areaId: Int, status: String, exclude_table_id: Int) async -> Result<APIResponse<[Table]>, Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .tables(branchId: branchId, area_id: areaId, status: status, exclude_table_id: exclude_table_id))
    }

    func moveTable(branchId: Int, from: Int, to: Int) async -> Result<PlainAPIResponse, Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .moveTable(branch_id: branchId, from: from, to: to))
    }

    func mergeTable(branchId: Int, destination_table_id: Int, target_table_ids: [Int]) async -> Result<PlainAPIResponse, Error> {
        await NetworkManager.callAPIResultAsync(netWorkManger: .mergeTable(branch_id: branchId, destination_table_id: destination_table_id, target_table_ids: target_table_ids))
    }
}
