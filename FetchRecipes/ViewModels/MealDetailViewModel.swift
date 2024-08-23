//
//  MealDetailViewModel.swift
//  FetchRecipes
//
//  Created by Yukichi Kawada on 8/19/24.
//

import Foundation

final class MealDetailViewModel: ObservableObject {
    private let idMeal: String
    @Published var mealDetails: Meal?
    @Published var shouldRetry: Bool = false
    
    init(idMeal: String) {
        self.idMeal = idMeal
    }
    
    func fetchMealDetails() async throws -> Meal {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)") else {
            throw MealDetailError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let container = try JSONDecoder().decode(Meals.self, from: data)
            guard let meal = container.meals.first else {
                throw MealDetailError.missingMeal
            }
            return meal
        } catch {
            throw MealDetailError.cannotDecode
        }
    }
    
    func apply(mealDetails: Meal) {
        DispatchQueue.main.async {
            self.mealDetails = mealDetails
        }
    }
    
    func applyErrorView() {
        DispatchQueue.main.async {
            self.shouldRetry = true
        }
    }
    
    func retry() {
        shouldRetry = false
        fetchAndApplyMealDetails()
    }
    
    func fetchAndApplyMealDetails() {
        Task {
            do {
                let data = try await fetchMealDetails()
                apply(mealDetails: data)
            } catch {
                applyErrorView()
            }
        }
    }
}

extension MealDetailViewModel {
    enum MealDetailError: LocalizedError {
        case invalidURL
        case cannotDecode
        case missingMeal
    }
}
