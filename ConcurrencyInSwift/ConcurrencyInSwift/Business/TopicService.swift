//
//  TopicService.swift
//  ConcurrencyInSwift
//
//  Created by Nazar Prysiazhnyi on 10.03.2025.
//

import Foundation

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
        
        let arrayOfTopics: [TopicData] = try HelperMocClass.getData(from: .allItems)
        
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
        try await Task.sleep(for: .seconds(([5,6].randomElement() ?? 5)))
        
        let arrayOfDescriptions: [DetailsData] = try HelperMocClass.getData(from: .detailItems)
        
        guard let descriptions = arrayOfDescriptions.first(where: { $0.id == item.id }) else {
            throw TopicServiceError.wrongTopicId
        }
        
        return Topic(title: item.title,
                     time: descriptions.publishedAt.formatted(date: .abbreviated, time: .standard),
                     text: descriptions.description)
    }
}
