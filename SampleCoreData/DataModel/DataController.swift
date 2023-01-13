
//

import Foundation
import CoreData
import UIKit

class DataController: ObservableObject {
    // Responsible for preparing a model
    let container = NSPersistentContainer(name: "FoodModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully. WUHU!!!")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addFood(name: String, location: String , selectedDate : Date ,selectedItem:String, describe: String , selected: Int64, photo : UIImage?, context: NSManagedObjectContext) {
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.location = location
        food.selectedItem = selectedItem
        food.selectedDate = selectedDate
        food.describe = describe
        food.selected = Int64(selected)
        food.photo = photo
//        food.selected =  Date()
      //  self.selectedImg.count = 0

        
        save(context: context)
    }
    
    func editFood(food: Food, name: String, location: String, selectedItem: String , selectedDate : Date , describe: String , selected:Int64,  photo : UIImage? , context: NSManagedObjectContext) {
        food.date = Date()
        food.name = name
        food.location = location
        food.selectedDate = selectedDate
        food.selectedItem = selectedItem
        food.describe = describe
        food.selected = Int64(selected)
        food.photo = photo
//        food.selected =  Date()
       // selected : Data = .init(count: 0)
        save(context: context)
    }
}
