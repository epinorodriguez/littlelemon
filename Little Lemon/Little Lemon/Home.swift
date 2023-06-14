//
//  Home.swift
//  Little Lemon
//
//  Created by Eduardo Pino on 14-06-23.
//

import SwiftUI

struct Home: View {
    
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        TabView{
            Menu().environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tabItem{
                    Label("Menu", systemImage: "list.dash")
                }
            
            UserProfile()
                .tabItem{
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
