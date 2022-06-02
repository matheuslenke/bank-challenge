//
//  TransactionTableViewCellTests.swift
//  BankChallengeAppTests
//
//  Created by Matheus Lenke on 02/06/22.
//

import XCTest
import SnapshotTesting
@testable import BankChallengeApp

class TransactionTableViewCellTests: XCTestCase {
    private var size = CGSize(width: 414, height: 149)
    private var sut: TransactionTableViewCell!
    private var isRecording: Bool = false
    private var mockVC: SnapshotMockViewController!

    override func setUpWithError() throws {
        try super .setUpWithError()
        sut = TransactionTableViewCell()
    }

    override func tearDownWithError() throws {
       try super.tearDownWithError()
       sut = nil
    }

    func test_TransactionTableViewCell_WithoutPixLabel() {
        let isoDate = "2022-07-01T10:44:00+0000"

        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)!
        
        let transaction = Transaction(tType: .transferin,
                                      amount: 123,
                                      to: "Fulano",
                                      id: "12345",
                                      itemDescription: "Transação realizada",
                                      createdAt: date,
                                      bankName: "Banco",
                                      from: "Ciclano",
                                      authentication: "Código123")
        mockVC = SnapshotMockViewController()
        sut.heightAnchor.constraint(equalToConstant: 100).isActive = true
        mockVC.configureView(child: sut)
        
        sut.setup(with: transaction)
        
        assertSnapshot(matching: mockVC, as: .image(on: .iPhone8), record: isRecording)
        assertSnapshot(matching: mockVC, as: .image(on: .iPhoneX), record: isRecording)
        assertSnapshot(matching: mockVC, as: .image(on: .iPhone8Plus), record: isRecording)
        assertSnapshot(matching: mockVC, as: .image(on: .iPhoneXr), record: isRecording)
        assertSnapshot(matching: mockVC, as: .image(on: .iPhoneXsMax), record: isRecording)
    }

}
