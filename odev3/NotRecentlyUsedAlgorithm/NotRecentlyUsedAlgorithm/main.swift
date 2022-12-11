//
//  main.swift
//  NotRecentlyUsedAlgorithm
//
//  Created by User on 10/12/22.
//

import Foundation

func createMemory(){  // completing memory with empty pages
    for _ in  0...sizeRAM-1{
        let tempPage = [Int]()
        RAM.append(tempPage)
    }
    
    for _ in  0...sizeHDD-1{
        let tempPage = [Int]()
        HDD.append(tempPage)
    }
}


func checkMemory(_ memory: [[Int]]) -> (number: Int,emptyIndex: [Int]){ // checking memory, is there empty place?..
    var number = 0
    var emptyIndex = [Int]()
    for i in 0...memory.count - 1{
        if memory[i].isEmpty{
            number += 1
            emptyIndex.append(i)
        }
    }
   
    return (number, emptyIndex)
}

func main(){
    while control {
        print("\n\n________________________________________________________________________")
        print("MENU:")
        print("1 - Жаңы барак кошуу")
        print("2 - Баракка кайрылуу жасоо")
        print("3 - Барактагы маалыматты өзгөртүү")
        print("4 - Баракты жок кылуу")
        print("5 - Баардык барактардын \"Referenced\" жана \"Modified\" биттеринин маанисин 0 кылуу")
        print("6 - Эстин учурдагы абалын көрсөтүү")
        print("0 - exit")
        
        
        print("Please enter number: ")
        let num = Int(readLine()!) ?? 7
        
        switch num{
        case 1:
            let hdd = checkMemory(HDD)
            let hddCount = hdd.number
            let hddEmptyMemoryIndex = hdd.emptyIndex
            
            let ram = checkMemory(RAM)
            let ramCount = ram.number
            let ramEmptyMemoryIndex = ram.emptyIndex
            
            
            if hddCount == 0 && ramCount == 0{
                print("Es tolup kaldy...")
            }else{
                if ramCount == 0{
                    print("RAM toldu")
                }else{
                    //RAM
                    pageID += 1
                    RAM[ramEmptyMemoryIndex.first!].append(pageID) //page id
                    RAM[ramEmptyMemoryIndex.first!].append(ramEmptyMemoryIndex.first!) //page number for RAM
                    
                    print("\npage added succesfully!")
                }
            }
        case 2:
            print("two")
        case 3:
            print("three")
        case 4:
            print("four")
        case 5:
            print("five")
        case 6:
            let ram = checkMemory(RAM)
            let countPages = sizeRAM - ram.number
            print("\nRAM:\n")
            print("Page ID\t\t| Page Number")
            print("-------------------------")
            for i in 0...countPages-1{
                print("\t \(RAM[i][0])\t\t| \t\(RAM[i][1])")
            }
            
        case 0:
            control = false
        default:
            print("\nYour input is incorrect!!!")
        }
    }
}



var RAM = [[Int]]()
var HDD = [[Int]]()
var tableOfPages = [[Int]]()
let sizeRAM = 10
let sizeHDD = 20
var control = true
var pageID = 0
var pageNumberRAM = 0
var pageNumberHDD = -1


createMemory()
main()
