//
//  SSFRecordTableViewController.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/10/17.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import UIKit
import CoreData

class SSFRecordTableViewController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBOutlet weak var recordTextField: UITextField!
    @IBOutlet weak var expectTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    
    private var managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    private func updateUI() {
        timeLabel.text = Date().standardTimeString
        recordTextField.text = RecordBrain().todayWeight != nil ? String(RecordBrain().todayWeight!) : ""
        expectTextField.text = RecordBrain().targetWeight == 0 ? "" : String(RecordBrain().targetWeight)
        
        let request: NSFetchRequest<Record> = Record.fetchRequest()
        request.predicate = NSPredicate(format: "recordUser.user_id = %d", (AccountBrain.sharedInstance.currentUser?.user_id)!)
        request.sortDescriptors = [NSSortDescriptor(key:"time", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest:request as! NSFetchRequest<NSFetchRequestResult>, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordTableViewCell", for: indexPath)
        
        if let weightRecord = fetchedResultsController?.object(at: indexPath) as? Record {
            var weightText,timeText: String?
            weightRecord.managedObjectContext?.performAndWait {
                weightText = "\(weightRecord.weight)kg"
                timeText = weightRecord.time
            }
            cell.textLabel?.text = weightText
            cell.detailTextLabel?.text = timeText
        }
        
        return cell
    }

}

extension SSFRecordTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == recordTextField {
            RecordBrain().record(todayWeight: Double(textField.text!)!, time: Date().standardTimeString)
        } else if textField == expectTextField {
            RecordBrain().record(targetWeight: Double(textField.text!)!, time: Date().standardTimeString)
        }
        textField.endEditing(true)
        return true
    }
}
