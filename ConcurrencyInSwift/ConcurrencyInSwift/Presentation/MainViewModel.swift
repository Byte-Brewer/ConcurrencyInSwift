//
//  MainViewModel.swift
//  ConcurrencyInSwift
//
//  Created by Nazar Prysiazhnyi on 10.03.2025.
//
import Foundation

struct Topic: Identifiable {
    let id = UUID()
    let title: String
    let time: String
    let text: String
}

final class MainViewModel: ObservableObject {
    
    @Published var arrayOfTopic: [Topic] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var elapsedTime: Double = 0.0
    @Published var timer: Timer?
    @Published var showingAlert: Bool = false
    
    private let service: TopicServiceProtocol
    
    init(service: TopicServiceProtocol) {
        self.service = service
    }
    
    func onAppear() {
        getData()
    }
    
    private func getData() {
        isLoading = true
        startRequest()
        Task {
            do {
                let topic = try await service.getTopics()
                await MainActor.run {
                    isLoading = false
                    arrayOfTopic = topic
                    stopTimer()
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    errorMessage = error.localizedDescription
                    showingAlert = true
                    stopTimer()
                }
            }
        }
    }
    
    private func startRequest() {
        elapsedTime = 0.0
        timer?.invalidate() // Stop any existing timer
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.elapsedTime += 0.1
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
