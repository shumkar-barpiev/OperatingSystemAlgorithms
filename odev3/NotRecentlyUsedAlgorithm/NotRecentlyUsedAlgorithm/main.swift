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

func completePageTable(_ ram: [[Int]], _ hdd: [[Int]]){
    let r = checkMemory(ram)
    let h = checkMemory(hdd)
    
    let ramPageCount = ram.count - r.number
    let hddPageCount = hdd.count - h.number
    
    if ramPageCount > 0{
        if pageTables.count == 0{ // egerde page Table bosh bolso barak bar je jok ekendigin tekshebey ele kosho berebiz
            for i in 0...ramPageCount-1{
                var tempPage = [Int]()
                tempPage.append(ram[i][0]) // pageID
                tempPage.append(ram[i][1]) // pageNumber
                tempPage.append(1) // pageLocation 1 - RAM, 0 - HDD
                tempPage.append(0) // referenced
                tempPage.append(0) //modified
                pageTables.append(tempPage)
            }
        } else{ //al emi page table bosh emes bolso ram'degi baraktar murda saktalganby jokpu oshonu teksheruu kerek
            var indexesPageTables = [Int]()
            for i in pageTables{
                indexesPageTables.append(i[0])
            }
            
            for i in 0...ramPageCount-1{
                if indexesPageTables.contains(ram[i][0]){
                    continue
                }else{
                    var tempPage = [Int]()
                    tempPage.append(ram[i][0]) // pageID
                    tempPage.append(ram[i][1]) // pageNumber
                    tempPage.append(1) // pageLocation 1 - RAM, 0 - HDD
                    tempPage.append(0) // referenced
                    tempPage.append(0) //modified
                    pageTables.append(tempPage)
                }
            }
            
        }
    }
    
    if hddPageCount > 0{
        if pageTables.count == 0{ // egerde page Table bosh bolso barak bar je jok ekendigin tekshebey ele kosho berebiz
            for i in 0...hddPageCount-1{
                var tempPage = [Int]()
                tempPage.append(hdd[i][0]) // pageID
                tempPage.append(hdd[i][1]) // pageNumber
                tempPage.append(0) // pageLocation 1 - RAM, 0 - HDD
                tempPage.append(0) // referenced
                tempPage.append(0) //modified
                pageTables.append(tempPage)
            }
        } else{
            var indexesPageTables = [Int]()
            for i in pageTables{
                indexesPageTables.append(i[0])
            }
            
            for i in 0...hddPageCount-1{
                if indexesPageTables.contains(hdd[i][0]){
                    continue
                }else{
                    var tempPage = [Int]()
                    tempPage.append(hdd[i][0]) // pageID
                    tempPage.append(hdd[i][1]) // pageNumber
                    tempPage.append(0) // pageLocation 1 - RAM, 0 - HDD
                    tempPage.append(0) // referenced
                    tempPage.append(0) //modified
                    pageTables.append(tempPage)
                }
            }
            
        }
        
    }
}

func notRecentlyUsedPage(_ ram: [[Int]]){
    var notReferencedNotModified = [[Int]]()
    var notReferencedModified = [[Int]]()
    var referencedNotModified = [[Int]]()
    var referencedModified = [[Int]]()
    
    
    for ramPage in ram{
        for page in pageTables{
            if ramPage[0] == page[0]{
                if page[3] == 0 && page[4] == 0{
                    notReferencedNotModified.append(ramPage)
                } else if page[3] == 0 && page[4] == 1{
                    notReferencedModified.append(ramPage)
                } else if page[3] == 1 && page[4] == 0{
                    referencedNotModified.append(ramPage)
                } else if page[3] == 1 && page[4] == 1{
                    referencedModified.append(ramPage)
                }
            }
        }
    }
    
    print(notReferencedNotModified)
    print(notReferencedModified)
    print(referencedNotModified)
    print(referencedModified)
    
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
                    notRecentlyUsedPage(RAM)
                }else{
                    //RAM
                    pageID += 1
                    RAM[ramEmptyMemoryIndex.first!].append(pageID) //page id
                    RAM[ramEmptyMemoryIndex.first!].append(ramEmptyMemoryIndex.first!) //page number for RAM
                    
                    print("\npage added succesfully!")
                }
            }
            
            completePageTable(RAM, HDD)
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
            
            
            print("\n\nPage Tables:\n")
            print("Page Location: \n1 - RAM\n0 - HDD\n")

            print("Page ID\t\t| Page Number\t| Page Location\t| Referenced\t| Modified")
            print("-----------------------------------------------------------------------")
            for i in 0...pageTables.count-1{
                print("\t \(pageTables[i][0])\t\t| \t\t\(pageTables[i][1])\t\t| \t\t\(pageTables[i][2])\t\t| \t\t\(pageTables[i][3])\t\t| \t\(pageTables[i][4])")
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
var pageTables = [[Int]]() // pageId, pageNumber, pageLocation, referenced, modified,
let sizeRAM = 10
let sizeHDD = 20
var control = true
var pageID = 0

createMemory()
main()
