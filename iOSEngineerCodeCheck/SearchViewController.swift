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
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        repoSearchBar.text = "GitHubのリポジトリを検索できるよー"
        repoSearchBar.delegate = self
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
        
        if let keyWord = searchBar.text, keyWord.isNotEmpty {
            let url = URL(string: "https://api.github.com/search/repositories?q=\(keyWord)")!
            task = URLSession.shared.dataTask(with: url) { [weak self] (data, res, err) in
                
                guard let self = self else { return }
                if let jasonData = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    if let items = jasonData["items"] as? [[String: Any]] {
                    self.repoList = items
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        // これ呼ばなきゃリストが更新されません
        task?.resume()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailInfoView" {
            let detailView = segue.destination as! DetailInfoViewController
            detailView.searchViewController = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let repoInfo = repoList[indexPath.row]
        cell.textLabel?.text = repoInfo["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repoInfo["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        index = indexPath.row
        performSegue(withIdentifier: "DetailInfoView", sender: self)
        
    }
    
}
