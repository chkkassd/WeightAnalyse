//
//  CoreDataTableViewController.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/10/19.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//  在standford资料基础上，兼容swift3

import Foundation
import UIKit
import CoreData


class CoreDataTableViewController : UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - Instance variables
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            do {
                if let frc = fetchedResultsController {
                    frc.delegate = self
                    try frc.performFetch()
                }
                tableView.reloadData()
            } catch let error {
                print("NSFetchedResultController perfromFetch() failed:\(error.localizedDescription)")
            }
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController?.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections , sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController?.sections , sections.count > 0 {
            return sections[section].name
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return fetchedResultsController?.section(forSectionIndexTitle: title, at: index) ?? 0
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController?.sectionIndexTitles
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections(IndexSet(integer:sectionIndex), with:.fade)
        case .delete:
            self.tableView.deleteSections(IndexSet(integer:sectionIndex), with:.fade)
        default: break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: UITableViewRowAnimation.fade)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.fade)
        case .update:
            self.tableView.reloadRows(at: [indexPath!], with: UITableViewRowAnimation.fade)
        case .move:
            self.tableView.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.fade)
            self.tableView.insertRows(at: [newIndexPath!], with: UITableViewRowAnimation.fade)
        }
    }
}
