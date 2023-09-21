//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var repoSearchBar: UISearchBar!
    
    var repoList: [[String: Any]]=[]
    var task: URLSessionTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        repoSearchBar.text = "GitHubのリポジトリを検索できるよー"
        repoSearchBar.delegate = self
        self.hideKeyboardWhenTappedAround()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RepoInfoCellIdentifier")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        //リポジトリー検索
        if let searchText = searchBar.text, searchText.isNotEmpty {
            if let url = URL(string: "https://api.github.com/search/repositories?q=\(searchText)") {
                task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                    
                    guard let self = self else { return }
                    guard let data = data, error == nil else { return }
                    
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                        if let items = jsonObject?["items"] as? [[String: Any]] {
                            self.repoList = items
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    } catch {
                        print("JSONのパースエラー: \(error)")
                    }
                }
                // これ呼ばなきゃリストが更新されません
                task?.resume()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailInfoView" {
            guard let detailView = segue.destination as? DetailInfoViewController, let repoInfo = sender as? [String: Any] else { return }
            detailView.repoInfo = repoInfo
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoInfoCellIdentifier", for: indexPath)
        let repoInfo = repoList[indexPath.row]
        cell.textLabel?.setText(repoInfo["full_name"])
        cell.detailTextLabel?.setText(repoInfo["language"])
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        if indexPath.row >= repoList.count { return }
        performSegue(withIdentifier: "DetailInfoView", sender: repoList[indexPath.row])
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.dismissKeyboard()
    }
    
}
