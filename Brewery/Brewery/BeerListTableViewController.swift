//
//  BeerListTableViewController.swift
//  Brewery
//
//  Created by 장선영 on 2022/01/20.
//

import UIKit

class BeerListTableViewController: UITableViewController {
    
    var beerList = [Beer]()
    var dataTasks = [URLSessionTask]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getBeerData()
        
        title = "패캠 브루어리"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(BeerListTableViewCell.self, forCellReuseIdentifier: "BeerListTableViewCell")
        tableView.rowHeight = 150
        tableView.prefetchDataSource = self
        
        fetchBeer(of: currentPage)
    }
    
    // getData
    func getBeerData() {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers") else { return }
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            
            let decoder = JSONDecoder()
            guard let beerData = try? decoder.decode([Beer].self, from: data) else { return }
            self?.beerList = beerData
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.resume()
    }
}

// tableView DataSource,Delegate
extension BeerListTableViewController: UITableViewDataSourcePrefetching {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListTableViewCell", for: indexPath) as? BeerListTableViewCell else { return UITableViewCell() }
        
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailVC = BeerDetailTableViewController()
        
        detailVC.beer = selectedBeer
//        navigationController?.pushViewController(detailVC, animated: true)
        self.show(detailVC, sender: nil)
//        present(detailVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else { return }
        
        indexPaths.forEach {
            if ($0.row + 1)/25 + 1 == currentPage {
                self.fetchBeer(of: currentPage)
            }
        }
    }
    
}


//Data Fetching
private extension BeerListTableViewController {
    func fetchBeer(of page: Int) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
              dataTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let self = self,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else { return
                print("ERROR: URLSession data task \(error?.localizedDescription ?? "")")
            }

            switch response.statusCode {
            case 200...299:
                self.beerList += beers
                self.currentPage += 1

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case 400...499:
                print("""
                    ERROR: Client ERROR \(response.statusCode)
                    Response: \(response)
                    """)
            case 500...599:
                print("""
                    ERROR: Server ERROR \(response.statusCode)
                    Response: \(response)
                    """)
            default:
                print("""
                    ERROR: \(response.statusCode)
                    Response: \(response)
                    """)

            }
        }
        dataTask.resume()
        dataTasks.append(dataTask)
    }
}
