//
//  GroupController.swift
//  AddressBook
//
//  Created by Trevor Adcock on 10/12/21.
//

import Foundation

class GroupController {
    
    // MARK: - Properties
    static let shared = GroupController()
    
    private(set) var groups: [Group] = []
    
    // MARK: - Initializers
    init() {
        loadContactsFromDisk()
    }
    
    // MARK: - Groups
    func createContactGroup(name: String = "Untitled Group", people: [Person] = []) {
        let group = Group(name: name, people: people)
        groups.append(group)
        saveContactsToDisk()
    }
    
    func update(group: Group, name: String) {
        group.name = name
        saveContactsToDisk()
    }
    
    func delete(group: Group) {
        guard let index = groups.firstIndex(of: group) else { return }
        groups.remove(at: index)
        saveContactsToDisk()
    }
    
    // MARK: - Persistance
    func saveContactsToDisk() {
        // 1. Get the address to save the file to
        guard let url = fileURL else { return }
        do {
            // 2. Convert the swift struct or class into raw data
            let data = try JSONEncoder().encode(groups)
            // 3. Save the data to the address from step 1
            try data.write(to: url)
        } catch let error {
            print(error)
        }
    }
    
    func loadContactsFromDisk() {
        // 1. Get the address your data is saved at
        guard let url = fileURL else { return }
        do {
            // 2. Load the data from the address
            let data = try Data(contentsOf: url)
            // 3. Decode that data into our Swift model object
            let categories = try JSONDecoder().decode([Group].self, from: data)
            self.groups = categories
        } catch let error {
            print(error)
        }
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = documentsDirectory.appendingPathComponent("addressbook.json")
        return url
    }
}
