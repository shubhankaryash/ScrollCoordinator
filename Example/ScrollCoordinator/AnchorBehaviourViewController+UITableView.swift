//
//  AnchorBehaviourViewController+UITableView.swift
//  ScrollCoordinator_Example
//

import UIKit
import ScrollCoordinator

extension AnchorBehaviourViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: anchorCellIdentifier)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: anchorNestedScrollIdentifier)
        tableView.bounces = false
        view.addSubview(tableView)
    }
    
    func tableViewDidLoad() {
        if isAnchorBehaviourEnabled {
            tableView.isScrollEnabled = false
            let anchorHeight: CGFloat = 60
            addBehaviour(view: tableView, behaviour: AnchorBehaviour(scrollView: tableView, anchorHeight: anchorHeight, shouldPreventOriginalScroll: true))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 1:
            return UIScreen.main.bounds.height//400
        default:
            return 140
        }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 1:
            let nestedScrollCell = tableView.dequeueReusableCell(withIdentifier: anchorNestedScrollIdentifier, for: indexPath)
            let nestedScrollView = NestedScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), manager: self)
            nestedScrollView.setupTableView()
            nestedScrollCell.addSubview(nestedScrollView)
            return nestedScrollCell
        default:
            let anchorPointCell = tableView.dequeueReusableCell(withIdentifier: anchorCellIdentifier, for: indexPath)
            let teamImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
            teamImageView.image = UIImage(named: "premierLeagueTeams")
            
            let headingView = UIImageView(frame: CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width, height: 80))
            headingView.image = UIImage(named: "premierLeagueTitle")
            anchorPointCell.addSubview(teamImageView)
            anchorPointCell.addSubview(headingView)
            return anchorPointCell
        }
    }
}
