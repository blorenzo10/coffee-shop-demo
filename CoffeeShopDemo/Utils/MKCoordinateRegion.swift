//
//  MKCoordinateRegion.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 15/11/23.
//

import MapKit

extension MKCoordinateRegion {
    static let coffeeShopStore = MKCoordinateRegion(
        center: .coffeeShopCoordinate,
        span: .init(latitudeDelta: 0, longitudeDelta: 0)
    )
}
