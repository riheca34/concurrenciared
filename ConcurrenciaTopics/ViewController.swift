//
//  ViewController.swift
//  ConcurrenciaTopics
//
//  Created by Ricardo Hernandez on 23/1/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TableViewLatestTopic: UITableView!
    var latestPosts: [LatestPosts]
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        
        fechPosts { result in
            switch result {
                case .success(let posts):
            }
        }
        // Do any additional setup after loading the view.
    }

    private func fechPosts(completion: @escaping (Result<Poster, Error>) -> Void){
        guard let url: URL = URL(string: "https://mdiscourse.keepcoding.io/latest.json") else { return }
        
        let session: URLSession = URLSession(configuration: .default)
        let fechtPostsRequest: URLRequest = .init(url: url)
        
        let dataTask = session.dataTask(with: fechtPostsRequest) { (data, response, error) in
            if let error =  error{
            DispatchQueue.main.async {
                completion(.failure(error))
                }
                 return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                DispatchQueue.main.async {
                    let httpError: NSError = NSError(domain: "c", code: httpResponse.statusCode, userInfo: nil)
                    
                    completion(.failure(httpError))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    let dataError: NSError = NSError(domain: "fechtPosts", code: 0, userInfo: nil)
                    completion(.failure(dataError))
                }
                return
            }
            do {
                let posts = try JSONDecoder().decode(Poster.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(posts))
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                
            }
        }
    }

}




