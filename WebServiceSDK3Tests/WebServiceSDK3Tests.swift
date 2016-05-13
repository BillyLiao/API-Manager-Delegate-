//
//  WebServiceSDK3Tests.swift
//  WebServiceSDK3Tests
//
//  Created by 廖慶麟 on 2016/5/6.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import XCTest
@testable import WebServiceSDK3

class WebServiceSDK3Tests: XCTestCase, WebServiceDelegate {
    var manager: APIManager!
    var getExpectation: XCTestExpectation?
    var postExpectation: XCTestExpectation?
    var fetchExpectation: XCTestExpectation?
    var errorExpectation: XCTestExpectation?
    var getResponseObject: NSDictionary?
    var postResponseObject: NSDictionary?
    var fetchedImage: UIImage?
    var error: NSError?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manager = APIManager()
        manager.delegate = self
        getExpectation = nil
        postExpectation = nil
        fetchExpectation = nil
        errorExpectation = nil
        error = nil
        getResponseObject = nil
        postResponseObject = nil
        fetchedImage = nil
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetReuqest() {
        
        getExpectation = expectationWithDescription("Get Succeed")
        manager.getRequest()
        
        waitForExpectationsWithTimeout(30) { (err) -> Void in
            print(err?.localizedDescription)
        }

    }
    
    func testPostRequest() {
        postExpectation = expectationWithDescription("Post Succeed")
        manager.postCustomerName("Billy")
        
        waitForExpectationsWithTimeout(30) { (err) -> Void in
            print(err?.localizedDescription)
        }
    }
    
    func testFetctImage() {
        fetchExpectation = expectationWithDescription("Fetch Succeed")
        manager.fetchImage()
        
        waitForExpectationsWithTimeout(30) { (err) -> Void in
            print(err?.localizedDescription)
        }
    }
    
    func testGetInterrupted(){
        postExpectation = expectationWithDescription("Get be interrupted")
        manager.getRequest()
        manager.postCustomerName("Billy")
        
        waitForExpectationsWithTimeout(30) { (err) -> Void in
            print(err?.localizedDescription)
        }
    }
    
    func testPostInterrupted(){
        getExpectation = expectationWithDescription("Post be interrupted")
        manager.postCustomerName("Billy")
        manager.getRequest()
        
        waitForExpectationsWithTimeout(30) { (err) -> Void in
            print(err?.localizedDescription)
        }
    }
    
    func testFetchInterrupted(){
        getExpectation = expectationWithDescription("Fetch be interrupted")
        manager.fetchImage()
        manager.getRequest()
        
        waitForExpectationsWithTimeout(30) { (err) -> Void in
            print(err?.localizedDescription)
        }
    }
    
    func getRequestDidFinished(r: NSDictionary?){
        getExpectation?.fulfill()
        getResponseObject = r
        XCTAssertNotNil(getResponseObject)
        XCTAssertNil(fetchedImage)
        XCTAssertNil(postResponseObject)
        XCTAssertNil(error)
    }
    
    func fetchImageDidFinished(i: UIImage?){
        fetchExpectation?.fulfill()
        fetchedImage = i
        XCTAssertNotNil(fetchedImage)
        XCTAssertNil(getResponseObject)
        XCTAssertNil(postResponseObject)
        XCTAssertNil(error)
    }
    
    func postNameDidFinished(r: NSDictionary?){
        postExpectation?.fulfill()
        postResponseObject = r
        XCTAssertNotNil(postResponseObject)
        XCTAssertNil(getResponseObject)
        XCTAssertNil(fetchedImage)
        XCTAssertNil(error)
    }
    
    func requestFailed(e: NSError?){
        errorExpectation?.fulfill()
        error = e
        XCTAssertNotNil(error)
        XCTAssertNil(getResponseObject)
        XCTAssertNil(fetchedImage)
        XCTAssertNil(postResponseObject)
    }
}
