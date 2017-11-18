//
//  CustomTableViewCell.swift
//  SampleHTTP
//
//  Created by 松山友也 on 2017/11/17.
//  Copyright © 2017年 Tomoya Matsuyama. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var githublabel: UILabel!
    @IBOutlet weak var followlabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
