//
//  TVShowDetailsVC.swift
//  starzPlayTest
//
//  Created by Hamza Sheikh on 19/03/2024.
//

import UIKit
import AVKit

class TVShowDetailsVC: UIViewController {

    @IBOutlet weak var tvShowImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    
    var showID: Int = 0
    var tvShowDetailDto: TVShowDetailsDto?
    var seasonDetailDto: SeasonDetailsDto?
    
    let playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self

        
        let services = TVShowServices()
        services.fetchTVShowDetails(showId: showID) { result in
            switch result {
            case .success(let tvShowDetailDto):
                self.tvShowDetailDto = tvShowDetailDto
                self.setupContent()
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
    
    func setupContent() {
        DispatchQueue.main.async {
            guard let tvShowDetailDto = self.tvShowDetailDto else { return }
            let url = URL(string: tvShowDetailDto.tvShowImgUrl)
            self.tvShowImageView.sd_setImage(with: url)
            self.lblTitle.text = tvShowDetailDto.name
            self.lblDetails.text = tvShowDetailDto.overview
            
            var year: Int?
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            // Convert the string to a Date object
            if let date = dateFormatter.date(from: tvShowDetailDto.firstAirDate ?? "") {
                // Extract the year component
                let calendar = Calendar.current
                year = calendar.component(.year, from: date)
                
            } else {
                print("Invalid date format")
            }
            
            if let year {
                self.lblInfo.text = "\(year) | \(tvShowDetailDto.numberOfSeasons ?? 0) Seasons"
            }
            else {
                self.lblInfo.text = "\(tvShowDetailDto.numberOfSeasons ?? 0) Seasons"
            }
            
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        if let url = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4") {
            let player = AVPlayer(url: url)
            playerViewController.player = player
            present(playerViewController, animated: true) {
                self.playerViewController.player?.play()
            }
        } else {
            print("Invalid media file URL")
        }
    }
}

extension TVShowDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShowDetailDto?.seasons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seasonCollCell", for: indexPath)
        if let label = cell.viewWithTag(1200) as? UILabel {
            label.text =  "Season \(tvShowDetailDto?.seasons?[indexPath.row].seasonNumber ?? 0)"
        }
        
//        if let view = cell.viewWithTag(1210) {
//            view.isHidden = true
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tvShowService = TVShowServices()
        tvShowService.fetchSeasonDetails(showId: showID, seasonId: tvShowDetailDto?.seasons?[indexPath.row].seasonNumber ?? 0) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.seasonDetailDto = success
                    self.tableView.reloadData()
                    self.updateTableViewHeight()
                }
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
    
    
}

extension TVShowDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasonDetailDto?.episodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeTableCell", for: indexPath)
        if let view = cell.viewWithTag(1220) as? UIImageView {
            
            let url = URL(string: seasonDetailDto?.episodes?[indexPath.row].tvShowImgUrl ?? "")
            view.sd_setImage(with: url)
        }

        if let view = cell.viewWithTag(1230) as? UILabel {
            view.text = seasonDetailDto?.episodes?[indexPath.row].name
        }

        return cell
    }
 
    func updateTableViewHeight() {
        tableView.layoutIfNeeded()
        let contentHeight = tableView.contentSize.height
        tableViewHeightConstraint.constant = contentHeight
    }
}
