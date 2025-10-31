//
//  AreaUseCasesTests.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 31/10/25.
//

import XCTest
@testable import My_restaurant_app

final class AreaUseCasesTests: XCTestCase {
    func test_getAreas_callsRepository() async {
        let repo = MockAreaRepository()
        let useCases = AreaUseCases(repository: repo)
        
        let result = await useCases.getAreas(branchId: 1, status: 1)
            switch result {
                case .success:
                    XCTAssertTrue(true)
                
                default:
                    XCTFail("Should return success")
        }
    }
}
