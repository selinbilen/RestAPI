//
//  ApiServer.swift
//  apiDeneme
//
//  Created by selin eylül bilen on 11/30/21.
//

import Foundation

class ApiServer {
    private var dataTask: URLSessionDataTask?
    
    func getData(completion: @escaping (Result<MoviesData, Error>) -> Void){
        
        let urlPath = "https://api.themoviedb.org/3/movie/popular?api_key=78d837f6fe41445be32f3da309c853fd"
        
        guard let url = URL(string: urlPath) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else{
                print("Empty Response")
                return
            }
            print("Response Status Code: \(response.statusCode)")
            
            guard let data = data else{
                print("Empty Data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                    
                }
            }catch let error{
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
