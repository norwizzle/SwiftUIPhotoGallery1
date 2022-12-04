//
//  ContentView.swift
//  SwiftUIPhotoGallery
//
//  Created by Norwin Uy on 2022-12-03.
//

import SwiftUI

struct ContentView: View {
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @StateObject private var model = DataModel()

    var body: some View {
        NavigationView {
            VStack {
                NavigationStack{
                    ScrollView {
                        LazyVGrid(columns: gridItemLayout, spacing: 20) {
                            ForEach((0...symbols.count * 5), id: \.self) {
                                Image(systemName: symbols[$0 % symbols.count])
                                    .font(.system(size: 30))
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    .navigationTitle("Gallery")
                }
                HStack {
                    Button(action: {} ) {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .padding(20)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(12.0)
                    
                    Divider()
                    
                    NavigationLink (destination: CameraView()
                        .onAppear {
                            model.camera.isPreviewPaused = true
                        }
                        .onDisappear {
                            model.camera.isPreviewPaused = false
                        })
                    {
                        Button(action: {}) {
                            Label("Take Photo", systemImage: "camera")
                        }
                        .padding(20)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(12.0)
                    }
                }
                .frame(idealHeight: 30, maxHeight: 30, alignment: Alignment.center)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
