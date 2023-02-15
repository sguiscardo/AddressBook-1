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
    
    // MARK: - Properties
    var person: Person? {
        didSet {
            updateViews()
            
        }
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: PersonTableViewCellDelegate?
    

    
    
    // MARK: - Methods
    
    

    // MARK: - Helper Function
    
    func updateViews() {
        guard let person = person else { return }
        personNameLabel.text = person.name
    }
    func updateFavoriteButton() {
        guard let person = person else { return }
        let favoriteImageName = person.isFavorite ? "star.fill" : "star"
        let favoriteImage = UIImage(systemName: favoriteImageName)
        favoriteButton.setImage(favoriteImage, for: .normal)
    }
    
    // MARK: - IBActions
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
        delegate?.toggleFavoriteButtonWasTapped(cell: self)
        
        
        
    }
    
}

