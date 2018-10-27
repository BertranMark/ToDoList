//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Bertran on 25.10.2018.
//  Copyright © 2018 Bertran. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    @IBOutlet weak var isCompleteBut: UIButton!
    
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var dueDateLab: UILabel!
    
    
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveButOutlet: UIBarButtonItem!
    
    var t : ToDo?
    
    var isPickerHidden = true {
        didSet {
            dueDatePicker.isHidden = isPickerHidden
        }
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    
    func updateDueDateLabel(date: Date) {
        dueDateLab.text = ToDo.DueDateFormatte.string(from: date)
    }
    
    @IBAction func isCompButTapped(_ sender: UIButton) {
        isCompleteBut.isSelected = !isCompleteBut.isSelected
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch indexPath {
        case [0, 1]:
            isPickerHidden = !isPickerHidden
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.beginUpdates()
            tableView.endUpdates()
            view.endEditing(true)
        default: break
            
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let normalCell = CGFloat(44)
        let largeCellHeaight = CGFloat(156)
        
        switch indexPath {
        case [0, 2]:
            return isPickerHidden ? 0 : largeCellHeaight
        case [1, 0]:
            return largeCellHeaight
        
        default:
            return normalCell
        }
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDatePicker.minimumDate = Date()
        dueDatePicker.date = Date().addingTimeInterval(24 * 60 * 60)
        updateSaveButtonState()
        updateDueDateLabel(date: dueDatePicker.date)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func updateSaveButtonState (){
        
        let text = textField.text ?? ""
        saveButOutlet.isEnabled = !text.isEmpty
        
    }
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    @IBAction func returnPressed(_ sender: Any) {
        
        textField.resignFirstResponder()
    }
    
    @IBAction func textEditingCHanged(_ sender: Any) {
        updateSaveButtonState()
        
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       guard segue.identifier == "SaveUnwind" else { return }
        let title = textField.text ?? ""
        let isComplete = isCompleteBut.isSelected
        let dueDate = dueDatePicker.date
        let notes = notesTextView.text
        // t =  развернуть инициализатор и закончить
        // записать в постоянную память
        self.t = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, note: notes)
    print(t)
    }
  

}
