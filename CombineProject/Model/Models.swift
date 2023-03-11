//
//  Models.swift
//  CombineProject
//
//  Created by Mom macbook air on 3/10/23.
//

import Foundation


// Part 3
struct Player: Decodable, Identifiable {
    let id: Int
    let image: String
}


struct Flight: Decodable, Identifiable, Hashable {
    var id: Int
    var fare: Int
    var stops: Int
    var flightNumber: String?
    var company: String?
    var departure: String?
    var arrival: String?
    var duration: String?
    var source: String?
    var destination: String?
    var sourceCode: String?
    var destinationCode: String?
}

