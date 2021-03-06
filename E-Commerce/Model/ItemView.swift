//
//  ItemView.swift
//  E-Commerce
//
//  Created by Fa Ainama Caldera S on 03/03/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
   var item: Item
    var body: some View {
      VStack{
        // WebImage keyword dari libarary SDWebImageSwiftUI
         WebImage(url: URL(string: item.item_image))
            .resizable()
            .frame(width: UIScreen.main.bounds.width - 30,height: 250)
            .aspectRatio(contentMode: .fill)
            
         
         HStack(spacing: 8){
            Text(item.item_name)
               .font(.title2)
               .fontWeight(.bold)
               .foregroundColor(.black)
            
            Spacer(minLength: 0)
            
            ForEach(1...5,id: \.self){index in
               Image(systemName: "star.fill")
                  .foregroundColor(index <= Int(item.item_ratings) ?? 0 ? Color.purple: .gray)
            }
         }
         
         HStack{
            Text(item.item_details)
               .font(.caption)
               .foregroundColor(.gray)
               .lineLimit(2)
            
            Spacer(minLength: 0)
         }
      }
    }
}
