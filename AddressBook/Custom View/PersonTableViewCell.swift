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
    
    // MARK: - Outlets
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    
    
    // MARK: - Methods
    
    
    // MARK: - IBActions
    
}

