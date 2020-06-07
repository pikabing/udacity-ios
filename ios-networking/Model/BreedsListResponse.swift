//
//  BreedsListResponse.swift
//  ios-networking
//
//  Created by Pratik on 07/06/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
