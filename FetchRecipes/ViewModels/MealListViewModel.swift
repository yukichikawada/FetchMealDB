//
//  MealListViewModel.swift
//  FetchRecipes
//
//  Created by Yukichi Kawada on 8/19/24.
//

import Foundation

final class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    
    init() {
        Task {
            try await fetchList()
        }
    }
    
    @MainActor
    func fetchList() async throws {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            throw MealListError.badUrl
        }
        
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
