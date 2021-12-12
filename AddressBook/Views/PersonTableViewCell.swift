//
//  RecipeTableViewCell.swift
//  Recipes
//
//  Created by DevMountain on 10/14/21.
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
    weak var delegate: PersonTableViewCellDelegate?
    var person: Person? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let person = person else { return }
        personNameLabel.text = person.name
        let favoriteImageName = person.isFavorite ? "star.fill" : "star"
        let favoriteImage = UIImage(systemName: favoriteImageName)
        favoriteButton.setImage(favoriteImage, for: .normal)
    }
    
    // MARK: - IBActions
    @IBAction func toggleFavoriteButtonTapped(_ sender: UIButton) {
        delegate?.toggleFavoriteButtonWasTapped(cell: self)
    }
}
