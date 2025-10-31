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
    var viewModel: AreaViewModel!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockAreaRepository()
        let useCases = AreaUseCases(repository: mockRepo)
        viewModel = AreaViewModel(useCases: useCases)
    }
    
    override func tearDown() {
        mockRepo = nil
        viewModel = nil
        super.tearDown()
    }

    func test_getAreas_success_shouldSetAreaList() async {
        // Arrange
        let dummyAreas = [Area(id: 1, name: "A1", isSelect: false)]
        mockRepo.getAreasResult = .success(dummyAreas)
        mockRepo.getTablesResult = .success([])

        // Act
        await viewModel.getAreas()

        // Assert
        XCTAssertEqual(viewModel.area.count, 2, "Should include dummyAreas + 'Tất cả khu vực'")
        XCTAssertEqual(viewModel.area.first?.name, "Tất cả khu vực")
    }

    func test_getAreas_failure_shouldLogError() async {
        // Arrange
        mockRepo.getAreasResult = .failure(NSError(domain: "", code: -1))
        
        // Act
        await viewModel.getAreas()
        
        // Assert
        XCTAssertTrue(viewModel.area.isEmpty)
    }

    func test_getTables_success_shouldAssignTables() async {
        // Arrange
        let tables = [Table(id: 1, name: "T1", status: .closed)]
        mockRepo.getTablesResult = .success(tables)
        
        // Act
        await viewModel.getTables(areaId: 1)
        
        // Assert
        XCTAssertEqual(viewModel.table.first?.name, "T1")
    }

    func test_moveTable_success_shouldNavigateBack() async {
        // Arrange
        mockRepo.moveTableResult = .success(())
        
        // Act
        await viewModel.moveTable(from: 1, to: 2)
        
        // Assert
        XCTAssertTrue(viewModel.shouldNavigateBack)
        XCTAssertFalse(viewModel.presentDialog)
    }
    
    func test_mergeTable_failure_shouldNotNavigateBack() async {
        // Arrange
        mockRepo.mergeTableResult = .failure(NSError(domain: "", code: -1))
        
        // Act
        await viewModel.mergeTable(destinationTableId: 1, targetTableIds: [2, 3])
        
        // Assert
        XCTAssertFalse(viewModel.shouldNavigateBack)
    }
}
