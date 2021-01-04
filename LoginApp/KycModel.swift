//
//  KycModel.swift
//  LoginApp
//
//  Created by Pixel on 17/12/20.
//

import Foundation


struct Kyc: Codable {
    let success: Bool
    let result: Resultt
    let message: String
}

// MARK: - Result
struct Resultt: Codable {
    let id: Int
}





