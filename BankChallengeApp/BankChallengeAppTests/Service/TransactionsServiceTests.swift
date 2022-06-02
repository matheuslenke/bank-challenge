//
//  TransactionsServiceTests.swift
//  BankChallengeAppTests
//
//  Created by Matheus Lenke on 01/06/22.
//

import XCTest
@testable import BankChallengeApp

class TransactionsServiceTests: XCTestCase {

    // MARK: - Private Variables
    private var sut: TransactionsService!
    private var networkClientMock: NetworkClientMock!

    override func setUp() {
        networkClientMock = NetworkClientMock()
        sut = TransactionsService(networkClient: networkClientMock)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTransactionsServiceFetchBalanceMethod_WhenJSONDecoded_ShouldHaveCorrectInformations() {
        let expectations = self.expectation(description: "When JSON is decoded, it should have correct informations")
        var result: Balance?

        networkClientMock.expectedResponse = .successWithCustomJson("balance")

        sut.fetchBalance { response in
            switch response {
            case .failure(_):
                XCTFail("Api returned error")

            case .success(let balance):
                result = balance
            }
            expectations.fulfill()
        }

        waitForExpectations(timeout: 3.0)

        XCTAssertEqual(result?.amount, 54321, "the received name property fails becuase is not equal to json payload.")
    }

}
