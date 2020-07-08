//
//  ViewController.swift
//  Investigation
//
//  Created by Ivana Lubar on 07/07/2020.
//  Copyright © 2020 Ivana Lubar. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet private weak var loadButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var items: [String] = []
    var sessionManager: Session?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        setupSessionManager()
        setupItems()
    }

    @IBAction func buttonClick() {
        getMoreRequests()
        tableView.reloadData()
    }

    func setupSessionManager() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 150
        configuration.httpShouldUsePipelining = true
        configuration.httpMaximumConnectionsPerHost = 10
        sessionManager = Session(configuration: configuration, startRequestsImmediately: true)
    }

    func setupItems() {
        for index in 0...500 {
            self.items.append("Request \(index) not started")
        }
        tableView.reloadData()
    }

    func fetchFilms(index: Int) {
        self.items[index] = "Request \(index) started"
        sessionManager?.request("https://swapi.dev/api/films")
          .validate()
          .responseDecodable(of: Films.self) { (response) in
            guard let _ = response.value else { return }
            self.items[index] = "Request \(index) completed"
            self.tableView.reloadData()
          }
    }

    func getMoreRequests() {
        for index in 0...500 {
            fetchFilms(index: index)
        }
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FilmTableViewCell.self), for: indexPath) as! FilmTableViewCell

        cell.configure(with: items[indexPath.row] as! String)
        return cell
    }
}

extension ViewController: UITableViewDelegate{

}
