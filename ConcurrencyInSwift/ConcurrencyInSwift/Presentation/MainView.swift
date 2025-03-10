//
//  MainView.swift
//  ConcurrencyInSwift
//
//  Created by Nazar Prysiazhnyi on 10.03.2025.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel: MainViewModel = .init(service: TopicService())
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                mainView
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .refreshable {
            viewModel.onAppear()
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Concurrency In Swift")
                        .font(.headline)
                    Text(viewModel.isLoading ? "Loading... \(String(format: "%.2f", viewModel.elapsedTime))s" : "Fetch complete in \(String(format: "%.2f", viewModel.elapsedTime))s")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    private var mainView: some View {
        List {
            ForEach(viewModel.arrayOfTopic, id: \.id) { item in
                ListItem(title: item.title,
                         descriptions: item.text,
                         time: item.time)
            }
        }
    }
}

#Preview {
    NavigationView {
        MainView()
    }
}
