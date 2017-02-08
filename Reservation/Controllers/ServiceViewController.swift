//
//  ServiceViewController.swift
//  Reservation
//
//  Created by Tu Vu on 07/02/17.
//  Copyright © 2017 MAC. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController {
    
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.configureScrollView()
        
        
        //for table view border
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 1.0
        
        //for shadow
        containerView.backgroundColor = UIColor.clear
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowRadius = 2
        
        //for rounded corners
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func reserveButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier:"scheduleSegue", sender:nil)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    /**
     This function configure images on scrollview for Page control sync
     - parameter
     - returns: String
     */
    func configureScrollView() {
      
        //1
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        //2
    
        //3
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgOne.image = UIImage(named: "slide1")
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgTwo.image = UIImage(named: "slide3")
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgThree.image = UIImage(named: "slide2")
        
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)
        //4  Scroll view content size according to page control number
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 3, height:self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        
        self.view.bringSubview(toFront:containerView)
        self.view.bringSubview(toFront:reserveButton)
        self.view.bringSubview(toFront:pageControl)

    }
}

//MARK:- ScrollView Delegate
extension ServiceViewController:UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    {
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage)
        
        if pageControl.currentPage == 2 {
            reserveButton.isEnabled = true
        }else {
            reserveButton.isEnabled = false
        }
    }
}

//MARK:- TableView DataSource


extension ServiceViewController:UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier:"serviceCell", for:indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = ServiceOptions.swedishMessage
        case 1:
            cell.textLabel?.text = ServiceOptions.deepTissueMassage
        case 2:
            cell.textLabel?.text = ServiceOptions.hotStoneMessage
        case 3:
            cell.textLabel?.text = ServiceOptions.reflexology
        case 4:
            cell.textLabel?.text = ServiceOptions.triggerPointTherapy
        default:
            cell.textLabel?.text = ""
        }
        return cell
    }
}

//MARK:- TableView Delegate

extension ServiceViewController:UITableViewDelegate {
    
     public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            self.performSegue(withIdentifier:"scheduleSegue", sender:nil)
        }
    }
}
