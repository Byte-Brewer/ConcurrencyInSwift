//
//  DetailsData.swift
//  ConcurrencyInSwift
//
//  Created by Nazar Prysiazhnyi on 10.03.2025.
//
import Foundation

struct DetailsData: Decodable {
    let id: String
    let publishedAt: Date
    let description: String
}
