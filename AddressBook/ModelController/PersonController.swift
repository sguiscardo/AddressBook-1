//
//  PersonController.swift
//  AddressBook
//
//  Created by Trevor Adcock on 10/12/21.
//

import Foundation

class PersonController {
    
    // MARK: - Properties
//    static let shared = PersonController()
    static let sharedPerson = PersonController()
    
    // MARK: - People
    func createPerson(name: String = "New Contact",
                      address: String = "",
                      group: Group) {
        let person = Person(name: name, address: address)
        group.people.append(person)
        GroupController.shared.saveContactsToDisk()
    }
    
    func delete(person: Person, in group: Group) {
        guard let index = group.people.firstIndex(of: person) else { return }
        group.people.remove(at: index)
        GroupController.shared.saveContactsToDisk()
    }
    
    func update(person: Person,
                name: String,
                address: String) {
        person.name = name
        person.address = address
        GroupController.shared.saveContactsToDisk()
    }
    
    func toggleFavorite(person: Person) {
        person.isFavorite.toggle()
        GroupController.shared.saveContactsToDisk()
    }
    
    
    
}
