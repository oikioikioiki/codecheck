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
    
    var repoInfo: [String: Any]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        languageLabel.setText("Written in ",with: repoInfo["language"])
        starsLabel.setText(repoInfo["stargazers_count"], with: " stars")
        watchersLabel.setText(repoInfo["watchers_count"], with: " watchers")
        forksLabel.setText(repoInfo["forks_count"], with: " forks")
        openIssuesLabel.setText(repoInfo["open_issues_count"], with: " open issues")
        titleLabel.setText(repoInfo["full_name"])
        getAvatarImage()
    }
    
    func getAvatarImage() {
        
        // 画像をダウンロードする
        guard let owner = repoInfo["owner"] as? [String: Any], let avatarImageURL = owner["avatar_url"] as? String else { return }
        if let url = URL(string: avatarImageURL) {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                
                guard let self = self else { return }
                guard let data = data, error == nil else { return }
                
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.avatarImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
