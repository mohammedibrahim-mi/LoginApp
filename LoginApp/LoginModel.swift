//
//  LoginModel.swift
//  LoginApp
//
//  Created by Pixel on 17/12/20.
//

import Foundation


struct Login: Codable {
    let result: Result? 
    let success, error: Bool
    let message: String
}


struct Result: Codable {
    let accessToken, tokenType: String?
    let expiresIn: Int?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}




