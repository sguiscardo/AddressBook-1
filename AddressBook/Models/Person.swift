//
//  Person.swift
//  AddressBook
//
//  Created by Trevor Adcock on 10/12/21.
//

import Foundation

class Person: Codable {
    let id: UUID
    var name: String
    var address: String
    
    init(id: UUID = UUID(),
         name: String,
         address: String) {
        self.id = id
        self.name = name
        self.address = address
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
