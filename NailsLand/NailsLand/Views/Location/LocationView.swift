//
//  LocationView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI
import MapKit
struct LocationView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.639057, longitude: 24.637265), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    var body: some View {
    Map(coordinateRegion: $region,showsUserLocation: true)
            .ignoresSafeArea()
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
