//
//  DishDetail.swift
//  Little Lemon
//
//  Created by Eduardo Pino on 14-06-23.
//

import SwiftUI

struct DishDetail: View {
    
    @State var dish: Dish?
    
    
    var body: some View {
        AsyncImage(url: URL(string: dish?.image ?? "" )){ image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: .infinity, height: 250)
        Text(dish?.title ?? "")
        Text(dish?.price ?? "")
        Text(dish?.category ?? "")
        Text(dish?.dishDescription ?? "")
        Spacer()
    }
}

struct DishDetail_Previews: PreviewProvider {
    static var previews: some View {
        DishDetail()
    }
}
