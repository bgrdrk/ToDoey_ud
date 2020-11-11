//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {


    var itemArray = [Item]()
    
//    cia naudojam userDefaults saugoti duomenims. Sita reiktu naudoti TIK su lengvom ir paprastom, standartinem reiksmem/types
//    let defaults = UserDefaults.standard
    
    // create the path to the document folder
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // UIApplication.shared -> corresponds to the current app running. We are casting it to our class AppDelegate.swift
    // And now we have accesss to our class AppDelegate and it's properties
    let context = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()

    }

    //MARK - Tableview Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // what to put in which row, will be called Int times returned by func above
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        // sets the setting to the opposite with the - ! - help
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()

    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            self.saveItems()
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        alert.addAction(action)
        
    }
    
    //MARK: - Model Manipulation Methods
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving message, \(error)")
        }
        
    }
    
    func loadItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }
    }

    
}

//MARK: - Search Bar Methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("paspaudziau")
    }
    
}

//    func saveItemsWithEncoder() {
////        encoder buvo naudojamas saugojant duomenis i CoreData??
//        let encoder = PropertyListEncoder()
//
//        do {
//            // uzkoduoti su encoderiu.
//            let data = try encoder.encode(itemArray)
//            // irasyti uzkoduota info i filepath
//            try data.write(to: dataFilePath!)
//        } catch {
//            print("Error encoding item array, \(error)")
//        }
//    }

//func loadItems() {
//    if let data = try? Data(contentsOf: dataFilePath!) {
//        let decoder = PropertyListDecoder()
//        do {
//            itemArray = try decoder.decode([ItemNotUsingAnymoreLeftForMemories].self, from: data)
//        } catch {
//            print("Error decoding item array, \(error)")
//        }
//    }
//}
