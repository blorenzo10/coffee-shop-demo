//
//  CoffeeShopAppTests.swift
//  CoffeeShopAppTests
//
//  Created by Bruno Lorenzo on 28/1/24.
//

import XCTest
@testable import Coffee_Shop_App

final class OrderTests: XCTestCase {
    
    private var ordersManager: OrdersManager!

    override func setUpWithError() throws {
        ordersManager = OrdersManager.shared
    }

    override func tearDownWithError() throws {
        ordersManager.removeAllOrders()
        ordersManager = nil
    }

    func testAddNewOrder() {
        let orderItems: [OrderItem] = [
            .init(item: AnyMenuItem(Coffee.flatwhite), size: .regular, quantity: 5),
        ]
        let order = Order(items: orderItems)
        
        XCTAssertNoThrow(try ordersManager.add(order))
        
        XCTAssertEqual(ordersManager.orders.count, 1, "Order was not added correctly")
    }
    
    func testAddNewOrderMinimumNotMet() {
        let orderItems: [OrderItem] = [
            .init(item: AnyMenuItem(Coffee.flatwhite), size: .regular, quantity: 1),
        ]
        let order = Order(items: orderItems)
        
        XCTAssertThrowsError(try ordersManager.add(order)) { error in
            if let appError = error as? AppError, let errorType = appError.type as? OrderError {
                XCTAssertEqual(errorType.code, 2)
            } else {
                XCTFail("Wrong error type triggered")
            }
        }
    }
    
    func testRepeatLastOrder() {
        ordersManager.repeatLastOrder()
        XCTAssertEqual(ordersManager.orders.count, 0)
        
        let orderItems: [OrderItem] = [
            .init(item: AnyMenuItem(Coffee.flatwhite), size: .regular, quantity: 1),
            .init(item: AnyMenuItem(Food.chickenSandwich), size: .regular, quantity: 1),
        ]
        let order = Order(items: orderItems)
        XCTAssertNoThrow(try ordersManager.add(order))
        ordersManager.repeatLastOrder()
        
        XCTAssertEqual(ordersManager.orders.count, 2)
    }
    
    func testGetLastCoffee() {
        let latte = OrderItem(item: AnyMenuItem(Coffee.latte), size: .small, quantity: 1)
        let sandwich = OrderItem(item: AnyMenuItem(Food.chickenSandwich), size: .regular, quantity: 1)
        let orderItems: [OrderItem] = [latte, sandwich]
        let order = Order(items: orderItems)
        
        XCTAssertNoThrow(try ordersManager.add(order))
        let lastCoffeeDescription = ordersManager.getLastCoffee()
        
        XCTAssertNotNil(lastCoffeeDescription)
        XCTAssertEqual(latte.itemDescription, lastCoffeeDescription)
    }
    
    func testGetLastCoffeeWithNoCoffee() {
        let sandwich = OrderItem(item: AnyMenuItem(Food.chickenSandwich), size: .regular, quantity: 1)
        let order = Order(items: [sandwich])
        
        XCTAssertNoThrow(try ordersManager.add(order))
        let lastCoffeeDescription = ordersManager.getLastCoffee()
        XCTAssertNil(lastCoffeeDescription)
    }
    
    func testOrdersWithCoffee() {
        let latte = OrderItem(item: AnyMenuItem(Coffee.latte), size: .small, quantity: 3)
        let sandwich = OrderItem(item: AnyMenuItem(Food.chickenSandwich), size: .regular, quantity: 1)
        
        XCTAssertNoThrow(try ordersManager.add(Order(items: [sandwich])))
        
        XCTAssertEqual(ordersManager.ordersWithCoffee(), 0)
        
        XCTAssertNoThrow(try ordersManager.add(Order(items: [latte])))
        
        XCTAssertEqual(ordersManager.ordersWithCoffee(), 1)
    }
}
