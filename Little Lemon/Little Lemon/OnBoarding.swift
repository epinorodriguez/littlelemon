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
                
                VStack{
                    HStack{
                        
                        VStack(alignment: .leading){
                            Text("Little Lemon")
                                .font(.title)
                                .foregroundColor(Color("approvedYellow"))
                            Text("Chicago")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        
                        AsyncImage(url: URL(string: "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/bruschetta.jpg?raw=true")){ image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .cornerRadius(20)
                    }
                }
                .padding(10)
                .frame(width: 400, height: 200)
                .background(Color("green"))
                
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
                .frame(width: 200)
                .containerShape(Rectangle())
                .padding(10)
                .foregroundColor(.white)
                .background(Color("green"))
                .cornerRadius(20)
                
                
                Spacer()
            }
            .padding(.leading, 10)
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
