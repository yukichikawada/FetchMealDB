//
//  MealListViewModel.swift
//  FetchRecipes
//
//  Created by Yukichi Kawada on 8/19/24.
//

import Foundation

final class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    
    func fetchList() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print(MealListError.badUrl)
            return
        }
        Task { @MainActor in
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let container = try decoder.decode(Meals.self, from: data)
                self.meals = container.meals
            } catch {
                throw MealListError.custom(error: error)
            }
        }
    }
    
    func clearMeals() {
        DispatchQueue.main.async {
            self.meals = []
        }
    }
}

extension MealListViewModel {
    enum MealListError: LocalizedError {
        case badUrl
        case custom(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .badUrl:
                return "Failed to construct URL"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }

}
