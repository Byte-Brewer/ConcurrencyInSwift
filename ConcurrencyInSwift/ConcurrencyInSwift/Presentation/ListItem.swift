//
//  ListItem.swift
//  ConcurrencyInSwift
//
//  Created by Nazar Prysiazhnyi on 10.03.2025.
//

import SwiftUI

struct ListItem: View {
    
    let title: String
    let descriptions: String
    let time: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .bold()
            Text(descriptions)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(time)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(Font.system(size: 12))
                .italic()
        }
        .padding()
    }
}

#Preview {
    ListItem(title: "Combine Framework",
             descriptions: "An in-depth introduction to the Combine framework for reactive programming in Swift, covering how to work with publishers, subscribers, operators, and handling asynchronous data streams efficiently.",
             time: "1973-11-29 21:32:03")
}
