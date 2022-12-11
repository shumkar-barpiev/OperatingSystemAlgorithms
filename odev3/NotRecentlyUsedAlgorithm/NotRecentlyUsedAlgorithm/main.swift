//
//  main.swift
//  NotRecentlyUsedAlgorithm
//
//  Created by User on 10/12/22.
//

import Foundation
var RAM = [[Int]]()
var HDD = [[Int]]()
let sizeRAM = 10
let sizeHDD = 20
var control = true

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
        print("one")
    case 2:
        print("two")
    case 3:
        print("three")
    case 4:
        print("four")
    case 5:
        print("five")
    case 6:
        print("six")
    case 0:
        control = false
    default:
        print("\nYour input is incorrect!!!")
    }
}
