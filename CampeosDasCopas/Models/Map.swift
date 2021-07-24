//
//  Map.swift
//  CampeosDasCopas
//
//  Created by Paulo Menezes on 24/07/21.
//

import Foundation

struct Map: Codable {
    var results: [MapResult]
}

struct MapResult: Codable {
    var geometry: Geometry
}

struct Geometry: Codable {
    var lat: Double
    var lng: Double
}
