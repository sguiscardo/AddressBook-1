//
//  GroupsTableViewController.swift
//  AddressBook
//
//  Created by Trevor Adcock on 10/12/21.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    let personController = GroupController.shared
    
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personController.groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressBookGroupCell", for: indexPath)
        let group = personController.groups[indexPath.row]
        cell.textLabel?.text = group.name
        cell.detailTextLabel?.text = "\(group.people.count) People"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let group = personController.groups[indexPath.row]
            personController.delete(group: group)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toPeopleTableViewController",
              let peopleTableViewController = segue.destination as? PeopleTableViewController,
              let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
        let group = personController.groups[selectedRow]
        peopleTableViewController.group = group
    }
    
    // MARK: - IBActions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        GroupController.shared.createPersonInGroups()
        let newRow = GroupController.shared.groups.count - 1
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
}
