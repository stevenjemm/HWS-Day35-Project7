//
//  Petition.swift
//  HWS-Day33
//
//  Created by Steven Jemmott on 11/11/2019.
//  Copyright © 2019 Lagom Exp. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
