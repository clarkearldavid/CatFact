//
//  CatViewModel.swift
//  CatFact
//
//  Created by Clark David on 12/12/24.
//

import Foundation

class CatViewModel: ObservableObject {
    @Published var catFact: String = ""
    @Published var catImageURL: String = ""
    @Published var showLoading: Bool = false
    @Published var errorMessage: String?
    @Published var catURL = CatImage()
    let factURL = URL(string: "https://meowfacts.herokuapp.com/")!
    let imageURL = URL(string: "https://api.thecatapi.com/v1/images/search")!
    var fetchError: Error?
    
    func fetchCatData() {
        showLoading.toggle()
        errorMessage = nil
        
        var fetchedFact: String?
        var fetchedImageURL: CatImage?
        
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.fetchData(from: factURL) { (result: Result<CatFact, Error>) in
            switch result {
            case .success(let fact):
                fetchedFact = fact.data.first
            case .failure(let error):
                self.fetchError = error
            }
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.fetchData(from: imageURL) { (result: Result<[CatImage], Error>) in
            switch result {
            case .success(let images):
                fetchedImageURL = images.first
            case .failure(let error):
                self.fetchError = error
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            if let error = self.fetchError {
                self.errorMessage = error.localizedDescription
            } else {
                self.catFact = fetchedFact ?? "No fact available."
                self.catURL = fetchedImageURL ?? CatImage()
            }
            self.showLoading.toggle()
        }
    }
}
