//
//  PixelArtsViewModel.swift
//  PixelArt
//
//  Created by vnc003 on 19.02.25.
//
import SwiftUI
import FirebaseFirestore

class PixelArtsViewModel: ObservableObject {
    @Published var items: [PixelPictureData] = []
    @Published var hasMoreData = true
    @Published var fetchError: String?

    private let db = Firestore.firestore()
    let picturesCollectionName = "pictures"
    let creationDateAttributeName = "createdOn"
    
    private var lastDocument: QueryDocumentSnapshot? = nil
    private let pageSize = 10

    func loadInitial() async {
        do {
            let snapshot = try await db.collection(picturesCollectionName)
                .order(by: creationDateAttributeName, descending: true)
                .limit(to: pageSize)
                .getDocuments()

            self.items = snapshot.documents.compactMap { try? $0.data(as: PixelPictureData.self) }
            self.lastDocument = snapshot.documents.last
            self.hasMoreData = snapshot.documents.count == self.pageSize
        } catch {
            fetchError = "Error fetching initial data: \(error.localizedDescription)"
        }
    }

    func loadMore() async {
        guard let lastDocument = lastDocument, hasMoreData else {
            return
        }
        
        do {
            let snapshot = try await db.collection(picturesCollectionName)
                .order(by: creationDateAttributeName, descending: true)
                .start(afterDocument: lastDocument)
                .limit(to: pageSize)
                .getDocuments()

            let newItems = snapshot.documents.compactMap { try? $0.data(as: PixelPictureData.self) }
            self.items.append(contentsOf: newItems)
            self.lastDocument = snapshot.documents.last
            self.hasMoreData = snapshot.documents.count == self.pageSize
        } catch {
            fetchError = "Error fetching more data: \(error.localizedDescription)"
        }
    }
    
    func savePicture(picture: PixelPictureData) {
        do {
            try db.collection(picturesCollectionName).document(picture.id).setData(from: picture)
        } catch {
            fetchError = "Error saving picture: \(error.localizedDescription)"
        }
    }
    
    func resetErrorStatus() {
        fetchError = ""
    }
}
