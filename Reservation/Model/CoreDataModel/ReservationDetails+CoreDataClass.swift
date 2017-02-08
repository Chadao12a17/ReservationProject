//
//  ReservationDetails+CoreDataClass.swift
//  Reservation
//
//  Created by Tu Vu on 08/02/17.
//  Copyright © 2017 MAC. All rights reserved.
//

import Foundation
import CoreData

@objc(ReservationDetails)
public class ReservationDetails: NSManagedObject {

    class func createReservationRecord(reservation:Reservation, inManagedObjectContext context: NSManagedObjectContext) {
        let reservationObject = NSEntityDescription.insertNewObject(forEntityName: "ReservationDetails", into: context) as! ReservationDetails
        
        reservationObject.timeSlot = reservation.timeSlot
        reservationObject.date = reservation.date
        reservationObject.day = reservation.day
        reservationObject.categoryDesc = reservation.categoryDesc
        reservationObject.category = reservation.category
        reservationObject.partySize = reservation.partySize as NSNumber?

    }
    
    class func getReservationRecords(inManagedObjectContext context: NSManagedObjectContext) -> [ReservationDetails]? {
        
        let request = NSFetchRequest<ReservationDetails>(entityName: "ReservationDetails")
        do {
            let results = try context.fetch(request)
            return results
        } catch {
            print("Error with request: \(error)")
            return []
        }
    }
    
}
