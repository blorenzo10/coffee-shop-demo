//
//  MapDemoView.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 26/11/23.
//

import SwiftUI
import MapKit

struct MapDemoView: View {
    @State private var position: MapCameraPosition = .automatic
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var route: MKRoute?
    
    var body: some View {
        Map(position: $position){
            Annotation("Coffee  Shop", coordinate: .coffeeShopCoordinate, anchor: .bottom) {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 30, height: 30)
                    .overlay {
                        Image(systemName: "mappin.circle")
                            .resizable()
                        
                    }
                    .onTapGesture {
                        getlookAroundScene()
                    }
            }
            
            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
        }
        .safeAreaInset(edge: .bottom, content: {
            if let lookAroundScene {
                LookAroundPreview(initialScene: lookAroundScene)
                    .frame(height: 128)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding([.top, .horizontal])
                
            }
            
        })
        .safeAreaInset(edge: .top, alignment: .trailing, content: {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: "cup.and.saucer.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.accentColor)
                }
                .onTapGesture {
                    withAnimation {
                        position = .automatic
                    }
                }
                .padding(.trailing, 6)
        })
        .mapStyle(.standard(elevation: .realistic, pointsOfInterest: .including([.cafe]), showsTraffic: true))
        
    }
    
    func getlookAroundScene() {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(coordinate: .coffeeShopCoordinate)
            lookAroundScene = try? await request.scene
        }
    }
    
    func getDirections() {
        route = nil
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: .init(coordinate: .userLocationCoordinate))
        request.destination = MKMapItem(placemark: .init(coordinate: .coffeeShopCoordinate))
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            withAnimation {
                route = response?.routes.first
            }
        }
    }
}

#Preview {
    MapDemoView()
}
