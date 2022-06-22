//
//  Session.swift
//  DESkooveChallenge
//
//  Created by Kerem on 20.06.2022.
//

import Foundation

// MARK: - Session data
struct Session: Codable {
    let sessionID: String

    enum CodingKeys: String, CodingKey {
        case sessionID = "sessionId"
    }
}
