//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol SearchView: AnyObject {
    
    func updateRepoList(list: [RepoTableCellContent])
}

class SearchViewController: UIViewController {

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
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        if indexPath.row >= repoList.count { return }
        presenter?.didTappedRepoTableCell(info: repoList[indexPath.row])
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.dismissKeyboard()
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
    
    func updateRepoList(list: [RepoTableCellContent]) {
        DispatchQueue.main.async {
            self.repoList = list
            self.repoTableView.reloadData()
        }
    }
    
}
