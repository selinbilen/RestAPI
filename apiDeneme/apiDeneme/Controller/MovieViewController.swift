//
//  ViewController.swift
//  apiDeneme
//
//  Created by selin eylül bilen on 11/30/21.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    //var refresh: UIRefreshControl = UIRefreshControl()
    private var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieData()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        /*if #available(iOS 10.0, *){
            tableView.refreshControl = refresh
        }else{
            tableView.addSubview(refresh)
        }*/
        
    }
    
    @objc private func refreshData(){
        print("vnjksf")
        loadMovieData()
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func loadMovieData(){
        viewModel.fetchData{ [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
            
        }
    }
}

extension MovieViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCells(movie)
        return cell
    }
}
