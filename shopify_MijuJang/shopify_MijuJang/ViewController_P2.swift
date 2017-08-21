//
//  ViewController_P2.swift
//  shopify_MijuJang
//
//  Created by Lily Jang on 2017-08-20.
//  Copyright © 2017 Lily Jang. All rights reserved.
//

import UIKit

class ViewController_P2: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var Label_Quantity: UILabel!
    @IBOutlet weak var TableView_OrderList: UITableView!
    
     var quantityList = [orderByItemData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TableView_OrderList.delegate = self
        self.TableView_OrderList.dataSource = self
        
        //call orderAPI class to connect shopify order API
        let orderAPI = conAPI()
        
        //get result data
        let result = orderAPI.getQuantityBag()
        
        if result.message == "" {
            
            //display amount datas
            Label_Quantity.text = String(result.quantity)
            
            quantityList = result.list!
        }
        else{
            displayAlertMessage(messageToDisplay: result.message + " : Unable to get data. \nNow go back to MenuPage. Please, Try again!")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quantityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell_QuantityList", for: indexPath) as! TableViewCell_QuantityList
        
        //set order item on the orderList cell
        cell.Label_OrderId.text = String(quantityList[indexPath.row].orderId)
        cell.Label_Customer.text = quantityList[indexPath.row].email
        cell.Label_Title.text = quantityList[indexPath.row].Name
        cell.Label_Price.text = quantityList[indexPath.row].price
        cell.Label_Quantity.text = String(quantityList[indexPath.row].quantity)
        cell.Label_CreateAt.text = quantityList[indexPath.row].created_at
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlertMessage(messageToDisplay: String){
        let alertController = UIAlertController(title: "Sorry!", message: messageToDisplay, preferredStyle: .alert)
        
        //go back to previouse page
        let OKAction = UIAlertAction(title: "OK", style: .default) { (ACTION:UIAlertAction) in
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
