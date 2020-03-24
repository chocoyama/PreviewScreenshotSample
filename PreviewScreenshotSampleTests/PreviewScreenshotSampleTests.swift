//
//  PreviewScreenshotSampleTests.swift
//  PreviewScreenshotSampleTests
//
//  Created by Takuya Yokoyama on 2020/03/24.
//  Copyright © 2020 Takuya Yokoyama. All rights reserved.
//

import XCTest
@testable import PreviewScreenshotSample
import SwiftUI
import FBSnapshotTestCase

class PreviewScreenshotSampleTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        self.recordMode = true
    }

    func test() {
        ContentView_Previews.Context.screenshot(self)
    }
}

extension Previewable where Self.AllCases: RandomAccessCollection, Self.RawValue == String {
    static func screenshot(_ testCase: FBSnapshotTestCase) {
        Self.allCases.forEach { (ctx) in
            ctx.screenshot(testCase)
        }
    }

    func screenshot(_ testCase: FBSnapshotTestCase) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: self.preview)
        window.makeKeyAndVisible()
        let expectation = testCase.expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            testCase.FBSnapshotVerifyView(window.rootViewController!.view, identifier: self.rawValue)
            expectation.fulfill()
        }
        testCase.wait(for: [expectation], timeout: 5.0)
    }
}
