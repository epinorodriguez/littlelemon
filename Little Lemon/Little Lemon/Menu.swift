//
//  Menu.swift
//  Little Lemon
//
//  Created by Eduardo Pino on 14-06-23.
//

import SwiftUI
import CoreData

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    
    var body: some View {
        VStack{
            
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
            
            
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                    TextField("Search menu", text: $searchText)
                List{
                    ForEach(dishes){ dish in
                        
                        NavigationLink(destination: DishDetail(dish: dish))
                        {
                            HStack{
                                Text("\(dish.title ?? "") ")
                                Spacer()
                                Text("\(dish.price ?? "")")
                                    .monospaced()
                                    .font(.callout)
                                AsyncImage(url: URL(string: dish.image ?? "" )){ image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                    
                            }
                        }
                        
                        
                        
                    }
                }
            }

        }
        .onAppear{
            PersistenceController.shared.clear()
            
            getMenuData()
        }
    }
    
    func buildPredicate() -> NSPredicate
    {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        }
        else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor]{
        
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                  selector:
                                     #selector(NSString.localizedCaseInsensitiveCompare))]
    }
    
    func getMenuData()
    {
        
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")
        
        let urlRequest = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in

                guard let data = data else {
                      return
                }
            

                do {
                    
                    let json = try JSONDecoder().decode(MenuList.self, from: data)
//                    self.info = json
                    print(json)
                    
                    let menu = json.menu
                    
                    for menuItem in menu {
                        
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.price = menuItem.price
                        dish.image = menuItem.image
                        dish.dishDescription = menuItem.description
                        dish.id = menuItem.id
                        dish.category = menuItem.category
                    }
                    
                    if viewContext.hasChanges {
                        try? viewContext.save()
                    }
                    
//                    completion(info)
                } catch {
                    print(error.localizedDescription)
                }

            }.resume()
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
