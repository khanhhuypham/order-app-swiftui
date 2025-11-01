//
//  AreaViewModelTests.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 30/10/25.
//
import XCTest
@testable import My_restaurant_app

@MainActor
final class AreaViewModelTests: XCTestCase {
    
    var mockRepo: MockAreaRepository!
    var useCases: AreaUseCases!
    var viewModel: AreaViewModel!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockAreaRepository()
        useCases = AreaUseCases(repository: mockRepo)
        viewModel = AreaViewModel(useCases: useCases)
    }
    
    override func tearDown() {
        mockRepo = nil
        useCases = nil
        viewModel = nil
        super.tearDown()
    }

    func test_getAreas_shouldUpdateAreaListAndLoadTables() async {
        // Arrange
        let dummyAreas = [
            Area(id: 1, name: "Zone A", isSelect: false),
            Area(id: 2, name: "Zone B", isSelect: false),
            Area(id: 3, name: "Zone C", isSelect: false)
        ]
        mockRepo.getAreasResult = .success(APIResponse(data: dummyAreas, status: .ok, message: "ok"))
        mockRepo.getTablesResult = .success(APIResponse(data: [], status: .ok, message: "ok"))
        // When
        await viewModel.getAreas()
        // Then
        XCTAssertFalse(viewModel.area.isEmpty, "Area list should not be empty")
        XCTAssertEqual(viewModel.area.count,4)
        XCTAssertEqual(viewModel.area.first?.name, "Tất cả khu vực")
    }

    func test_getTables_shouldFilterWhenMerging() async {
        // Given
        let tables = [
            Table(id: 1, name: "A1", status: .booking),
            Table(id: 2, name: "A2", status: .closed)
        ]
        mockRepo.getTablesResult = .success(APIResponse(data: tables, status: .ok, message: "ok"))
        viewModel.orderAction = .mergeTable
        // When
        await viewModel.getTables(areaId: 1)
        dLog(viewModel.table.toDictionary())
        // Then
        XCTAssertEqual(viewModel.table.count, 1)
        XCTAssertEqual(viewModel.table.first?.name, "A2")
    }


    func test_moveTable_shouldSetNavigateBackTrueOnSuccess() async {
        // Given
        mockRepo.moveTableResult = .success(PlainAPIResponse(status: .ok, message: "Success"))
        // When
        await viewModel.moveTable(from: 1, to: 2)
        
        // Then
        XCTAssertTrue(viewModel.shouldNavigateBack)
        XCTAssertFalse(viewModel.presentDialog)
    }


    func test_mergeTable_shouldSetNavigateBackTrueOnSuccess() async {
        // Given
        mockRepo.mergeTableResult = .success(PlainAPIResponse(status: .ok, message: "Merged"))
        
        // When
        await viewModel.mergeTable(destinationTableId: 1, targetTableIds: [2,3])
        
        // Then
        XCTAssertTrue(viewModel.shouldNavigateBack)
        XCTAssertFalse(viewModel.presentDialog)
    }

}
