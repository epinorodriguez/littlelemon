//
//  OnBoarding.swift
//  Little Lemon
//
//  Created by Eduardo Pino on 14-06-23.
//

import SwiftUI

struct OnBoarding: View {
    
 @State var firstName = ""
 @State var lastName = ""
 @State var email = ""
    
    @State var isLoggedIn = false
    
    let kFirstName = "firstName"
    let kLastName = "lastName"
    let kEmail = "email"
    let kIsLoggedIn = "isLoggedIn"
    
    var body: some View {
        NavigationView{
            VStack{
                
                NavigationLink(destination: Home(), isActive: $isLoggedIn){
                    EmptyView()
                }
                
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                
                Button("Register"){
                    
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && isValidEmail(email) {
                        
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        
                        isLoggedIn = true
                    }
                    else
                    {
                        print("invalid")
                    }
                }
            }
        }
        .onAppear{
            if UserDefaults.standard.bool(forKey: kIsLoggedIn){
                isLoggedIn = true
            }
        }
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
