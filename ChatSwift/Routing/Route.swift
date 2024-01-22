//
//  Route.swift
//  ChatSwift
//
//  Created by Martin Wainaina on 22/01/2024.
//

import Foundation

enum Route: Hashable {
    case profile(User)
    case chatView(User)
}
