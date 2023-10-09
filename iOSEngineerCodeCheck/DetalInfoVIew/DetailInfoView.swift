//
//  DetailInfoViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol DetailInfoView: AnyObject {
    
    func showAvatarImage(image: UIImage)
}

class DetailInfoViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var avatarImageView: CircularImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var openIssuesLabel: UILabel!
    @IBOutlet weak var openWebViewButton: UIButton!
    
    var presenter: DetailInfoPresenter?
    var repoDetailInfo: RepoTableCellContent!
    
    func setPresenter(presenter: DetailInfoPresenter) {
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ info: RepoTableCellContent) {
        
        super.init(nibName: nil, bundle: nil)
        self.repoDetailInfo = info
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailInfoUserRouter.create(view: self)
        presenter?.viewDidLoad(repoDetailInfo)
        setViewInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func setViewInfo() {
        
        languageLabel.text = "Written in \(repoDetailInfo.language ?? "")"
        starsLabel.text = "\(repoDetailInfo.stars) stars"
        watchersLabel.text = "\(repoDetailInfo.watchers) watchers"
        forksLabel.text = "\(repoDetailInfo.forks) forks"
        openIssuesLabel.text = "\(repoDetailInfo.openIssues) open issues"
        titleLabel.text = repoDetailInfo.name
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        avatarImageView.image = repoDetailInfo.image
        backgroundView.backgroundColor = Utils.UIColorFromRGB(0x91DBF2)
        openWebViewButton.applyGradient(colors: [Utils.UIColorFromRGB(0x2B95CE).cgColor,Utils.UIColorFromRGB(0x2ECAD5).cgColor])
    }
    
    @IBAction func openWebViewButtonAction(_ sender: Any) {
        presenter?.showWebView(repoDetailInfo)
    }
}

extension DetailInfoViewController: DetailInfoView {
    
    func showAvatarImage(image: UIImage) {
        DispatchQueue.main.async {
            self.avatarImageView.image = image
        }
    }
    
}
