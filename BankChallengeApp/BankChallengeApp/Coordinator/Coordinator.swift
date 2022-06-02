//
//  Coordinator.swift
//  BankChallengeApp
//
//  Created by Matheus Lenke on 01/06/22.
//

import Foundation

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get }
    
    func start()
}

