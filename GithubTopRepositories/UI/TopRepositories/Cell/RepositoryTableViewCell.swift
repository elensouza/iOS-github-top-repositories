//
//  RepositoryTableViewCell.swift
//  GitTopUsers
//
//  Created by Elen de Souza on 11/05/19.
//  Copyright © 2019 Elen de Souza. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {


    

    @IBOutlet weak var authorImgView: UIImageView!
    @IBOutlet weak var labelRepoName: UILabel!
    @IBOutlet weak var labelAuthorName: UILabel!
    @IBOutlet weak var labelStars: UILabel!
    @IBOutlet weak var viewBorder: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewBorder.layer.cornerRadius = 8
        viewBorder.layer.shadowColor = UIColor.gray.cgColor
        viewBorder.layer.shadowOpacity = 3
        viewBorder.layer.shadowOffset = CGSize.zero
        viewBorder.layer.shadowRadius = 2

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
