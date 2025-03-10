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
                ScrollView {
                    ForEach(viewModel.arrayOfTopic, id: \.id) { item in
                        VStack {
                            Text(item.title)
                            Text(item.text)
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .refreshable {
            viewModel.onAppear()
        }
    }
}

#Preview {
    MainView()
}
