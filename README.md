# Operating System code for finding page number:

virtualAddres = "10101100001100011011001101110011"
pageNumber = ""
mainSap = ""

for i in range(0, len(virtualAddres)):
    if i >= 11:
        mainSap += virtualAddres[i]
    else:
        pageNumber += virtualAddres[i]
        
print("page number: ", pageNumber)
print("main Sap: ", mainSap)
