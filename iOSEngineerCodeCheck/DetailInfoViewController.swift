//
//  DetailInfoViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailInfoViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var openIssuesLabel: UILabel!
    
    var searchViewController: SearchViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repo = searchViewController.repoList[searchViewController.index]
        
        languageLabel.text = "Written in \(repo["language"] as? String ?? "")"
        starsLabel.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repo["watchers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        openIssuesLabel.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getAvatarImage()
        
    }
    
    func getAvatarImage() {
        let repo = searchViewController.repoList[searchViewController.index]
        titleLabel.text = repo["full_name"] as? String
        
        if let owner = repo["owner"] as? [String: Any], let avatarImageURL = owner["avatar_url"] as? String {
            // 画像をダウンロードする
            URLSession.shared.dataTask(with: URL(string: avatarImageURL)!) { [weak self] (data, res, err) in
                guard let self = self else { return }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.avatarImageView.image = image
                    }
                }
            }.resume()
        }
    }
    
}
