//
//  PostTableViewCell.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 28/7/21.
//

import UIKit
import Kingfisher

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureImageView: IAImageView!
    @IBOutlet weak var numberArrowLabel: UILabel!
    @IBOutlet weak var numberMessagesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let reuseIdentifier = "PostCell"
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configUI(post: DataPost) {
        self.setImage(post.url)
        self.descriptionLabel.text = post.title
        self.numberArrowLabel.text = String(post.score)
        self.numberMessagesLabel.text = String(post.num_comments)
    }
    
    func setImage(_ urlString: String?) {
        guard let urlString = urlString, !urlString.isEmpty, let imageURL = URL(string: urlString) else { return }
        
        let processor = DownsamplingImageProcessor(size: pictureImageView.bounds.size)
        pictureImageView.kf.indicatorType = .activity
        pictureImageView.kf.setImage(with: imageURL,
                                options: [
                                    .processor(processor),
                                    .scaleFactor(UIScreen.main.scale),
                                    .transition(.fade(1)),
                                ],
                                completionHandler: { result in
            switch result {
            case .success:
                break
            case .failure:
                break
            }
        })
    }
}
