//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Yukichi Kawada on 8/19/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MealListView(viewModel: MealListViewModel())
    }
}

#Preview {
    ContentView()
}
