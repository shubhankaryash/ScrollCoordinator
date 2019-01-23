//
//  NestedScrollView.swift
//  ScrollCoordinator_Example
//

import UIKit
import ScrollCoordinator

class NestedScrollView: UIView, UITableViewDataSource, UITableViewDelegate {
    let nestedScrollCellIdentifier = "nestedScrollCell"
    var tableView: UITableView!
    
    let teams = ["Manchester City", "Manchester United" ,"Chelsea", "Liverpool", "Tottenham Hotspur", "Arsenal", "Leicester City", "Burnley", "Everton", "Watford", "West Ham United", "Bournemouth", "Crystal Palace", "Huddersfield Town", "Newcastle United", "Brighton&Hove Albion", "Stoke City", "Southampton", "West Bromwich Albion", "Swansea City" ]

    
    var manager: ScrollCoordinatorManager?
    
    convenience init(frame: CGRect, manager: ScrollCoordinatorManager) {
        self.init(frame: frame)
        self.manager = manager
    }
    func setupTableView() {
        tableView = UITableView(frame: self.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: nestedScrollCellIdentifier)
        tableView.bounces = false
        self.addSubview(tableView)
        
        registerScrollViewToCoordinator()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: nestedScrollCellIdentifier, for: indexPath)
        cell.textLabel?.text = "\(teams[indexPath.row])"
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func registerScrollViewToCoordinator() {
        manager?.registerScrollViewToCoordinator(scrollView: tableView)
    }
}
