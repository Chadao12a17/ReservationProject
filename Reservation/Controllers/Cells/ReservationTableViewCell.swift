//
//  ReservationTableViewCell.swift
//  Reservation
//
//  Created by Tu Vu on 07/02/17.
//  Copyright © 2017 MAC. All rights reserved.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryDesc: UILabel!
    @IBOutlet weak var otherInfo: UILabel!
    @IBOutlet weak var partySize: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
