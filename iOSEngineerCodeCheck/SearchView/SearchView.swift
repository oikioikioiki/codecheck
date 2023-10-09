//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import ProgressHUD

protocol SearchView: AnyObject {
    
    func showLoadingView()
    func closeLoading()
    func updateRepoList(list: [RepoTableCellContent], moreInfo: Bool)
    func updateImageData(image: UIImage, at: Int)
}

class SearchViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var repoSearchBar: UISearchBar!
    
    var repoList: [RepoTableCellContent] = []
    var presenter: SearchPresenter?
    
    func setPresenter(presenter: SearchPresenter) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchUserRouter.create(view: self)
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setUI(){
        
        repoSearchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        repoSearchBar.delegate = self
        
        repoTableView.delegate = self
        repoTableView.dataSource = self
        
        let repoTableViewCell = UINib(nibName: "RepoTableViewCell", bundle: nil)
        repoTableView.register(repoTableViewCell, forCellReuseIdentifier: "RepoInfoCellIdentifier")
        
        self.hideKeyboardWhenTappedAround()
        
        backgroundView.applyGradient(colors: [Utils.UIColorFromRGB(0x2B95CE).cgColor,Utils.UIColorFromRGB(0x2ECAD5).cgColor], roundedCorners: [])
        repoSearchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        repoTableView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        
    }
    
    func showLoadingView() {
        DispatchQueue.main.async {
            ProgressHUD.animationType = .circleStrokeSpin
            self.view.isUserInteractionEnabled = false
            ProgressHUD.show()
        }
    }
    
    func closeLoading() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            ProgressHUD.dismiss()
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoInfoCellIdentifier", for: indexPath) as! RepoTableViewCell
        cell.set(context: repoList[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        if indexPath.row >= repoList.count { return }
        presenter?.didTappedRepoTableCell(info: repoList[indexPath.row])
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.dismissKeyboard()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let willShowElement = repoList.count - 4
        if indexPath.row >= willShowElement{
            presenter?.updateMoreRepoInfo(lastCount: repoList.count)
        }
    }

}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        //リポジトリー検索
        presenter?.searchRepositories(text: searchBar.text)
    }
}

extension SearchViewController: SearchView {
    
    func updateRepoList(list: [RepoTableCellContent], moreInfo: Bool) {
        
        DispatchQueue.main.async {
            if moreInfo {
                self.repoList.append(contentsOf: list)
            } else {
                self.repoList = list
            }
            self.repoTableView.reloadData()
            self.closeLoading()
        }
        
    }
    
    func updateImageData(image: UIImage, at: Int) {
        DispatchQueue.main.async {
            self.repoList[at].updateData(image: image)
            self.repoTableView.reloadRows(at: [IndexPath(item: at, section: 0)], with: .automatic)
        }
    }
    
}
