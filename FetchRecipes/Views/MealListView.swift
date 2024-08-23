//
//  MealListView.swift
//  FetchRecipes
//
//  Created by Yukichi Kawada on 8/19/24.
//

import SwiftUI

struct MealListView: View {
    @StateObject var viewModel: MealListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.meals.isEmpty {
                    Button {
                        viewModel.fetchList()
                    } label: {
                        Text("Fetch Meals")
                    }
                } else {
                    Button {
                        viewModel.clearMeals()
                    } label: {
                        Text("Clear Meals")
                    }
                    List {
                        ForEach(viewModel.meals) { meal in
                            NavigationLink(destination: MealDetailView(viewModel: .init(idMeal: meal.idMeal))) {
                                Text(meal.strMeal)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MealListView(viewModel: MealListViewModel())
}
