//
//  EditFoodView.swift
//  SampleCoreData
//

//

import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var food: FetchedResults<Food>.Element
    
    @State private var name = ""
    @State private var location = ""
    @State private var selectedDate = Date()
    

    @State private var selectedItem = ""
       var menuItem = ["Breakfast" ,  "lunch", "dinner", "coffee" , "Sweet" ]
    
    @State private var describe = ""
    @State var selected = -1
    @State private var image: UIImage?
    @State private var isShowingImagePicker: Bool = false
    @State var message = false
    var body: some View {
        ZStack {
            Color("Background").edgesIgnoringSafeArea(.all)
            VStack{
                Form {
                    Section() {
                      
                      
                           
                            TextField("\(food.name!)", text: $name)
                           
//
                       
                        if let img = food.photo {
                            Image(uiImage: img as! UIImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 330,height: 180)

                                .clipped()
                            
                        }
                       
                        
                        
                        
                        HStack{
                            Image(systemName: "chevron.down.circle")
                                .resizable()
                                .frame(width : 18,height: 20 )
                                .foregroundColor(Color(red: 0.678, green: 0.275, blue: 0.267))
                            Picker("Type", selection: $selectedItem )
                            {
                                ForEach(0 ..< menuItem.count) {_ in
                                   // Text(food.selectedItem!)
                                    Text(food.selectedItem!.localized)
                                }}}
//                        Picker(selection: $selectedItem, label: Text("Type")) {
//                            ForEach(menuItem , id: \.self) { menuItem in
//                                Text(menuItem.localized)
                        HStack{
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width : 18,height: 20 )
                                .foregroundColor(Color(red: 0.678, green: 0.275, blue: 0.267))
                            
                            DatePicker("Date", selection: $selectedDate , displayedComponents: [.date])
                        }
                        HStack{
                            Image(systemName: "star")
                                .resizable()
                                .frame(width : 18,height: 20 )
                                .foregroundColor(Color(red: 0.678, green: 0.275, blue: 0.267))
                            Text("Rate")
                                .accessibilityLabel("Rate")
                            Spacer()
                            ForEach(0..<5) { rating in
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(self.selected >= rating ? .yellow : .gray)
                                    .onTapGesture {
                                        self.selected = rating
                                        self.message.toggle()
                                    }
                            }
                        }
                        VStack(alignment: .leading){
                        
                               
                            Text("Location:")
                                .accessibilityLabel("Location")
                                .foregroundColor(Color(red: 0.678, green: 0.275, blue: 0.267))
                                TextField("\(food.location!)", text: $location)
    //
                
                            Text("Describe:")
                                .accessibilityLabel("Describe")
                                .foregroundColor(Color(red: 0.678, green: 0.275, blue: 0.267))
                            TextField("\(food.describe!)", text: $describe)
                            
                        }
                        VStack {
                            Spacer()
                            Button("Save") {
                                DataController().editFood(food: food, name: name, location: location,  selectedItem: selectedItem, selectedDate: selectedDate, describe: describe, selected: Int64(selected) , photo: image  , context: managedObjContext)
                                //
                                dismiss()
                            }     .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("Save")
                                

                            .foregroundColor(.white)
                            .frame(width: 300,height: 50)
                            .background(Color(red: 0.678, green: 0.275, blue: 0.267))
                            .cornerRadius(10)
                            Spacer()
                        }
                    }
                    
                }
                .onAppear {
                    name = food.name!
                    location = food.location!
                    selectedDate = food.selectedDate!
                    
                    selectedItem = food.selectedItem!
                    describe = food.describe!
                    selected = Int(Int64(selected))
                    
                    //                      
                    
                }
                
                
            }}
    }
    var contactImage: some View {
        if let image = image {
            return AnyView(Image(uiImage: image)
            
                .resizable()
                .scaledToFill()
                .frame(width: 330,height: 180)
//                .frame(width: 64, height: 64, alignment: .center)
                .clipped())
            
            .overlay(RoundedRectangle(cornerRadius:15)
                .stroke(Color(.black), lineWidth: 0))
            
        } else {
            return AnyView(Image(systemName: "camera.on.rectangle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 130, alignment: .center)
                .frame(width: 330,height: 180)
                .foregroundColor(.gray))
            .overlay(RoundedRectangle(cornerRadius:15)
                .stroke(Color(.black), lineWidth: 1))
            
        }}
        }

  //  }
//}

