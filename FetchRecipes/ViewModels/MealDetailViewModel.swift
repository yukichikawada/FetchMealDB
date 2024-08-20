//
//  MealDetailViewModel.swift
//  FetchRecipes
//
//  Created by Yukichi Kawada on 8/19/24.
//

import Foundation

final class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: Meal?
    
    init(idMeal: String) {
        Task {
            try await fetchMealDetails(idMeal: idMeal)
        }
    }
    @MainActor
    func fetchMealDetails(idMeal: String) async throws {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)") else {
            return
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let container = try decoder.decode(Meals.self, from: data)
        self.mealDetail = container.meals.first
    }
}
