//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Roy Li on 8/8/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var cateArray = [Category]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCates()
    }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cateArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = cateArray[indexPath.row].name
   
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = cateArray[indexPath.row]
        }
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCates() {
        do{
            try context.save()
        }
        catch{
            print("Error Encoding here!\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCates(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do{
            cateArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
    }
    
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoEy Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // What will happen once the user clicks the add item button on our UIAlert
            
            let newCate = Category(context: self.context)
            newCate.name = textField.text!
            self.cateArray.append(newCate)
            
            self.saveCates()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert,animated: true, completion: nil)
    }
    
    
    
    
    
}
