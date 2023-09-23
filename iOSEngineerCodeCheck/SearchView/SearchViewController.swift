//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {

    @IBOutlet weak var repoSearchBar: UISearchBar!
    var viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        repoSearchBar.text = "GitHubのリポジトリを検索できるよー"
        repoSearchBar.delegate = self
        self.hideKeyboardWhenTappedAround()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RepoInfoCellIdentifier")
    }
    
    //画面遷移
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailInfoView" {
            guard let detailView = segue.destination as? DetailInfoViewController, let repoInfo = sender as? RepoResponse else { return }
            var viewModel = DetailInfoViewModel(repoInfo)
            detailView.viewModel = viewModel
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRepositories()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoInfoCellIdentifier", for: indexPath)
        let repoInfo = viewModel.repoInfo(indexPath.row)
        cell.textLabel?.setText(repoInfo.fullName)
        cell.detailTextLabel?.setText(repoInfo.language)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        if indexPath.row >= viewModel.numberOfRepositories() { return }
        performSegue(withIdentifier: "DetailInfoView", sender: viewModel.repoInfo(indexPath.row))
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.dismissKeyboard()
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        //リポジトリー検索
        if let searchText = searchBar.text, searchText.isNotEmpty {
            
            viewModel.searchRepositories(searchText, completeHandler: { [weak self] success in
                guard let self = self else { return }
                if success {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }
    }
}
