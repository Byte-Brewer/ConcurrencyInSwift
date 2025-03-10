//
//  HelperMocClass.swift
//  ConcurrencyInSwift
//
//  Created by Nazar Prysiazhnyi on 10.03.2025.
//

import Foundation

final class HelperMocClass {
    
    enum MocFileName: String {
        case allItems = "mocResponse"
        case detailItems = "mocResponseDetails"
    }
    
    static func getData<T: Decodable>(from name: MocFileName) throws -> T {
        let fileName: String = name.rawValue
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("Could not find \(fileName).json")
        }
        
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let arrayOfResults = try decoder.decode(T.self, from: data)
        
        return arrayOfResults
    }
}
