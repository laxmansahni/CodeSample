//
//  CodingAssessmentAppTests.swift
//  CodingAssessmentAppTests
//
//  Created by Laxman Sahni on 26/06/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

import XCTest
import MBProgressHUD
import SDWebImage

@testable import CodingAssessmentApp

class CodingAssessmentAppTests: XCTestCase {
    var AppApiManagerUnderTest: AppApiManager!
    var viewControllerUnderTest: MasterTableViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        AppApiManagerUnderTest = AppApiManager.sharedInstance
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: UIMessages.kMasterViewControllerID) as! MasterTableViewController

        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
        self.viewControllerUnderTest.fetchArticleList()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        AppApiManagerUnderTest = nil
        viewControllerUnderTest = nil
    }
    
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        // XCTAssertNotNil(viewControllerUnderTest.tableView.dataSource)
        
        XCTAssertNotNil(viewControllerUnderTest.tableDataSource)
        
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.numberOfSections(in:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier()
    {
        if viewControllerUnderTest.tableDataSource.isEmpty == false
        {
            
            let cell = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ArticleTableViewCell
            let actualReuseIdentifer = cell?.reuseIdentifier
            let expectedReuseIdentifier = UIMessages.kTableViewCellID
            XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
        }
        
    }

    
    // Asynchronous test: success fast, failure slow
    func testValidCallToNYGetsHTTPStatusCode200() {
        // given
        // 1
        let promise = expectation(description: "Status code: 200")
        
       AppApiManagerUnderTest.getArticlesList { (response,customError) in
            // when
            if let error = customError {
                XCTFail("Error: \(error.description)")
                return
            } else if response != nil {
                    promise.fulfill()

            }
        }
        

        // 3
        waitForExpectations(timeout: 5, handler: nil)
    } 
}
