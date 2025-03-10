//
//  TopicService.swift
//  ConcurrencyInSwift
//
//  Created by Nazar Prysiazhnyi on 10.03.2025.
//

import Foundation

struct TopicData: Decodable {
    let id: String
    let title: String
}

struct Details: Decodable {
    let id: String
    let published_at: Int
    let description: String
}

protocol TopicServiceProtocol {
    func getTopics() async throws -> [Topic]
}

enum TopicServiceError: Error {
    case wrongMocPath
    case wrongTopicId
}

final class TopicService: TopicServiceProtocol {
    
    func getTopics() async throws -> [Topic] {
        try await Task.sleep(for: .seconds(1.0))
        
        let data = try HelperMocClass.getData(from: .allItems)
        let arrayOfTopics = try JSONDecoder().decode([TopicData].self, from: data)
        
        var results: [Topic] = []
        
        try await withThrowingTaskGroup(of: Topic.self) { group in
            for element in arrayOfTopics {
                group.addTask {
                    try await self.getTopicDetails(item: element)
                }
            }
            
            for try await result in group {
                results.append(result)
            }
        }
        return results
        
    }
    
    private func getTopicDetails(item: TopicData) async throws -> Topic {
        try await Task.sleep(for: .seconds(([5,6,7,8,9,10,11].randomElement() ?? 5)))
        
        let data = try HelperMocClass.getData(from: .detailItems)
        
        let arrayOfDescriptions = try JSONDecoder().decode([Details].self, from: data)
        
        guard let descriptions = arrayOfDescriptions.first(where: { $0.id == item.id }) else {
            throw TopicServiceError.wrongTopicId
        }
        
        return Topic(title: item.title, id: item.id, text: descriptions.description)
    }
    
    
}

final class HelperMocClass {
    enum MocFileName: String {
        case allItems = "mocResponse"
        case detailItems = "mocResponseDetails"
    }
    
    static func getData(from name: MocFileName) throws -> Data {
        let fileName: String = name.rawValue
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("Could not find \(fileName).json")
        }
        
        let data = try Data(contentsOf: url)
        return data
    }
}
