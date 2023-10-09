//
//  iOSEngineerCodeCheckUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest

class iOSEngineerCodeCheckUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {

        let app = XCUIApplication()
        app.launch()
        let emptyListTable = app.tables["Empty list"]
        emptyListTable.searchFields["GitHubのリポジトリを検索できるよー"].tap()
        emptyListTable.typeText("swift")
        app.buttons["Search"].tap()
        sleep(3)
        app.tables.staticTexts["ReactiveX/RxSwift"].tap()
        app.staticTexts["Open WebView"].tap()
        let closeWebViewStart = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.3))
        let closeWebViewEnd = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.9))
        sleep(1)
        closeWebViewStart.press(forDuration: 0.1, thenDragTo: closeWebViewEnd)
        app.navigationBars["iOSEngineerCodeCheck.DetailInfoView"].buttons["Back"].tap()
        
        app.tables.staticTexts["realm/SwiftLint"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Open WebView"]/*[[".buttons[\"Open WebView\"].staticTexts[\"Open WebView\"]",".staticTexts[\"Open WebView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        closeWebViewStart.press(forDuration: 0.1, thenDragTo: closeWebViewEnd)
        let swipViewStart = app.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.5))
        let swipViewEnd = app.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5))
        swipViewStart.press(forDuration: 0.1, thenDragTo: swipViewEnd)
        app.tables.searchFields["GitHubのリポジトリを検索できるよー"].buttons["Clear text"].tap()

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
