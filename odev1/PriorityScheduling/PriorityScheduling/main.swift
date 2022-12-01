//
//  main.swift
//  PriorityScheduling
//
//  Created by User on 1/12/22.
//

import Foundation

var allProcess = [[Int]]() //procces = [idProcess, priorityValue]
var id = 0

var control = true
while control{
    print("\n\n________________________________________________________________________")
    print("MENU:")
    print("1 - add new process")
    print("2 - show all process")
    print("3 - showing all process after scheduling")
    print("0 - exit")
    
    
    print("Please enter number: ")
    let num = Int(readLine()!)!
    
    switch num {
    case 1:
        var newProcess = [Int]()
        id += 1
        newProcess.append(id) // id of process
        newProcess.append(Int.random(in: 1...4)) //priority of process
        allProcess.append(newProcess)
        print("\nProcess added succesfully...")
        
    case 2:
        print("\nshow all process")
        
        if allProcess.count == 0{
            print("There is not any processes!")
        }else{
            print("\nAll process:\n")
            print("| Process ID\t| Priority\t")
            print("|--------------------------")
            for process in allProcess{
                print("|\t\t \(process[0])\t\t| \t\(process[1])\t")
            }
        }
        
        
    case 3:
        print("show all process after scheduling")
        let sortedProcessByPriority = allProcess.sorted(by: {$0[1] < $1[1] })
        print("\nAfter Scheduling:\n")
        print("| Process ID\t| Priority\t")
        print("|--------------------------")
        for process in sortedProcessByPriority{
            print("|\t\t \(process[0])\t\t| \t\(process[1])\t")
        }
        
    case 0:
        print("\nThe program terminated!!!")
        control = false
    default:
        print("\nYour input incorrect!!!")
    }
}
