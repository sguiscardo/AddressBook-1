//
//  PeopleTableViewController.swift
//  AddressBook
//
//  Created by Trevor Adcock on 10/12/21.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var favoritesOnlyToggle: UISwitch!
    
    let personController = GroupController.shared
    var group: Group?
    
    private var filteredPeople: [Person] {
        if favoritesOnlyToggle.isOn {
            return group?.people.filter { $0.isFavorite } ?? []
        } else {
            return group?.people ?? []
        }
    }

    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupNameTextField.text = group?.name
        favoritesOnlyToggle.isOn = false
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let group = group,
            let newName = groupNameTextField.text else { return }
        personController.update(group: group, name: newName)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPeople.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as?
                PersonTableViewCell else { return UITableViewCell() }
        let person = filteredPeople[indexPath.row]
        cell.person = person
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let group = group else { return }
            let person = filteredPeople[indexPath.row]
            PersonController.delete(person: person, in: group)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toPersonDetail",
              let personDetailViewController = segue.destination as? PersonDetailViewController,
              let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
        let person = filteredPeople[selectedRow]
        personDetailViewController.person = person
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        guard let group = group else { return }
        let oldPersonCount = filteredPeople.count
        PersonController.createPerson(group: group)
        let newPersonCount = filteredPeople.count
        guard newPersonCount > oldPersonCount else { return }
        let newRow = filteredPeople.count - 1
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func favoritesOnlySwitchToggled(_ sender: UISwitch) {
        tableView.reloadData()
    }
}

// MARK: PersonTableViewCellDelegate Conformance
//extension PeopleTableViewController: PersonTableViewCellDelegate {
//
//    func toggleFavoriteButtonWasTapped(cell: PersonTableViewCell) {
//        guard let person = cell.person else { return }
//        PersonController.toggleFavorite(person: person)
//        tableView.reloadData()
//    }


