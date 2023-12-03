//
//  MapContainerView.swift
//  Coffee Shop App
//
//  Created by Bruno Lorenzo on 14/11/23.
//

import SwiftUI
import MapKit

struct MapContainerView: View {
    /// Environment properties
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var router: Router
    
    /// State properties
    @State private var position: MapCameraPosition = .automatic
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var route: MKRoute?
    @State private var selectedItem: Int?
    
    var body: some View {
        Map(position: $position) {
            Annotation("Coffee  Shop", coordinate: .coffeeShopCoordinate) {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 30, height: 30)
                    .overlay {
                        Image(systemName: "mappin.circle")
                            .resizable()
                    }
                    .onTapGesture {
                        getDirections()
                        getlookAroundScene()
                    }
            }
            
            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
            
            UserAnnotation()
        }
        .mapStyle(.standard(elevation: .realistic))
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
                        self.lookAroundScene = nil
                        self.route = nil
                        position = .automatic
                    }
                }
                .padding(.top, 16)
                .padding(.trailing, 16)
        })
        .safeAreaInset(edge: .bottom, content: {
            if let lookAroundScene {
                LookAroundPreview(initialScene: lookAroundScene)
                    .frame(height: 128)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding([.top, .horizontal])
                
            }
            
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    router.popToPrevious()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Home")
                    }
                }
            }
        }
        .onChange(of: selectedItem) {
            getDirections()
        }
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
    MapContainerView()
}
