//
//  BreedsListResponse.swift
//  Randog
//
//  Created by Binyamin Alfassi on 10/09/2020.
//  Copyright © 2020 Binyamin Alfassi. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
