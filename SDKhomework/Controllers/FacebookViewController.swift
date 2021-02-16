//
//  FacebookViewController.swift
//  SDKhomework
//
//  Created by Дарья on 12.02.2021.
//

import UIKit

class FacebookViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fbCell", for: indexPath) as! FbCell
        cell.friendsLabel.text = "\(indexPath.row)"
        return cell
    }
    
}
