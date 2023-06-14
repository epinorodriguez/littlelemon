//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Eduardo Pino on 14-06-23.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    let firstName = UserDefaults.standard.string(forKey: "firstName")
    let lastName = UserDefaults.standard.string(forKey: "lastName")
    let email = UserDefaults.standard.string(forKey: "email")
    
    var body: some View {
        VStack{
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text(firstName ?? "")
            Text(lastName ?? "")
            Text(email ?? "")
            
            Button("Logout"){
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                
                presentation.wrappedValue.dismiss()
            }
            
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
