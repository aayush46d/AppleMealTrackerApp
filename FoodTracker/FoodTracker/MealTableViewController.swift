//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Developer on 5/10/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    // MARK: Properties
    var meals = [Meal]()
    
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let loadedMeals = loadMeals() {
            meals += loadedMeals
        }
        else{
        loadSampleData()
        }
            // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell
            else{
                fatalError("Downcasting fail, type mismatch")
        }

        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "Add Item":
            os_log("Items added", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController
                else{
                    fatalError("Unknown destination")
            }
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("sender error")
            }
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("cell position error")
            }
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
        default:
            print("segue :"+segue.identifier!)
            fatalError("segue identifier error")
        }
        
        
    }
    
    func tempFunc () {
        let temp = TempViewController(nibName: "TempViewController", bundle: nil)
        present(temp, animated: true, completion: nil)
        self.navigationController?.pushViewController(temp, animated: true)
    }
    
    // MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal{
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: UITableViewRowAnimation.fade)
            }
            else{
                
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: UITableViewRowAnimation.left)
            }
            saveData()
        }
        
    }
    
    // MARK: Private Methods
    
    private func loadSampleData(){
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal.init(name: "Chill Chicken", photo: photo1, rating: 4)
        else{
            fatalError("Meal 1 initalization failed")
        }
        guard let meal2 = Meal.init(name: "Chilli Paneer", photo: photo2, rating: 1) else {
            fatalError("Meal 2 initalization failed")
        }
        guard let meal3 = Meal.init(name: "Chilli Potato", photo: photo3, rating: 3) else {
            fatalError("Meal three init failed")
        }
        meals += [meal1, meal2, meal3]
        
    }
    
    private func saveData(){
    let saveSuccess = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchieveURL.path)
        if saveSuccess {
            os_log("Data Saved!!", log: OSLog.default, type: .debug)
        }else{
            os_log("Error is saving data!", log: OSLog.default, type: .debug)
        }
    }
    
    private func loadMeals() -> [Meal]?{
    return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchieveURL.path) as? [Meal]
    }
    
}
