//
//  PersonTableViewCell.swift
//  AddressBook
//
//  Created by Trevor Adcock on 10/14/21.
//

import UIKit

protocol PersonTableViewCellDelegate: AnyObject {
    
    func toggleFavoriteButtonWasTapped(cell: PersonTableViewCell)
}

class PersonTableViewCell: UITableViewCell {
    
    
    var person: Person? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    
    
    // MARK: - Methods
    
    

    // MARK: - Helper Function
    
    func updateViews() {
        guard let person = person else { return }
        personNameLabel.text = person.name
    }
    
    // MARK: - IBActions
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
        
        
    }
    
}

