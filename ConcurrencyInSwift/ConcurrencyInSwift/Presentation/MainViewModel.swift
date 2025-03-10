//
//  MainViewModel.swift
//  ConcurrencyInSwift
//
//  Created by Nazar Prysiazhnyi on 10.03.2025.
//
import Foundation

struct Topic {
    let title: String
    let id: String
    let text: String
}

final class MainViewModel: ObservableObject {
    
    @Published var arrayOfTopic: [Topic] = []
    @Published var isLoading: Bool = false
    @Published var eroro: String = ""
    
    private let service: TopicServiceProtocol
    
    init(service: TopicServiceProtocol) {
        self.service = service
    }
    
    func onAppear() {
        getData()
    }
    
    private func getData() {
        isLoading = true
        Task {
            do {
                let topic = try await service.getTopics()
                await MainActor.run {
                    isLoading = false
                    arrayOfTopic = topic
                }
            } catch {
                isLoading = false
                eroro = error.localizedDescription
            }
        }
    }
}
