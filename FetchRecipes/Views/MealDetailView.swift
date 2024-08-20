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
                Text(viewModel.mealDetail?.strMeal ?? "")
                    .font(.title)
                
                // Section
                Text("Instructions")
                    .font(.title2)
                    .padding(.bottom, 24)
                Text(viewModel.mealDetail?.strInstructions ?? "")
                
                // Section
                Divider()
                Text("Ingredients / Measures")
                    .font(.title2)
                    .padding(.bottom, 24)
                ForEach(viewModel.mealDetail?.ingredientsAndMeasures ?? []) { ingredient in
                    HStack {
                        Text(ingredient.ingredient)
                        Text(ingredient.measure)
                    }
                }
            }.padding(12)
        }
    }
}

#Preview {
    MealDetailView(viewModel: MealDetailViewModel(idMeal: "52909"))
}
