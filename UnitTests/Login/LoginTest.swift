//
//  LoginTest.swift
//  UnitTests
//
//  Created by Pham Khanh Huy on 17/10/25.
//

import XCTest
@testable import My_restaurant_app

final class LoginTest: XCTestCase {
    var sut: LoginViewModel! // System Under Test

    override func setUp() {
        super.setUp()
        sut = LoginViewModel()
    }

    override func tearDown() {
        // Clean up after each test
        sut = nil
        super.tearDown()
    }
    
  
    // Test case: The login from valid or not when fields are empty
    func test_loginForm_valid() {
        //when restarant_name is empty
        sut.restaurant = ""
        sut.username = "tr000001"
        sut.password = "Mtt01234@"
        XCTAssertFalse(sut.valid)
        
        //when username is empty
        sut.restaurant = "mttest2o1"
        sut.username = ""
        sut.password = "Mtt01234@"
        XCTAssertFalse(sut.valid)
        
        //when password is empty
        sut.restaurant = "mttest2o1"
        sut.username = "tr000001"
        sut.password = ""
        XCTAssertFalse(sut.valid)
        
        
        sut.restaurant = "mttest2o1"
        sut.username = "tr000001"
        sut.password = "Mtt01234@"
        XCTAssertTrue(sut.valid)
    }
    
    // Test case: The login form is valid and fields are populated, but still be disable
    func test_loginForm_valid_but_still_be_disabled() {
        
        sut.restaurant = "mttest2o1"
        sut.username = "tr000001"
        sut.password = "Mtt01234@"
        // Then
        XCTAssertFalse(!sut.valid)
    }

    // Test case: A successful login should update the `isLoggedIn` state

    func test_successfulLogin_updatesUserState() async {
        // Given
        sut.restaurant = "mttest2o1"
        sut.username = "tr000001"
        sut.password = "Mtt01234@"
        // When
        await sut.getSession()
        
        // Then
        XCTAssertEqual(AppState.shared.userState, .loggedIn)
    }
    

    func test_Login_fail_and_updatesUserState() async {
        // Given
        sut.restaurant = "mttest2o1"
        sut.username = "tr000001"
        sut.password = "asdasdsa"
        // When
        await sut.getSession()
        
        // Then
        XCTAssertEqual(AppState.shared.userState, .notLoggedIn)
    }

}
