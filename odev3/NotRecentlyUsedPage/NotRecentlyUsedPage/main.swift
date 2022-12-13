//
//  main.swift
//  NotRecentlyUsedPage
//
//  Created by User on 12/12/22.
//

import Foundation

class Page{
    var pageId = 0
    var pageNumber = 0
}

class PageTable: Page{
    var pageLocation = 0
    var referenced = 0
    var modified = 0
}

func addToPageTable(_ page: Page, _ pageLocation: Int){
    
    let pageTableObj = PageTable()
    pageTableObj.pageId = page.pageId
    pageTableObj.pageNumber = page.pageNumber
    pageTableObj.pageLocation = pageLocation
    pageTableObj.referenced = 0
    pageTableObj.modified = 0
    
    pageTables.append(pageTableObj)

}

func completePageTable(_ ram: [Page], _ hdd: [Page]) -> [PageTable]{
    var pageTable = [PageTable]()
    
    if ram.count > 0{
        for page in ram{
            let pageTableObj = PageTable()
            pageTableObj.pageId = page.pageId
            pageTableObj.pageNumber = page.pageNumber
            pageTableObj.pageLocation = 1
            pageTableObj.referenced = 0
            pageTableObj.modified = 0
            
            pageTable.append(pageTableObj)
        }
    }
    
    if hdd.count > 0{
        for page in hdd{
            let pageTableObj = PageTable()
            pageTableObj.pageId = page.pageId
            pageTableObj.pageNumber = page.pageNumber
            pageTableObj.pageLocation = 0
            pageTableObj.referenced = 0
            pageTableObj.modified = 0
            
            pageTable.append(pageTableObj)
        }
    }
    return pageTable
}

func deletePage(_ pageId: Int){
    for page in pageTables{
        if page.pageId == pageId{
            if page.pageLocation == 1{
                var pageIndex = 0
                
                for i in 0...RAM.count-1{
                    if RAM[i].pageId == page.pageId && RAM[i].pageNumber == page.pageNumber{
                        pageIndex = i
                        break
                    }
                }
                RAM.remove(at: pageIndex)
            }else if page.pageLocation == 0{
                var pageIndex = 0
                for i in 0...HDD.count-1{
                    if HDD[i].pageId == page.pageId && HDD[i].pageNumber == page.pageNumber{
                        pageIndex = i
                        break
                    }
                }
                HDD.remove(at: pageIndex)
            }
        }
    }
}

func notRecentlyUsedPage(_ ram: [Page]) -> [Page]{
    var tempRAM = ram
    var notReferencedNotModified = [Page]()
    var notReferencedModified = [Page]()
    var referencedNotModified = [Page]()
    var referencedModified = [Page]()
    
    
    for ramPage in ram{ // RAM'degi barakchalardy 4 gruppaga ajyratuu
        for page in pageTables{
            if ramPage.pageId == page.pageId{
                if page.referenced == 0 && page.modified == 0{
                    notReferencedNotModified.append(ramPage)
                } else if page.referenced == 0 && page.modified == 1{
                    notReferencedModified.append(ramPage)
                } else if page.referenced == 1 && page.modified == 0{
                    referencedNotModified.append(ramPage)
                } else if page.referenced == 1 && page.modified == 1{
                    referencedModified.append(ramPage)
                }
            }
        }
    }
//    print(notReferencedNotModified)
//    print(notReferencedModified)
//    print(referencedNotModified)
//    print(referencedModified)
    
    if notReferencedNotModified.count > 0{ //not referenced, not modified
        let objPage = Page()
        objPage.pageId = notReferencedNotModified[0].pageId
        objPage.pageNumber = HDD.count
        
        HDD.append(objPage)
        
        var pageIndex = 0
        for i in 0...ram.count-1{
            if ram[i].pageId == notReferencedNotModified[0].pageId && ram[i].pageNumber == notReferencedNotModified[0].pageNumber{
                pageIndex = i
                
                break
            }
        }
        
        for page in pageTables{
            if notReferencedNotModified[0].pageId == page.pageId{
                page.pageLocation = 0
            }
        }
        tempRAM.remove(at: pageIndex)
            
    }else if notReferencedModified.count > 0{ //not Referenced, modified
        let objPage = Page()
        objPage.pageId = notReferencedModified[0].pageId
        objPage.pageNumber = HDD.count
        
        HDD.append(objPage)
        
        var pageIndex = 0
        for i in 0...ram.count-1{
            if ram[i].pageId == notReferencedModified[0].pageId && ram[i].pageNumber == notReferencedModified[0].pageNumber{
                pageIndex = i
                
                break
            }
        }
        
        for page in pageTables{
            if notReferencedModified[0].pageId == page.pageId{
                page.pageLocation = 0
            }
        }
        tempRAM.remove(at: pageIndex)
    }else if referencedNotModified.count > 0{ //referenced, not modified
        let objPage = Page()
        objPage.pageId = referencedNotModified[0].pageId
        objPage.pageNumber = HDD.count
        
        HDD.append(objPage)
        
        var pageIndex = 0
        for i in 0...ram.count-1{
            if ram[i].pageId == referencedNotModified[0].pageId && ram[i].pageNumber == referencedNotModified[0].pageNumber{
                pageIndex = i
                
                break
            }
        }
        
        for page in pageTables{
            if referencedNotModified[0].pageId == page.pageId{
                page.pageLocation = 0
            }
        }
        tempRAM.remove(at: pageIndex)
    }else if referencedModified.count > 0{ //referenced, modified
        let objPage = Page()
        objPage.pageId = referencedModified[0].pageId
        objPage.pageNumber = HDD.count
        
        HDD.append(objPage)
        
        var pageIndex = 0
        for i in 0...ram.count-1{
            if ram[i].pageId == referencedModified[0].pageId && ram[i].pageNumber == referencedModified[0].pageNumber{
                pageIndex = i
                
                break
            }
        }
        
        for page in pageTables{
            if referencedModified[0].pageId == page.pageId{
                page.pageLocation = 0
            }
        }
        tempRAM.remove(at: pageIndex)
    }
    
    return tempRAM
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
            if RAM.count == sizeRAM && HDD.count == sizeHDD{
                print("\n\nEs tolup kaldy.")
            }else{
                let pageObj = Page()
                if RAM.count < sizeRAM{ // RAM tolup kalgan bolso, kereksiz bir barakty hdd'ge jiberip boshogon mestaga jany barakty jaygashtyruu
                    var emptyPageNumber = 0
                    if RAM.count > 0{
                        var ramPagesIndex = [Int]()
                        for page in RAM{
                            ramPagesIndex.append(page.pageNumber)
                        }
                        
                        for i in 0...sizeRAM-1{
                            if !ramPagesIndex.contains(i){
                                emptyPageNumber = i
                                break
                            }
                        }
                    }
                    pageID += 1
                    pageObj.pageId = pageID
                    pageObj.pageNumber = emptyPageNumber
                    RAM.append(pageObj)
                    
                    print("\npage added succesfully!")
                                        
                }else{ // RAM bosh bolso jany barakty jaygashtyruu
                    print("RAM toldu")
                    RAM = notRecentlyUsedPage(RAM)
                    
                    var emptyPageNumber = 0
                    if RAM.count > 0{
                        var ramPagesIndex = [Int]()
                        for page in RAM{
                            ramPagesIndex.append(page.pageNumber)
                        }
                        
                        for i in 0...sizeRAM-1{
                            if !ramPagesIndex.contains(i){
                                emptyPageNumber = i
                                break
                            }
                        }
                    }
                    pageID += 1
                    pageObj.pageId = pageID
                    pageObj.pageNumber = emptyPageNumber
                    RAM.append(pageObj)
                    print("\npage added succesfully!")
                }
                
                var allIdRAM = [Int]()
                for i in RAM{
                    allIdRAM.append(i.pageId)
                }
                
                if allIdRAM.contains(pageObj.pageId){ // Jany koshulgan barak RAM'de je HDD'de jaygashkanyna karap baraktar jadybalyna koshuu
                    addToPageTable(pageObj, 1) //1-RAM'ge jaygashkashkan
                }else{
                    addToPageTable(pageObj, 0) //0-HDD'ge jaygashkan
                }
            }
        case 2:
            print("Enter the pageID: ")
            let pageId = Int(readLine()!) ?? -1
                        
            var allPageId = [Int]()
            for page in pageTables{
                allPageId.append(page.pageId)
            }
            
            if pageId > 0{
                if allPageId.contains(pageId){
                    var allPageIdRAM = [Int]()
                    
                    for page in RAM{
                        allPageIdRAM.append(page.pageId)
                    }
                    if allPageIdRAM.contains(pageId){ // RAM'de jaygashkan barakka kairyluu kerek bolso
                        for page in pageTables{
                            if page.pageId == pageId{
                                page.referenced = 1
                                break
                            }
                        }
                        print("\n to \(pageId) - page referenced succesfully!")
                    }else{ // HDD'degi barakka kairyluu kerek bolso, algach fizikalyk eske tashylyp kelet. andan son kairylsak bolot
                        var objPage = Page()
                        for page in HDD{
                            if pageId == page.pageId{
                                objPage = page
                            }
                        }
                        
                        var pageIndex = 0
                        for i in 0...HDD.count-1{
                            if HDD[i].pageId == pageId{
                                pageIndex = i
                                break
                            }
                        }
                        HDD.remove(at: pageIndex)
                        
                        RAM = notRecentlyUsedPage(RAM)
                        var emptyPageNumber = 0
                        if RAM.count > 0{
                            var ramPagesIndex = [Int]()
                            for page in RAM{
                                ramPagesIndex.append(page.pageNumber)
                            }
                            
                            for i in 0...sizeRAM-1{
                                if !ramPagesIndex.contains(i){
                                    emptyPageNumber = i
                                    break
                                }
                            }
                        }
                        
                        objPage.pageNumber = emptyPageNumber
                        RAM.append(objPage)
                        
                        for page in pageTables{
                            if page.pageId == pageId{
                                page.pageLocation = 1
                                page.referenced = 1
                                break
                            }
                        }
                        print("\n\(pageId) - page referenced succesfully!")
                    }
                }else{
                    print("\nThere is not like this page!!!")
                }
            }else{
                print("\nYour input is incorrect!!!")
            }
        case 3:
            print("Enter the pageID: ")
            let pageId = Int(readLine()!) ?? -1
                        
            var allPageId = [Int]()
            for page in pageTables{
                allPageId.append(page.pageId)
            }
            
            if pageId > 0{
                if allPageId.contains(pageId){
                    var allPageIdRAM = [Int]()
                    
                    for page in RAM{
                        allPageIdRAM.append(page.pageId)
                    }
                    if allPageIdRAM.contains(pageId){ // RAM'de jaygashkan barakty ozgortuu kerek bolso
                        for page in pageTables{
                            if page.pageId == pageId{
                                page.modified = 1
                                break
                            }
                        }
                        print("\n\(pageId) - page modified succesfully!")
                    }else{ // HDD'degi barakty ozgortuu kerek bolso, algach fizikalyk eske tashylyp kelet. andan son ozgortulot
                        var objPage = Page()
                        for page in HDD{
                            if pageId == page.pageId{
                                objPage = page
                            }
                        }
                        
                        var pageIndex = 0
                        for i in 0...HDD.count-1{
                            if HDD[i].pageId == pageId{
                                pageIndex = i
                                break
                            }
                        }
                        HDD.remove(at: pageIndex)
                        
                        RAM = notRecentlyUsedPage(RAM)
                        var emptyPageNumber = 0
                        if RAM.count > 0{
                            var ramPagesIndex = [Int]()
                            for page in RAM{
                                ramPagesIndex.append(page.pageNumber)
                            }
                            
                            for i in 0...sizeRAM-1{
                                if !ramPagesIndex.contains(i){
                                    emptyPageNumber = i
                                    break
                                }
                            }
                        }
                        
                        objPage.pageNumber = emptyPageNumber
                        RAM.append(objPage)
                        
                        for page in pageTables{
                            if page.pageId == pageId{
                                page.pageLocation = 1
                                page.modified = 1
                                break
                            }
                        }
                        print("\n\(pageId) - page modified succesfully!")
                    }
                }else{
                    print("\nThere is not like this page!!!")
                }
            }else{
                print("\nYour input is incorrect!!!")
            }
            
        case 4:
            print("Enter the pageID: ")
            let pageId = Int(readLine()!) ?? -1
                        
            var allPageId = [Int]()
            for page in pageTables{
                allPageId.append(page.pageId)
            }
            
            if pageId > 0{
                if allPageId.contains(pageId){
                    deletePage(pageId)
                    pageTables = completePageTable(RAM, HDD)
                    print("\n\(pageId) - page deleted succesfully!")
                }else{
                    print("\nThere is not like this page!!!")
                }
            }else{
                print("\nYour input is incorrect!!!")
            }
            
        case 5:
            print("\nБаардык барактардын \"Referenced\" жана \"Modified\" биттеринин маанисин 0 кылуу")
            pageTables = completePageTable(RAM, HDD)
        case 6:
            if RAM.count > 0{
                print("\nRAM:\n")
                print("Page ID\t\t| Page Number")
                print("-------------------------")
                for page in RAM{
                    print("\t \(page.pageId)\t\t| \t\(page.pageNumber)")
                }
            } else{
                print("RAM bosh")
            }
            
            if HDD.count > 0{
                print("\nHDD:\n")
                print("Page ID\t\t| Page Number")
                print("-------------------------")
                for page in HDD{
                    print("\t \(page.pageId)\t\t| \t\(page.pageNumber)")
                }
            } else{
                print("\n\nHDD bosh")
            }
            
            if pageTables.count > 0{
                print("\n\nPage Tables:\n")
                print("Page Location:  1 - RAM\n\t\t\t\t0 - HDD\n")

                print("Page ID\t\t| Page Number\t| Page Location\t| Referenced\t| Modified")
                print("-----------------------------------------------------------------------")
                for page in pageTables{
                    print("\t \(page.pageId)\t\t| \t\t\(page.pageNumber)\t\t| \t\t\(page.pageLocation)\t\t| \t\t\(page.referenced)\t\t| \t\(page.modified)")
                }
            }else{
                print("Page Table bosh")
            }
            
        case 0:
            control = false
        default:
            print("\nYour input is incorrect!!!")
        }
    }
}

var RAM = [Page]()
var HDD = [Page]()
var pageTables = [PageTable]() // pageId, pageNumber, pageLocation, referenced, modified,
let sizeRAM = 10
let sizeHDD = 20
var control = true
var pageID = 0

main()
