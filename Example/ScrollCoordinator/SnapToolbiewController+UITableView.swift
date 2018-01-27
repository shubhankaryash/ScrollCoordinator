//
//  SnapToolbarViewController+UITableView.swift
//  ScrollCoordinator_Example
//

import UIKit

extension SnapToolbarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = "row \((indexPath as NSIndexPath).row)"
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
}
