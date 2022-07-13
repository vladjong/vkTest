//
//  APICaller.swift
//  vkTest
//
//  Created by Владислав Гайденко on 12.07.2022.
//

import Foundation

enum APIError:Error {
    case failedToGetData
}

enum Constant {
    static let BASE_URL = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
}

class APICaller {
    static let shared = APICaller()
    
    func getServiceVK(completion: @escaping (Result<[Service], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.BASE_URL)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                print(Constant.BASE_URL)
                let services = try JSONDecoder().decode(ServiceResponse.self, from: data)
                print(services)
                completion(.success(services.services))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
