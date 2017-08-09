//
//  ViewController.swift
//  EightQueens
//
//  Created by Hamzah Mugharbil on 8/9/17.
//  Copyright © 2017 Hamzah Mugharbil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var solutionsFound = 0
    var positionsChecked = 0
    var solution: String = ""
    
    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            textView.text = solution
        } else {
            textView.text = ""
        }
    }
    // create 8 queen objects initialized to rows 0 to 7
    let myQueens: [Queen] = [Queen(forRow: 0),
                             Queen(forRow: 1),
                             Queen(forRow: 2),
                             Queen(forRow: 3),
                             Queen(forRow: 4),
                             Queen(forRow: 5),
                             Queen(forRow: 6),
                             Queen(forRow: 7)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        moveQueenAcrossRow(0)
        solution += "Positions checked: \(positionsChecked)"
        
        
        
    }
    
    func isSafe(_ currentRow: Int,_ currentColumn: Int) -> Bool {
        positionsChecked += 1
        
        // iterate over all queens in previous rows
        for previousRow in 0..<currentRow {
            //CHECK VERTICAL: are we trying to place in the same column as any previously placed queen?
            if myQueens[previousRow].column == currentColumn {
                return false
            }
            
            // CHECK DIAGONAL: is the new queen diagonally reachable from any previous queen?
            let differenceInRows = currentRow - previousRow
            let differenceInColumns = currentColumn - myQueens[previousRow].column
            if (differenceInRows == differenceInColumns || differenceInRows == -differenceInColumns) {
                return false
            }
        }
        // it's safe - set the column of the current queen
        myQueens[currentRow].column = currentColumn
        return true
    }
    
    func moveQueenAcrossRow(_ row: Int) {
        for column in 0...7 {
            // move queen column by column, checking if it's safe
            if isSafe(row, column) {
                // if we just placed the eight queen safely, print the result
                if row == 7 {
                    solutionsFound += 1
                    printAnswer()
                }
                else {
                    // recursive call - now move the queen in the NEXT row
                    moveQueenAcrossRow(row+1)
                }
            }
        }
    }
    
    func printAnswer() {
        
        solution += "Solution number: \(solutionsFound)\n\n"
        
        // go backwards to print from top down
        for currentRow in stride(from: 7, through: 0, by: -1) {
            // print row number (use chess numbering)
            solution += "\(currentRow+1) "
            
            for currentColumn in 0...7 {
                if (myQueens[currentRow].column == currentColumn) {
                    solution += " ♛ "
                    
                } else {
                    solution += " X "
                }
            }
            solution += "\n"
        }
        
        solution += "    A  B  C  D  E  F  G  H  \n\n"
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

