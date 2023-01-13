//
//

import SwiftUI
import CoreData
import UIKit
struct AddFoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var location = ""
    @State var selectedDate = Date()
    
    @State var item = ""
    @State private var selectedItem = ""
    
    
    var menuItem = ["Breakfast" ,  "lunch", "dinner", "coffee" , "Sweet" ]
    @State private var describe = ""
    @State var selected = -1
    @State var message = false
    
    @State private var image: UIImage?
    @State private var isShowingImagePicker: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background").edgesIgnoringSafeArea(.all)
                VStack{
                    Form {
                        Section{
                            
                            VStack(alignment:.leading){
                                Text("Add Picture")
                                    .accessibilityLabel("Add Picture for your diash")
                                    .accessibilityRemoveTraits(.isImage)
                                VStack{
                                    contactImage.onTapGesture {
                                        self.isShowingImagePicker = true
                                    } .accessibilityAddTraits(.isButton)
                                   
                                    VStack(alignment:.leading){
                                        Text("Name diash")
                                    .accessibilityLabel("Enter your diash name")
                                        TextField("  Name diash", text: $name)
                                            .accessibilityLabel("Enter your diash name ")
                                            .frame(width: 330,height: 40)
                                        
                                            .overlay(RoundedRectangle(cornerRadius:15)
                                                .stroke(Color(.lightGray), lineWidth: 1))
                                    }
                                    //                        Divider()
                                    //
                                    VStack(alignment:.leading){
                                        Text("Location")
                                            .accessibilityLabel("Enter your Location")
                                        TextField("   Add location", text: $location)
                                            .accessibilityLabel("Enter your  Location")
                                            .frame(width: 330,height: 40)
                                            .overlay(RoundedRectangle(cornerRadius:15)
                                                .stroke(Color(.lightGray), lineWidth: 1))
                                        
                                    }
                                    
                                    
                                    
                                    Divider()
                                    
                                    
                                    HStack{
                                        Image(systemName: "chevron.down.circle")
                                            .resizable()
                                            .frame(width : 18,height: 20 )
                                            .foregroundColor(Color(red: 0.678, green: 0.275, blue: 0.267))
                                        Picker(selection: $selectedItem, label: Text("Type")) {
                                            ForEach(menuItem , id: \.self) { menuItem in
                                                Text(menuItem.localized)
                                                    .accessibilityLabel("Enter your type of diash")
                                            }}
                                    }
                                    
                                    
                                    HStack{
                                        Image(systemName: "calendar")
                                            .resizable()
                                            .frame(width : 18,height: 20 )
                                            .foregroundColor(Color(red: 0.678, green: 0.275, blue: 0.267))
                                        
                                        DatePicker("Date", selection: $selectedDate , displayedComponents: [.date])
                                            .accessibilityLabel("Enter the date")
                                    }
                                    HStack{
                                        Image(systemName: "star")
                                            .resizable()
                                            .frame(width : 18,height: 20 )
                                            .foregroundColor(Color(red: 0.678, green: 0.275, blue: 0.267))
                                        Text("Rate")
                                        .accessibilityLabel("Enter your rate")
                                        Spacer()
                                        ForEach(0..<5) { rating in
                                            Image(systemName: "star.fill")
                                                .resizable()
                                                .frame(width: 15, height: 15)
                                                .foregroundColor(self.selected  >= rating ? .yellow : .gray)
                                                .onTapGesture {
                                                    self.selected = rating
                                                    self.message.toggle()
                                                }
                                        }
                                    }
                                                            Divider()
                                    VStack(alignment:.leading){
                                        Text("Describe")
                                            .accessibilityLabel("Enter Describe")
                                        TextField("  Describe", text: $describe)
                                            .accessibilityLabel("Enter Describe")
                                            .frame(width: 330,height: 80, alignment: .center)
                                            .overlay(RoundedRectangle(cornerRadius:15)
                                                .stroke(Color(.lightGray), lineWidth: 1))
                                            
                                    }
                                    //                        //
                                    
                                   Spacer()
                                }
                                
                                
                                
                                
                                
                            }
                            VStack {
                                //                            Spacer()
                                Button("Save") {
                                    DataController().addFood(
                                        name: name, location: location,
                                        selectedDate: selectedDate, selectedItem: selectedItem,
                                        describe: describe, selected: Int64(selected),
                                        photo: image,

                                        context: managedObjContext)

                                    dismiss()
                                }
                                    .accessibilityLabel("Save")
                                    .accessibilityAddTraits(.isButton)

                                .foregroundColor(.white)
                                .frame(width: 300,height: 50)
                                .background(Color(red: 0.678, green: 0.275, blue: 0.267))
                                .cornerRadius(10)
                                
                                Spacer()
                            }
                            .padding(.all)
                        }
                        
                        //            .listSectionSeparator(.hidden)
                        //.listSectionSeparatorTint(.red)
                        .navigationTitle("New Review")
                        .accessibilityLabel("New Review")
                        .sheet(isPresented: $isShowingImagePicker, onDismiss: {
                            isShowingImagePicker = false
                        }, content: {
                            ImagePicker(selectedImage: $image)
                        })
                        
                    }
//
                   
                }
            }
        }
    }
   // A NSLocalizedString for this String where a key has to be added to Localizable.strings file.
   
    ///
    var contactImage: some View {
        if let image = image {
            return AnyView(Image(uiImage: image)
            
                .resizable()
                .scaledToFill()
                .frame(width: 330,height: 180)
//                
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
                .stroke(Color(.lightGray), lineWidth: 1))
            
        }}
}
public extension String {
var localized: String {
return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
}

func localized(args: CVarArg...) -> String {
    return withVaList(args) {
        NSString(format: self.localized, locale: Locale.current, arguments: $0) as String
    }
}
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
