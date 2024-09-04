//
//  ContentView.swift
//  MeliSwiftUI
//
//  Created by Pedro Andres Villamil on 31/08/24.
//

import SwiftUI
import OSLog

class AppViewModel: ObservableObject {
    // MARK: Home Properties
    @Published var currentMenu: String = "All"
    // MARK: Detail View Properties
    @Published var showDetailView: Bool = false
    @Published var currentItemSelected: ResultItem?
}


struct ContentView: View {
    
    @StateObject var appModel: AppViewModel = .init()
    @Namespace var animation
    
    var body: some View {
        SearchView(animation: animation)
            .environmentObject(appModel)
            .overlay {
                if let product = appModel.currentItemSelected, appModel.showDetailView {
                    // MARK: Detail View
                    ProductDetailView(animation: animation, id: product.id)
                        .environmentObject(appModel)
                        .transition(.offset(x: 1, y: 1))
                }
            }
    }
}

#Preview {
    ContentView()
}
