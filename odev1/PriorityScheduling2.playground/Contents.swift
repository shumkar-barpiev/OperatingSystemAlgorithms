import Cocoa

print("This program for preemtive priority scheduling algorithm (high number is high priority)")


var allProcesses = [[Int]]() //procces = [indextOfProcess, arrivialTime, priorityValue, burstTime]
let processNumber = 5
let runningTime = 10

//completing process values
func setProcessValue(_ allProcess: [[Int]]) -> [[Int]]{
    var processes = allProcess
    
    for i in 0...allProcess.count-1{
        processes[i].append(Int.random(in: 0 ..< 5))  //arrivialTime
        processes[i].append(Int.random(in: 0 ..< 100))  //priorityValue
        processes[i].append(Int.random(in: 5 ..< 25))  //burstTime
    }
    return processes
}

//implementing scheduling algorithm
func priorityScheduling(_ allProces: [[Int]]) -> [[Int]]{
    let tempAllProcess = allProces
    var schedulingProcess = [[Int]]()
    var distinctArrivalTime = [Int]()
    
    
    for i in tempAllProcess{
        if distinctArrivalTime.contains(i[1]){
            continue
        }else{
            distinctArrivalTime.append(i[1])
        }
    }
    
    for i in distinctArrivalTime{
        var tempArr = [[Int]]()
        for j in tempAllProcess{ // birdey ubakytta kelip kalgan prosessterdi anyktoo
            if i == j[1]{
                tempArr.append(j)
            }
        }
        
        if tempArr.count == 1{
            schedulingProcess.append(tempArr[0])
        }else{
            let sortedProcessByPriority = tempArr.sorted(by: {$0[2] > $1[2] }) //egerde birdey ubakytta kelgen bir neche process bolso priority'si boyuncha sorttoo
            for i in sortedProcessByPriority{
                schedulingProcess.append(i)
            }
        }
    }
    
    let sortedSchedulingProcessByArrivalTime = schedulingProcess.sorted(by: {$0[1] < $1[1] })
    
    return sortedSchedulingProcessByArrivalTime
}


//implementing working State
func workingState(_ allProces: [[Int]]) -> [[Int]]{
    let tempAllProcess = allProces
    var schedulingProcess = [[Int]]()
    var distinctArrivalTime = [Int]()
    
    
    for i in tempAllProcess{
        if distinctArrivalTime.contains(i[1]){
            continue
        }else{
            distinctArrivalTime.append(i[1])
        }
    }
    
    for i in distinctArrivalTime{
        var tempArr = [[Int]]()
        for j in tempAllProcess{ // birdey ubakytta kelip kalgan prosessterdi anyktoo
            if i == j[1]{
                tempArr.append(j)
            }
        }
        
        if tempArr.count == 1{
            schedulingProcess.append(tempArr[0])
        }else{
            let sortedProcessByPriority = tempArr.sorted(by: {$0[2] > $1[2] }) //egerde birdey ubakytta kelgen bir neche process bolso priority'si boyuncha sorttoo
            for i in sortedProcessByPriority{
                schedulingProcess.append(i)
            }
        }
    }
    
    let sortedSchedulingProcessByArrivalTime = schedulingProcess.sorted(by: {$0[1] < $1[1] })
    
    var resultArr = [[Int]]()
    var tempResultArr1 = sortedSchedulingProcessByArrivalTime
   
    var tempBoolean = true
    while tempBoolean {
        var tempResultArr2 = [[Int]]()
        
        for i in 0...tempResultArr1.count-1{
            if tempResultArr1[i][3] > runningTime{
                tempResultArr1[i][3] = tempResultArr1[i][3]-runningTime
                tempResultArr2.append(tempResultArr1[i])
                tempResultArr1[i][3] = runningTime
            }
        }
        
        for i in tempResultArr1{
            resultArr.append(i)
        }
        
        tempResultArr1 = tempResultArr2
        
        
        if tempResultArr2.count == 0{
            tempBoolean = false
        }
    }
    
    
    return resultArr
}


for indexP in 1...processNumber{
    var tempProcess = [Int]()
    tempProcess.append(indexP)
    
    allProcesses.append(tempProcess)
}

allProcesses = setProcessValue(allProcesses)
print("\nAll process:\n")
print("Process ID\t\t| Arrival Time\t| Priority\t| Burst Time\t")
print("----------------------------------------------------------")
for process in allProcesses{
    print("\t \(process[0])\t\t\t| \t\(process[1])\t\t\t|\t \(process[2])\t\t|\t \(process[3])\t")
}




let afterScheduling = priorityScheduling(allProcesses) //procces = [indextOfProcess, arrivialTime, priorityValue, burstTime, waitingTime]
print("\n\nAfter scheduling :\n")
print("Process ID\t\t| Arrival Time\t| Priority\t| Burst Time")
print("--------------------------------------------------------")
for process in afterScheduling{
    print("\t \(process[0])\t\t\t| \t\(process[1])\t\t\t|\t \(process[2])\t\t|\t \(process[3])\t\t")
}



let workingProcess = workingState(allProcesses) //procces = [indextOfProcess, arrivialTime, priorityValue, burstTime, waitingTime]
print("\n\nAfter working :\n")
print("Process ID\t\t| Arrival Time\t| Priority\t| Burst Time")
print("--------------------------------------------------------")
for process in workingProcess{
    print("\t \(process[0])\t\t\t| \t\(process[1])\t\t\t|\t \(process[2])\t\t|\t \(process[3])\t\t")
}
