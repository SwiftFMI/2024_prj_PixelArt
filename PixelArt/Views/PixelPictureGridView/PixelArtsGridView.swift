//
//  PixelPictureGridView.swift
//  PixelArt
//
//  Created by vnc003 on 19.02.25.
//

import SwiftUI

struct PixelArtsGridView: View {
    @EnvironmentObject private var pixelArtsViewModel: PixelArtsViewModel
    @State private var isLoading = false

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(pixelArtsViewModel.items) { picture in
                    NavigationLink(destination: PixelPictureScreen(picture: picture)) {
                        VStack {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                            Text(picture.name)
                                .font(.caption)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                                .frame(maxWidth: 100)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    }
                }
            }
            .padding()

            if isLoading {
                ProgressView()
            } else if pixelArtsViewModel.hasMoreData {
                Text("Load more...")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onAppear {
                        loadMore()
                    }
            } else {
                Text("No more images")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .task {
            await loadInitial()
        }
    }

    func loadInitial() async {
        isLoading = true
        await pixelArtsViewModel.loadInitial()
        isLoading = false
    }
    func loadMore() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            await pixelArtsViewModel.loadMore()
            isLoading = false
        }
    }
}


#Preview {
    PixelArtsGridView()
}
