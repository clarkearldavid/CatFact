//
//  NetworkManager.swift
//  CatFact
//
//  Created by Clark David on 12/12/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchData<T: Codable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NSError(domain: "NetworkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
