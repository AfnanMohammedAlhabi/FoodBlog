//
//  ContentView.swift
//  SampleCoreData
//
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
   
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddView = false
    @State private var image: UIImage?
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background").edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                              
                    List {
                        ForEach(food) { food in
                            NavigationLink(destination: EditFoodView(food: food)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
//
                                        if let img = food.photo {
                                            Image(uiImage: img as! UIImage)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 370, height: 170, alignment: .center)
                                                .clipped()
                                            
                                            Text(food.name!)
                                                .accessibilityLabel(food.name!)
                                                .bold()
                                            
                                        }
                                    }
                                    
                                }
                            }.accessibilityLabel(" click here for view and edit review")
                                .accessibilityAddTraits(.isButton)
                        }
                        .onDelete(perform: deleteFood)
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("My Review")
                .accessibilityLabel("My Review")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddView.toggle()
                        } label: {
                            Label("new Review", systemImage: "plus")
                            
                        } .foregroundColor(Color(red: 0.678, green: 0.275, blue: 0.267))
                            .font(.title)
                            .accessibilityLabel(" Add new Review")

                    }
                    
                }
                .sheet(isPresented: $showingAddView) {
                    AddFoodView()
                    
                }
                
            }
        }
        .navigationViewStyle(.stack) // Removes sidebar on iPad
    }
    
    // Deletes food at the current offset
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }
            .forEach(managedObjContext.delete)
            
            // Saves to our database
            DataController().save(context: managedObjContext)
        }
    }
    
   
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
