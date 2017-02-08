//
//  ReservationDetails+CoreDataProperties.swift
//  Reservation
//
//  Created by Tu Vu on 08/02/17.
//  Copyright © 2017 MAC. All rights reserved.
//

import Foundation
import CoreData


extension ReservationDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReservationDetails> {
        return NSFetchRequest<ReservationDetails>(entityName: "ReservationDetails");
    }

    @NSManaged public var timeSlot: String?
    @NSManaged public var categoryDesc: String?
    @NSManaged public var date: Date?
    @NSManaged public var partySize: NSNumber?
    @NSManaged public var category: String?
    @NSManaged public var day: String?

}
