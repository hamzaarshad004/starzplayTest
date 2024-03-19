//
//  ViewController.swift
//  starzPlayTest
//
//  Created by Hamza Sheikh on 18/03/2024.
//

import UIKit
import SDWebImage

class TVShowsVC: UIViewController {

    @IBOutlet weak var tvShowTableView: UITableView!
    
    var tvShows: [TVShow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        tvShowTableView.dataSource = self
        tvShowTableView.delegate = self
        
        let tvShowService = TVShowServices()
        tvShowService.fetchPopularTVShows { result in
            switch result {
            case .success(let tvShowListResponse):
                // Handle successful response
                DispatchQueue.main.async {
                    self.tvShows = tvShowListResponse.results
                    self.tvShowTableView.reloadData()
                }
            case .failure(let error):
                // Handle error
                print("Error fetching TV shows:", error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

extension TVShowsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVShowsTableViewCell", for: indexPath) as! TVShowsTableViewCell
        cell.lblShowNmae.text = tvShows[indexPath.row].name
        cell.lblShowOverview.text = tvShows[indexPath.row].overview
        let imgUrl = URL(string: tvShows[indexPath.row].tvShowImgUrl)
        cell.tvShowImage.sd_setImage(with: imgUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tvShow = tvShows[indexPath.row]
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TVShowDetailsVC") as! TVShowDetailsVC
        vc.showID = tvShow.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
