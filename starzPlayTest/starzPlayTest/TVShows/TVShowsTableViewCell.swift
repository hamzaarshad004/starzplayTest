//
//  TVShowsTableViewCell.swift
//  starzPlayTest
//
//  Created by Hamza Sheikh on 19/03/2024.
//

import UIKit

class TVShowsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblShowNmae: UILabel!
    @IBOutlet weak var lblShowOverview: UILabel!
    @IBOutlet weak var tvShowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
