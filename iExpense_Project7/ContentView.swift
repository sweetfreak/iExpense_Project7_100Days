//
//  ContentView.swift
//  iExpense_Project7
//
//  Created by Jesse Sheehan on 8/18/24.
//
//import Observation
import SwiftUI

struct ExpenseItem: Identifiable, Codable, Hashable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: String
}

//observable items can be used in more than one SwiftUI View
@Observable
class Expenses {
    var items = [ExpenseItem]()  {
        didSet {
            //the "encode()" method can only work with classes marked as Codable (so adjust the ExpenseItem struct to conform to the Codable protocol)
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var personalItems: [ExpenseItem] {
      items.filter { $0.type == "Personal"}
    } 
    var businessItems: [ExpenseItem] {
      items.filter { $0.type == "Business"}
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
    }
    
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    @State private var expenseType = "Personal"
    
//    @State private var expensesListPersonal: [ExpenseItem]
//    @State private var expensesListBusiness: [ExpenseItem]
    
    //ADDED FOR CHALLENGE Project 9
    @State private var path = NavigationPath()
    
    
    var body: some View {
        
        NavigationStack {

            
            
            List {
                Picker("Personal or Business", selection: $expenseType) {
                    ForEach(["Personal", "Business"], id: \.self) {
                                    Text($0)
                                }

                            }.pickerStyle(.segmented)
                
                ForEach(expenseType == "Personal" ? expenses.personalItems : expenses.businessItems) { item in
                    
                    HStack {
                       
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: item.currency))
                                .foregroundStyle(item.amount < 10 ? .green : item.amount < 100 ? .black : .red)
                                .bold()
                        }
                    }
                .onDelete(perform: removeItems)
            }.navigationTitle("iExpense App")
            //PROJECT 9 CHALLENGE 1
                .toolbar {
                    NavigationLink(destination: AddView(expenses: expenses)) {
                        Image(systemName: "plus")
                    }
                    
                }
            
            
//                .toolbar {
//                    Button("Add Expense", systemImage: "plus") {
//                        
//                          //Test:
//  //                        let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//  //                        expenses.items.append(expense)
//
//                        showingAddExpense = true
//
//                    }
//                }
//                .sheet(isPresented: $showingAddExpense) {
//                    AddView(expenses: expenses)
//                }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        //creates the list of items being displayed at the moment.
        let itemsToDelete = expenseType == "Personal" ? expenses.personalItems : expenses.businessItems
        //for each item in the set
        for index in offsets {
            //if there's an item in the full items list with an id equal to the itemstodelete[index]...
            if let indexInItems = expenses.items.firstIndex(where: { $0.id == itemsToDelete[index].id }) {
                //then remove it:
                expenses.items.remove(at: indexInItems)
            }
        }
    }
    
}






















//ALL THE LESSON CODE



//OBSERVABLE - use this to update the class
//@Observable
//class User {
//    var firstName = "Derek"
//    var lastName = "Swanson"
//}

//struct SecondView: View {
//    @Environment(\.dismiss) var dismiss
//    let name: String
//    var body: some View {
//        Text("Hello, \(name)!")
//        Button("Dismiss") {
//            dismiss()
//        }
//    }
//}

//the :Codable tells SwiftUI to un/archive user instances for us quickly/as needed.
//works well with json!!
//struct User: Codable {
//    let firstName: String
//    let lastName: String
//}

//struct ContentView: View {
    
    //@State private var user = User()
//    @State private var showingSheet = false
    
    //@State private var numbers = [Int]()
    //@State private var currentNumber = 1
    
   // @State private var user = User(firstName: "Taylor", lastName: "Swift")
    
    
    //AppStorage works like @State, reinvokes the UI to show the latest data
    //AppStorage can't/isn't good for storing structs
    //Best practice is to let users know you're storing their info.
 //  @AppStorage("tapCount") private var tapCount = 0
   // @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap") //0
    
    
   // var body: some View {
        
//        Button("Save User") {
//            let encoder = JSONEncoder()
//            if let data = try? encoder.encode(user) {
//                UserDefaults.standard.set(data, forKey: "UserData") //data is a type of data called Data - it's basically a big binary blob
//            }
        
        
        
        
        
        
        
//        Button("Tap Count: \(tapCount)") {
//            tapCount += 1
//        }
    
            //UserDefaults.Standard - the standard userDefault appstorage - you could make your own if you need it to share the values between that and a widget (for ex)
                // a single "Set" method that accepts a widw variety of data - could be ints, bools, strings, etc
            //third - string name to the value you're writing out - it's CASE SENSITIVE - and you'll use the value again later
           // UserDefaults.standard.set(tapCount, forKey: "Tap")
        
//        NavigationStack {
//        VStack {
//            List {// you technically could put (numbers,id: \.self) next to List, and it would show/do the same thing - EXCEPT the OnDelete modifier only works with ForEach, it won't work with List!
//                ForEach(numbers, id: \.self) {
//                    Text("Row \($0)")
//                }
//                .onDelete(perform: removeRows)
//            }
//            
//            Button("Add Number") {
//                numbers.append(currentNumber)
//                currentNumber += 1
//            }
//        }.toolbar {
//            EditButton()
//        }
    
    
//    }
        
//
//        Button("Show Sheet") {
//            //show the sheet
//            showingSheet.toggle()
//        }
//        .sheet(isPresented: $showingSheet, content: {
//            //contents of the sheet
//            SecondView(name: "Jesse")
//        })
        
        
//        VStack {
//            Text("Your name is \(user.firstName) \(user.lastName)")
//            
//            TextField("First name", text: $user.firstName)
//            TextField("Last name", text: $user.lastName)
//                
//        }
//        .padding()
    
    
    
 //   }
    
    //can tell swiftUI to call this method when it wants to delete data in the ForEach
//    func removeRows(at offsets: IndexSet) {
//        
//        numbers.remove(atOffsets: offsets)
//    }
//}



#Preview {
    ContentView()
}
