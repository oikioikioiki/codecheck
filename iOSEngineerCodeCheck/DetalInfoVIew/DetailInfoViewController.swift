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
    
    var viewModel: DetailInfoViewModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewInfo()
    }
    
    func setViewInfo() {
        languageLabel.text = viewModel.language
        starsLabel.text = viewModel.stars
        watchersLabel.text = viewModel.watchers
        forksLabel.text = viewModel.forks
        openIssuesLabel.text = viewModel.openIssues
        titleLabel.text = viewModel.fullName
        getAvatarImage()
    }
    
    func getAvatarImage() {
        // 画像をダウンロードする
        viewModel.getAvatarImage(imageURL: viewModel.avatarURL, completeHandler: { [weak self] success in
            guard let self = self else { return }
            if success {
                DispatchQueue.main.async {
                    self.avatarImageView.image = self.viewModel.avatarImage
                }
            }
        })
        
    }
}
