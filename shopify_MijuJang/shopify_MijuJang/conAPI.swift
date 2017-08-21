//
//  conAPI.swift
//  shopify_MijuJang
//
//  Created by Lily Jang on 2017-08-20.
//  Copyright © 2017 Lily Jang. All rights reserved.
//

import Foundation

public class conAPI
{
    func getOrderList() -> (amount: amountData, list: [orderByItemData]?, message: String ) {
        var spendAmount = amountData(totalPrice: 0, allItemPrice: 0, discount: 0, tax: 0)
        var resultMessage = ""
        var orderList = [orderByItemData]()
        
        let orderAPI = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        
        
        let url = URL(string: orderAPI)
        let data = NSData(contentsOf: url!)
        
        do {
            let object = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
            if let dictionary = object as? [String: AnyObject] {
                //parse JSON data
                guard let dicOrderList = dictionary["orders"] as? [[String: AnyObject]]
                    else { return (spendAmount, orderList, "Data Error")}
                
                for order in dicOrderList {
                    guard let dicCanceledAt = order["cancelled_at"] as? String! ?? "",
                        let dicCurrency = order["currency"] as? String! ?? "",
                        let dicId = order["id"] as? Int64,
                        let didEmail = order["email"] as? String! ?? "",
                        let didCreated_at = order["created_at"] as? String! ?? "",
                        let dicTotal_price = order["total_price"] as? String! ?? "0.0",
                        let dicTotal_line_items_price = order["total_line_items_price"] as? String! ?? "0.0",
                        let dicTotal_discounts = order["total_discounts"] as? String! ?? "0.0",
                        let dicTotal_tax = order["total_tax"] as? String! ?? "0.0"  ,
                        let dicCustomer = order["billing_address"]?["name"] as? String! ?? ""
                         else { return (spendAmount, orderList, "Data Error") }
                    
                    //find uncanceled order, canada dollar and customer "Napoleon Batz"
                    if dicCanceledAt.isEmpty && dicCurrency == "CAD" && dicCustomer == "Napoleon Batz"{
                        
                        //Calculate prices
                        spendAmount.totalPrice += Double(dicTotal_price)!
                        spendAmount.allItemPrice += Double(dicTotal_line_items_price)!
                        spendAmount.discount += Double(dicTotal_discounts)!
                        spendAmount.tax += Double(dicTotal_tax)!
                        
                        guard let dicLine_items = order["line_items"] as? [[String: AnyObject]]
                            else { return (spendAmount, orderList, "Data Error") }
                        
                        //get Items
                        for item in dicLine_items {
                            guard let dicTitle = item["title"] as? String! ?? "",
                                let dicQuantity = item["quantity"] as? Int64,
                                let dicItem_price = item["price"] as? String! ?? "0.0"
                                else { return (spendAmount, orderList, "Data Error") }
                            
                            //set order list
                            orderList.append(orderByItemData(orderId: dicId, email: didEmail, Name: dicTitle, price: dicItem_price, quantity: dicQuantity, created_at: didCreated_at))
                        }
                        
                    }
                    
                }
            }
            
            
        } catch {
            resultMessage = "Connect Error"
        }

        
        return (spendAmount, orderList, resultMessage)
    }
    
    func getQuantityBag() -> (quantity: Int64, list: [orderByItemData]?, message: String ) {
        var quantity: Int64 = 0
        var resultMessage = ""
        var orderList = [orderByItemData]()

        //set API URL
        let orderAPI = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        
        //get JSON data
        let url = URL(string: orderAPI)
        let data = NSData(contentsOf: url!)
        
        do {
            let object = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
            if let dictionary = object as? [String: AnyObject] {
                //parse JSON data
                guard let dicOrderList = dictionary["orders"] as? [[String: AnyObject]]  else { return (quantity, orderList, "Data Error")}
                
                for order in dicOrderList {
                    guard let dicCanceledAt = order["cancelled_at"] as? String! ?? "",
                        let dicId = order["id"] as? Int64,
                        let dicEmail = order["email"] as? String! ?? "",
                        let didCreated_at = order["created_at"] as? String! ?? "",
                        let dicLine_items = order["line_items"] as? [[String: AnyObject]]
                        else { return (quantity, orderList, "Data Error") }
                    
                    //find uncancel order
                    if dicCanceledAt.isEmpty {
                        
                        //get item list
                        for item in dicLine_items {
                            guard let dicTitle = item["title"] as? String! ?? "",
                                let dicQuantity = item["quantity"] as? Int64,
                                let dicItem_price = item["price"] as? String! ?? "0.0"
                            else { return (quantity,orderList, "Data Error") }
                            
                            //find the "Awesome Bronze Bag"
                            if dicTitle == "Awesome Bronze Bag" {
                                quantity += dicQuantity
                                
                                //set order list
                                orderList.append(orderByItemData(orderId: dicId, email: dicEmail, Name: dicTitle, price: dicItem_price, quantity: dicQuantity, created_at: didCreated_at))
                            }
                        }
                    }
                    
                }
            }
            
            
        } catch {
            resultMessage = "Connect Error"
        }

        
        return (quantity, orderList, resultMessage)
    }
    
}
