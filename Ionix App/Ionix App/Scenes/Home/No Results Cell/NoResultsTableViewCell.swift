//
//  NoResultsTableViewCell.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 30/7/21.
//

import UIKit

class NoResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var msgErrorLabel: UILabel!
    
    static let reuseIdentifier = "NoResultsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
