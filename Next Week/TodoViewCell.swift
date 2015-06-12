//
//  TodoViewCell.swift
//  Next Week
//
//  Created by Andras Toth on 12/06/15.
//  Copyright (c) 2015 Andras Toth. All rights reserved.
//

import ParseUI

@IBDesignable
class TodoViewCell: PFTableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var taskCount: UILabel!
    @IBOutlet weak var day: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        autoresizesSubviews = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
