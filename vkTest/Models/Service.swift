//
//  Service.swift
//  vkTest
//
//  Created by Владислав Гайденко on 12.07.2022.
//

import Foundation

struct ServiceResponse: Decodable {
    let services : [Service]
}

struct Service: Decodable {
    let name: String?
    let description: String?
    let link: String?
    let icon_url: String?
}

extension ServiceResponse {
    
    enum CodingKeys: String, CodingKey {
        case body
        enum BodyKeys: String, CodingKey {
            case bodyKey = "services"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let servicesContainer = try container.nestedContainer(keyedBy: CodingKeys.BodyKeys.self, forKey: .body)
        services = try servicesContainer.decode([Service].self, forKey: .bodyKey)
    }
}
