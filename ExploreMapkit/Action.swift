//
//  Action.swift
//  ExploreMapkit
//
//  Created by Rosa Jeon on 2023-06-19.
//

import Foundation

struct Action: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let handler: () -> Void
}
