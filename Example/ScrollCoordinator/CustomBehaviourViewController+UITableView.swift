//
//  CustomBehaviourViewController+UITableView.swift
//  ScrollCoordinator_Example
//

import UIKit

extension CustomBehaviourViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: customBehaviourCellIdentifier)
        tableView.bounces = false
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        headerView.setup()
        addBehaviour(view: headerView, behaviour: PercentageBehaviour(scrollView: tableView, headerView: headerView))
        return headerView
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customBehaviourCellIdentifier, for: indexPath)
        cell.textLabel?.text = "Item \((indexPath as NSIndexPath).row)"
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
}

class HeaderView: UIView {
    let percentageView = UIView()
    
    var maxWidth: CGFloat = 0
    
    func setup() {
        maxWidth = UIScreen.main.bounds.width
        self.frame = CGRect(x: 0, y: 0, width: maxWidth, height: 50)
        self.backgroundColor = UIColor.gray
        percentageView.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        percentageView.backgroundColor = UIColor.green
        addSubview(percentageView)
        
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: maxWidth, height: 50))
        let labelText = "Percentage Scrolled"
        let textAttributes = [NSAttributedStringKey.font: UIFont(name: "Palatino-Roman", size: 20), NSAttributedStringKey.foregroundColor: UIColor.black]
        headerLabel.attributedText = NSAttributedString(string: labelText, attributes: textAttributes)
        addSubview(headerLabel)
    }
}
