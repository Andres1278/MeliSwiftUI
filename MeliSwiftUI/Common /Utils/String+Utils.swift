//
//  String+Utils.swift
//  MeliSwiftUI
//
//  Created by Pedro Andres Villamil on 31/08/24.
//

import Foundation

extension String {
    
    static let empty = ""
    
    func loadJson() -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: self, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
