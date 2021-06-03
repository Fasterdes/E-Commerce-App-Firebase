//
//  Item.swift
//  E-Commerce
//
//  Created by Fa Ainama Caldera S on 03/03/21.
//

import SwiftUI


// Struct untuk mengambil data dari firebase

struct Item: Identifiable {
    var id : String
    var item_cost: NSNumber
    var item_details : String
    var item_image : String
    var item_name : String
    var item_ratings : String
}
