//
//  main.swift
//  osPractice
//
//  Created by User on 17/11/22.
//

import Foundation

extension Array where Element: Equatable {
  func allIndices(of value: Element) -> [Index] {
    indices.filter { self[$0] == value }
  }
}

var  control: Bool = true
var memoryState = [Int]()
let memorySize = 256

var processStartingIndexDict = [String: Int]()
var processSizeDict = [String: Int]()

for _ in 1...memorySize{
    memoryState.append(0)
}

print("First Fit algorithm by bitmap method")
while control{
    print("\n\n________________________________________________________________________")
    print("MENU:")
    print("1 - add new process")
    print("2 - terminating the process")
    print("3 - state of memory at this moment")
    print("0 - exit")
    
    
    print("Please enter number: ")
    let num = Int(readLine()!)!
    
    switch num {
    case 1:
        print("\nAdding new process")
        print("\n\nPlease enter process name:  ")
        let processName = String(readLine()!)
        print("Please enter size of process: ")
        let processSize = Int(readLine()!)!
        
        if processStartingIndexDict[processName] != nil {
            print("Enter another process name. Because there is like this process in the memory...")
        }else{
            if processSize > memorySize{
                print("Process size is outof size memory!")
            }else{
                let allEmptyAddressIndex = memoryState.allIndices(of: 0)
                var emptyAddressIndex = [Int]()
                let rangePointer = memorySize - processSize
                
                for i in allEmptyAddressIndex{
                    if i <= rangePointer{
                        emptyAddressIndex.append(i)
                    }
                }
                
                for i in emptyAddressIndex{
                    var counter = 0
                    for j in i...i+processSize-1{
                        if memoryState[j] == 0{
                            counter += 1
                        }
                    }
                    if counter == processSize{
                        for j in i...i+processSize-1{
                            memoryState[j] = 1
                        }
                        processSizeDict[processName] = processSize
                        processStartingIndexDict[processName] = i
                        break
                    }
                }
                
                if !processSizeDict.contains(where: { $0.key == processName}){
                    print("Our empty memory is \(allEmptyAddressIndex.count)")
                    print("But we can't save your process!!!")
                }

            }
        }
    case 2:
        print("\nTerminating the process")
        
        print("\n\nPlease enter process name:  ")
        let processName = String(readLine()!)
        
        if processStartingIndexDict.count == 0{
            print("There are nothing processes.")
        }else if processStartingIndexDict[processName] == nil{
            print("Unfortunately, there is not like this process!")
        }else{
            for i in processStartingIndexDict[processName]!...processStartingIndexDict[processName]!+processSizeDict[processName]! - 1{
                memoryState[i] = 0
            }
            processSizeDict[processName] = nil
            processStartingIndexDict[processName] = nil
            
            print("Process \(processName) terminated succesfully!")
        }
        
    case 3:
        var memoryBitMap = [[Int]]()
        
        if memoryState.contains(1){
            print("\nState of memory in this moment")
            
            for i in stride(from: 0, to: memorySize, by: 16){
                var temp = [Int]()
                for j in i...i+16-1{
                    temp.append(memoryState[j])
                }
                memoryBitMap.append(temp)
            }
            
            for i in memoryBitMap{
                print(i)
            }
            
            print("processes and starting index: \(processStartingIndexDict)")
            print("processes and size: \(processSizeDict)")
        }else{
            print("\nThere are nothing processes.")
        }
        
    case 0:
        print("\nThe program terminated!!!")
        control = false
    default:
        print("\nYour input incorrect!!!")
    }
}
