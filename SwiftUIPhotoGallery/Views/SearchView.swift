//
//  SearchView.swift
//  SwiftUIPhotoGallery
//
//  Created by Norwin Uy on 2022-12-03.
//

import SwiftUI
import MapKit

private var latitude =  0.00
private var longitude = 0.00
private var descSearchTerm = ""

struct SearchView: View {
    var coordinate: CLLocationCoordinate2D
    
    var body: some View {
        NavigationView {
            MapSearchView(coordinate: CLLocationCoordinate2D(latitude: 49.2827, longitude: -123.1207))
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
    }
}
