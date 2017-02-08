//
//  ReservationViewController.swift
//  Reservation
//
//  Created by Tu Vu on 07/02/17.
//  Copyright © 2017 MAC. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:- Button Actions
    @IBAction func AddServiceButtonTaped(_ sender: Any) {
        
        self.performSegue(withIdentifier:"AddServiceSegue", sender:nil)
    }

}

extension ReservationViewController:UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.allCreatedReservation.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier:"reservationCell", for:indexPath) as? ReservationTableViewCell
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let reservation = appDelegate.allCreatedReservation[indexPath.row]
        
        cell?.weekDayLabel.text = reservation.timeSlot
        
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = dateFormateString
        cell?.dateLabel.text =  "\(reservation.day!) \(dateFormater.string(from:reservation.date!))"
        cell?.category.text = reservation.category!
        cell?.partySize.text = "\(partySize) - \(reservation.partySize!)"
        cell?.otherInfo.text = "3M"
        cell?.categoryDesc.text = reservation.categoryDesc!
      
        return cell!
    }
    
}

extension ReservationViewController:UITableViewDelegate {
    
}
