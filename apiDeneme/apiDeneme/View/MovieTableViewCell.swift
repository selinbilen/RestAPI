//
//  MovieTableViewCell.swift
//  apiDeneme
//
//  Created by selin eylül bilen on 11/30/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var MoviePoster: UIImageView!
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    private var urlString: String = ""
    /*
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let heartButton = UIButton(type: .system)
        
        heartButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
        heartButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        accessoryView = heartButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
    func setCells(_ movie: Movie){
        updateUI(title: movie.title, releaseDate: movie.year, overview: movie.overview, poster: movie.posterImage)
    }
    
    private func updateUI(title: String?, releaseDate: String?, overview: String?, poster: String?){
        self.MovieTitle.text = title
        self.movieYear.text = converDataFormater(releaseDate)
        print(converDataFormater(releaseDate))
        self.movieOverview.text = overview
        
        guard let posterString = poster else{return}
        urlString = "http://image.tmdb.org/t/p/w300" + posterString
        guard let posterImageURL = URL(string: urlString) else{
            self.MoviePoster.image = UIImage(named: "noImageFound")
            return
        }
        
        self.MoviePoster.image = nil
        getImage(url: posterImageURL)
    }
    
    private func getImage(url: URL){
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let error = error{
                print("error: \(error.localizedDescription)")
                return
            }
            guard let data = data else{
                print("empty data")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data){
                    self.MoviePoster.image = image
                }
            }
        }.resume()
    }
    
    func converDataFormater(_ date: String?) -> String{
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date{
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
}
