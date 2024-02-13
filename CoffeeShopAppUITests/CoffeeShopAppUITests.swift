//
//  CoffeeShopAppUITests.swift
//  CoffeeShopAppUITests
//
//  Created by Bruno Lorenzo on 5/2/24.
//

import XCTest

final class CoffeeShopAppUITests: XCTestCase {

    var app: XCUIApplication!
    let maxNumberOfSwipes = 5
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-ui-test")
        app.launchEnvironment["-ui-test-apiURL"] = "https://myapi.uitest.com"
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testTabBarComponents() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Home"].exists)
        XCTAssert(tabBar.buttons["Data"].exists)
        XCTAssert(tabBar.buttons["Settings"].exists)
    }
    
    func testHomeComponents() {
        XCTAssert(app.buttons["MapButton"].exists)
        XCTAssert(app.buttons["HistoryButton"].exists)
    }
    
    func testDataComponents() {
        let tabBar = app.tabBars["Tab Bar"]
        let dataItem = tabBar.buttons["Data"]
        dataItem.tap()
        
        XCTAssert(app.descendants(matching: .staticText)["Total"].waitForExistence(timeout: 5))
        app.swipeUp()
        XCTAssert(app.descendants(matching: .staticText)["Show Average"].waitForExistence(timeout: 5))
    }
    
    func testPlaceOrder() {

        // Step 1
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.images[Identifiers.MenuItem.LATTE].tap()
        app.buttons[Identifiers.Buttons.ADD_ITEM].tap()
        scrollViewsQuery.images[Identifiers.MenuItem.CROISSANT].tap()
        app.steppers[Identifiers.Steppers.QUANTITY].buttons[Identifiers.Steppers.INCREMENT].tap()
        app.buttons[Identifiers.Buttons.ADD_ITEM].tap()
        
        // Step 3
        var swipes = 0
        while !app.buttons[Identifiers.Buttons.CHECKOUT].isHittable && swipes < maxNumberOfSwipes {
            app.swipeUp()
            swipes += 1
        }
        app.buttons[Identifiers.Buttons.CHECKOUT].tap()
        
        // Step 4
        app.buttons[Identifiers.Buttons.PLACE_ORDER].tap()
        
        // Step 5
        let alertButton = app.alerts.buttons["Ok"]
        if alertButton.waitForExistence(timeout: 2) {
            alertButton.tap()
        }
        
        // Step 6
        XCTAssert(app.buttons["MapButton"].exists)
    }
}
