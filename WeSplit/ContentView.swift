//
//  ContentView.swift
//  WeSplit
//
//  Created by Jacob Tamayo on 3/28/22.
//

//Check spliting app

//Todos:
//1. User needs to be able to enter the bill full amount
//2. How many people are spliting the check
//3. What tip amount do they want to leave?

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var totalPeople = 2
    @State private var tipAmount = 20
    @FocusState private var amountIsFocused: Bool
    
    //An array that hold other tip options for the user
    var tipPercentages = [10, 15, 20, 25, 0]
    
    //Create a computed property
    var totalPerPerson: Double {
        //1. Find how many people there are total
        let peopleCount = Double(totalPeople)
        let tipSelection = Double(tipAmount)
        
        let tipValue = checkAmount / 100 * tipSelection
        
        //Find the grand total with tip included
        let grandTotal = checkAmount + tipValue
        
        //Next calculate total amount per person
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        //NavigationView adds room at the top right before the notch. This lets back button and naviagtion titles show.
        NavigationView {
            Form {
                Section {
                    //Locale is a massive struct built into iOS that is responsible for storing all the user’s region settings – what calendar they use, how they separate thousands digits in numbers, whether they use the metric system, and more.
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people:", selection: $totalPeople) {
                        ForEach(0..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipAmount) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip percentage amount")
                }
                
                Section {
                    //You dont need to bind check amount because your not editing the state here, its just being updated from the above textfield.
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD" ))
                } header: {
                    Text("Total amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
