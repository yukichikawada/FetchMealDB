//
//  MealDetailView.swift
//  FetchRecipes
//
//  Created by Yukichi Kawada on 8/19/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject var viewModel: MealDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                if let title = viewModel.mealDetails?.strMeal {
                    Text(title)
                        .font(.title)
                } else {
                    Text("Missing Name")
                }
                
                // Section
                Text("Instructions")
                    .font(.title2)
                    .padding(.bottom, 24)
                if let instructions = viewModel.mealDetails?.strInstructions {
                    Text(instructions)
                } else {
                    Text("Missing Instructions")
                }
                
                
                // Section
                if let ingredientsAndMeasures = viewModel.mealDetails?.ingredientsAndMeasures {
                    Divider()
                    IngredientsAndMeasuresView(ingredientsAndMeasures: ingredientsAndMeasures)
                } else {
                    Text("Missing Ingredients and Measures")
                }
            }.padding(12)
        }
        .onAppear(perform: {
            viewModel.fetchAndApplyMealDetails()
        })
        .alert("Failed to retrieve meal", isPresented: $viewModel.shouldRetry) {
            Button {
                viewModel.retry()
            } label: {
                Text("Retry")
            }
        }
    }
}

#Preview {
    MealDetailView(viewModel: MealDetailViewModel(idMeal: "52909"))
}
