//
//  Reservation.swift
//  Reservation
//
//  Created by Tu Vu on 08/02/17.
//  Copyright © 2017 MAC. All rights reserved.
//

import Foundation

// MARK: - Reservation data object

struct Reservation {
    
    let timeSlot: String?
    let date: Date?
    let day: String?
    let category: String?
    let partySize:Int?
    let categoryDesc: String?

    init(timeSlot:String, date:Date, day:String, category:String, partySize:Int, categoryDesc:String) {
        self.timeSlot = timeSlot
        self.date = date
        self.day = day
        self.category = category
        self.partySize = partySize
        self.categoryDesc = categoryDesc
    }
}
