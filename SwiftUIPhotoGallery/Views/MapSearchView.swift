//
//  MapSearchView.swift
//  SwiftUIPhotoGallery
//
//  Created by Norwin Uy on 2022-12-04.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
    
    var coordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        Map(coordinateRegion: $region)
            .task{
                setRegion(coordinate)
            }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8)
        )
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
    }
}

