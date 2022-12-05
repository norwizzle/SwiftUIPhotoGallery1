//
//  ContentView.swift
//  SwiftUIPhotoGallery
//
//  Created by Norwin Uy on 2022-12-03.
//

import SwiftUI
import CoreLocation

struct ContentView: View {

    @ObservedObject var photoCollection : PhotoCollection
    
    @Environment(\.displayScale) private var displayScale
        
    private static let itemSpacing = 12.0
    private static let itemCornerRadius = 15.0
    private static let itemSize = CGSize(width: 90, height: 90)
    
    private var imageSize: CGSize {
        return CGSize(width: Self.itemSize.width * min(displayScale, 2), height: Self.itemSize.height * min(displayScale, 2))
    }
    
    private let columns = [
        GridItem(.adaptive(minimum: itemSize.width, maximum: itemSize.height), spacing: itemSpacing)
    ]
    
    @StateObject private var model = DataModel()
    
    private var photoCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: 49.0,
            longitude: 120.0)
    }

    var body: some View {
        NavigationView {
            VStack {
                NavigationStack{
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: Self.itemSpacing) {
                            ForEach(photoCollection.photoAssets) { asset in
                                NavigationLink {
                                    PhotoView(asset: asset, cache: photoCollection.cache)
                                } label: {
                                    photoItemView(asset: asset)
                                }
                                .buttonStyle(.borderless)
                                .accessibilityLabel(asset.accessibilityLabel)
                            }
                        }
                        .padding([.vertical], Self.itemSpacing)
                        Text(String(photoCollection.photoAssets.count) + " photos in library.")
                        
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .statusBar(hidden: false)
                    .navigationTitle("Gallery")
                }
                
                Divider()
                HStack {
                    NavigationLink {
                        SearchView(coordinate: photoCoordinates)
                    } label: {
                        Label("Search", systemImage: "magnifyingglass")
                            .padding(20)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(12.0)
                            .frame(maxWidth: .infinity)
                    }
                    
                    NavigationLink {
                        CameraView()
                    } label: {
                        Label("Snap", systemImage: "camera")
                            .padding(20)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(12.0)
                            .frame(maxWidth: .infinity)
                    }
                    
                }
                .frame(idealHeight: 30, maxHeight: 30, alignment: Alignment.center)
                .padding([.top], 20)
            }
        }

    
    }
    
    private func photoItemView(asset: PhotoAsset) -> some View {
        PhotoItemView(asset: asset, cache: photoCollection.cache, imageSize: imageSize)
            .frame(width: Self.itemSize.width, height: Self.itemSize.height)
            .clipped()
            .cornerRadius(Self.itemCornerRadius)
            .overlay(alignment: .bottomLeading) {
                if asset.isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 1)
                        .font(.callout)
                        .offset(x: 4, y: -4)
                }
            }
            .onAppear {
                Task {
                    await photoCollection.cache.startCaching(for: [asset], targetSize: imageSize)
                }
            }
            .onDisappear {
                Task {
                    await photoCollection.cache.stopCaching(for: [asset], targetSize: imageSize)
                }
            }
    }
}


