//
//  IngredientsAndMeasuresView.swift
//  FetchRecipes
//
//  Created by Yukichi Kawada on 8/20/24.
//

import SwiftUI

struct IngredientsAndMeasuresView: View {
    var ingredientsAndMeasures: [IngredientsAndMeasures] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients / Measures")
                .font(.title2)
                .padding(.bottom, 24)
            ForEach(ingredientsAndMeasures) { ingredient in
                HStack {
                    Text(ingredient.ingredient)
                    Text(ingredient.measure)
                }
            }
        }
    }
}

#Preview {
    IngredientsAndMeasuresView(ingredientsAndMeasures: [IngredientsAndMeasures(id: "CB6B170A-5D00-4504-B31B-7927F3D0252D", ingredient: "Cashew Nuts", measure: "250g"), IngredientsAndMeasures(id: "CFE23FE4-15D6-4FE3-B4B8-8F7309D811BA", ingredient: "Icing Sugar", measure: "100g "), IngredientsAndMeasures(id: "047DFF2E-52DC-4650-9F01-14F2979A7499", ingredient: "Egg Yolks", measure: "2")])
}
