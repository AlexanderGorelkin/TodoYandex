//
//  TodoItemTests.swift
//  TodoYandexTests
//
//  Created by Александр Горелкин on 21.06.2024.
//

import XCTest

@testable import TodoYandex

final class TodoItemTests: XCTestCase {
    
    func testCSV() throws {
        //csv with default model
        let modelFromSCV = TodoItem.parse(csv: TestData.csvString)[0]!
        XCTAssertEqual(modelFromSCV, TestData.defaultModel)
    }
    func testJSON() throws {
        let json = (TestData.defaultModel.json as! [String : Any])
        print("JSON: ", json)
        print("TestData: ", TestData.json)
        XCTAssert(NSDictionary(dictionary: TestData.json).isEqual(to: json))
    }
}
extension TodoItemTests {
    enum TestData {
        static let defaultModel = TodoItem.Seeds.model
        static let csvString = TodoItem.Seeds.csvString
        static let json = TodoItem.Seeds.jsonFormat
    }
}
