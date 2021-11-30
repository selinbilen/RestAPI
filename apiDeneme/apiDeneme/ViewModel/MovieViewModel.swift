//
//  MovieViewModel.swift
//  apiDeneme
//
//  Created by selin eylül bilen on 11/30/21.
//

import Foundation

class MovieViewModel {
    private var apiService = ApiServer()
    private var popularMovies = [Movie]()
    
    func fetchData(completion: @escaping () -> ()){
        apiService.getData { [weak self] (result) in
            switch result{
            case .success(let listOf):
                self?.popularMovies = listOf.movies
                completion()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    func numberOfRowsInSection(section: Int) -> Int{
        if popularMovies.count != 0{
            return popularMovies.count
        }
        return 0
    }
    func cellForRowAt(indexPath: IndexPath) -> Movie{
        return popularMovies[indexPath.row]
    }
}
