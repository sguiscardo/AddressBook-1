//
//  RecipeTableViewController.swift
//  Recipe1
//
//  Created by DevMountain on 10/12/21.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var favoritesOnlyToggle: UISwitch!
    
    let personController = PersonController.shared
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as? PersonTableViewCell else { return UITableViewCell() }
        let person = filteredPeople[indexPath.row]
        cell.person = person
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let group = group else { return }
            let person = filteredPeople[indexPath.row]
            personController.delete(person: person, in: group)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toPersonDetail",
              let personDetailViewController = segue.destination as? PersonDetailViewController,
              let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
        let recipe = filteredPeople[selectedRow]
        personDetailViewController.person = recipe
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        guard let group = group else { return }
        let oldRecipeCount = filteredPeople.count
        personController.createPerson(group: group)
        let newRecipeCount = filteredPeople.count
        guard newRecipeCount > oldRecipeCount else { return }
        let newRow = filteredPeople.count - 1
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func favoritesOnlySwitchToggled(_ sender: UISwitch) {
        tableView.reloadData()
    }
}

// MARK: RecipeTableViewCellDelegate Conformance
extension PeopleTableViewController: PersonTableViewCellDelegate {
    
    func toggleFavoriteButtonWasTapped(cell: PersonTableViewCell) {
        guard let recipe = cell.person else { return }
        personController.toggleFavorite(person: recipe)
        tableView.reloadData()
    }
}
