//
//  main.swift
//  osPractice
//
//  Created by User on 17/11/22.
//

import Foundation

var  control: Bool = true

while control{
    print("\n\n")
    print("1 - add new process")
    print("2 - terminating the process")
    print("3 - state of memory in this moment")
    print("0 - exit")
    
    
    print("Please enter number ")
    let num = Int(readLine()!)!
    
    switch num {
    case 1:
        print("\nadding new process")
    case 2:
        print("\nterminating the process")
    case 3:
        print("\nstate of memory in this moment")
    case 0:
        print("\nterminated the program!!!")
        control = false
    default:
        print("\nYour input incorrect!!!")
    }
}
