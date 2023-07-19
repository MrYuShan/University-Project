#Thean Yee Sin
#TP061278

def menu():     ##Ask user for the choose which function they want to use
    while True:
        operation=str(input("\t1.Parts Inventory Creation\n\t2.Parts Inventory Update\n\t3.Parts Inventory Tracking\n\t4.Searching\n\t5.Exit\nChoose the operation:"))

        if(operation=='1'): ##creating new inventory for a new part
            partsInventoryCreation()
            print("\n")
        elif(operation=='2'): ##changing the quantity of a part
            partsInventoryUpdate()
            print("\n")
        elif(operation=='3'): ##track the parts details
            partsInventoryTracking()
            print("\n")
        elif(operation=='4'): ##searching for particular information
            searching()
            print("\n")
        elif(operation=='5'): ##exit
            print("Have a good day :)")
            break
        else: ##just in case someone type a invalid entry
            tryAgain=str(input("Invalid Entry, continue(Yes/No)?:"))
            if(tryAgain.lower()=="yes"):
                continue
            elif(tryAgain.lower()=="no"):
                print("Have a good day :)")
                break
            else:
                print("Still Invalid Entry")
                break
                
def newPartsInventoryCreation(warehouse):    ##Ask for detail/information of the part, and if they want to repeat the process or not
    information = []
    while True:
        info = []
        partsID = []
        if(warehouse=='1'):
            fileHandler=open('WBS.txt','r')
        elif(warehouse=='2'):
            fileHandler=open('WAY.txt','r')
        elif(warehouse=='3'):
            fileHandler=open('WBR.txt','r')
        else:
            print("\n")
            return()
        partID=input("Enter the part ID:")
        for line in fileHandler:    ##check for same partID, if the partID already exist it will tell the user to use another PartID
            line = line.rstrip()
            newLine = line.split("\t")
            if newLine[0] not in partsID:
                partsID.append(newLine[0].lower())
        if(partID.lower()not in partsID):   ##Append the part details to a list
            info.append(partID.upper()) 
            partName=input("Enter the name of the part:")
            info.append(partName.upper())
            section=input("Enter the section it belongs to:")
            info.append(section.upper())
            quantity=input("Enter the quantity of the part:")
            info.append(quantity)
            supplierName=input("Enter the supplier of the part:")
            info.append(supplierName.upper())
            supplierID=input("Enter the supplier ID:")    
            info.append(supplierID.upper())
            information.append(info)
            fileHandler.close
            operation=input("\nDo you want to repeat process(Yes/No):") ##Ask the user if he/she want to repeat the inventory creation process or not
            if(operation.lower()=='yes'):
                print("\n")
                continue
            elif(operation.lower()=='no'):
                break
            else:
                print("Invalid Entry\n")
                break             
        else:
            print("This partID is already exist\n")
            continue
    return information
        
def partsInventoryCreation():   ##Ask for which warehouse and write all the detail of the part into the file
    warehouse=str(input("\t1.Bios warehouse\n\t2.Ambry warehouse\n\t3.Barrier warehouse\n\t4.Exit\nChoose the warehouse?:"))
    if(warehouse=='1'):
        fileHandler=open('WBS.txt','a')
    elif(warehouse=='2'):
        fileHandler=open('WAY.txt','a')
    elif(warehouse=='3'):
        fileHandler=open('WBR.txt','a')
    elif(warehouse=='4'):
        print('\n')
        return()
    else:
        print("Invalid Entry\n")
        return()
    information = newPartsInventoryCreation(warehouse)  ##call function to ask for details
    for info in information:
        for inf in info:
            fileHandler.write(inf)
            fileHandler.write('\t')
        fileHandler.write('\n')
    fileHandler.close
    
    return()

def partsInventoryUpdate():     ##Ask for which warehouse and the partID that the user want to update,either INCREASE or DECREASE the quantity
    warehouse=str(input("\t1.Bios warehouse\n\t2.Ambry warehouse\n\t3.Barrier warehouse\n\t4.Exit\nChoose the warehouse?:"))
    if(warehouse=='1'):
        fileHandler=open('WBS.txt','r')
    elif(warehouse=='2'):
        fileHandler=open('WAY.txt','r')
    elif(warehouse=='3'):
        fileHandler=open('WBR.txt','r')
    elif(warehouse=='4'):
        print("\n")
        return()
    else:
        print("Invalid Entry\n")
        return()
    searchPart = input("The partID:")
    newData=[]
    for line in fileHandler:
        line = line.rstrip()
        newLine = line.split("\t")        
        if(searchPart.lower() == newLine[0].lower()):
            operation=input("\t1.Increase\n\t2.Decrease\nChoose the operation update of the quantity:") ##ask for increase or decrease of the quantity
            if(operation=='1'): ##increase quantity
                newQuantity=int(input("How many:"))
                if(newQuantity>0):
                    newLine[3]=int(newLine[3])
                    newLine[3]= newLine[3]+newQuantity
                    newLine[3]=str(newLine[3])
                    print("Current quantity:",newLine[3])
                else:
                    print("Quantity not valid")
                    return()    
            elif(operation=='2'): ##decrease quantity
                print("Available quantity:",newLine[3])
                newQuantity=int(input("How many:"))
                if(newQuantity>0):
                    newLine[3]=int(newLine[3])
                    if(int(newLine[3])>=newQuantity):
                        newLine[3]= newLine[3]-newQuantity
                        newLine[3]=str(newLine[3])
                        print("Current quantity:",newLine[3])
                    else:
                        print("Not enough quantity\n")
                        return()
                else:
                    print("Quantity not valid\n")
                    return()
            else:
                print("Invalid Entry\n")
                return()
        newData.append(newLine)
    fileHandler.close()
    if(warehouse=='1'): ##overwrite the old data
        fHandler=open('WBS.txt','w')
    elif(warehouse=='2'):
        fHandler=open('WAY.txt','w')
    elif(warehouse=='3'):
        fHandler=open('WBR.txt','w')
    else:
        print("\n")
        return()
    for information in newData:
        for info in information:
            fHandler.write(info)
            fHandler.write('\t')
        fHandler.write('\n')    
    fHandler.close()
    return()

    

    
def partsInventoryTracking():   ##Ask for which warehouse. Then, keep track of the quantity of a part/ part quantity that are below than 10/ part and its quantity provided to a specific section in the warehouse
    warehouse=str(input("\t1.Bios warehouse\n\t2.Ambry warehouse\n\t3.Barrier warehouse\n\t4.Exit\nChoose the warehouse?:"))
    if(warehouse=='1'):
        fileHandler=open('WBS.txt','r')
    elif(warehouse=='2'):
        fileHandler=open('WAY.txt','r')
    elif(warehouse=='3'):
        fileHandler=open('WBR.txt','r')
    elif(warehouse=='4'):
        print("\n")
        return()
    else:
        print("Invalid Entry\n")
        return()
    operation=input("\t1.Parts' quantity\n\t2.Parts' quantity less than 10\n\t3.Parts and quantity provided to each section\nChoose the operation:")
    newSort=[]
    eachSection=[]
    if(operation=='1'): ##print the part quantity to user in a warehouse
        for line in fileHandler:
            newSort.append(line)
        newSort.sort()    
        for line in newSort:
            line.rstrip()
            newLine=line.split('\t')
            print(newLine[0],'\t',newLine[1],'\t',newLine[3])
    elif(operation=='2'): ##print the part quantity which is lesser than 10 to user in a warehouse
        for line in fileHandler:
            newSort.append(line)
        newSort.sort()    
        for line in newSort:
            line.rstrip()
            newLine=line.split('\t')
            newLine[3]=int(newLine[3])
            if(newLine[3]<10):
                print(newLine[0],'\t',newLine[1],'\t',newLine[3])
    elif(operation=='3'): ##print parts and quantity provided to each section in a warehouse
        for line in fileHandler:
            newSort.append(line)
        newSort.sort()    
        for line in newSort: ##to not repeat the section
            line.rstrip()
            newLine=line.split('\t')
            if newLine[2] not in eachSection:
                eachSection.append(newLine[2])
        fileHandler.close
       
        for section in eachSection: 
            if(warehouse=='1'):
                fHandler=open('WBS.txt','r')
            elif(warehouse=='2'):
                fHandler=open('WAY.txt','r')
            elif(warehouse=='3'):
                fHandler=open('WBR.txt','r')
            else:
                print('\n')
                return()
            totalQuantity=0
            for line in fHandler:
                line = line.rstrip()
                newLine = line.split("\t")
            
                if(section.lower() == newLine[2].lower()):
                    newLine[3]=int(newLine[3])
                    totalQuantity=totalQuantity+newLine[3]
                    print(newLine[0],'\t',newLine[1],'\t',newLine[3])
            print(section.upper(),"section, total quantity is",totalQuantity,'\n')
        
    else:
        print("Invalid Entry\n")
        return()
    return()

    
def searching():    ##Ask for warehouse. User can search for the part's record by typing the partID/ Supplier detail of a specific part by entering part ID/ parts that supplied by a specific supplier by entering the supplier name/ID
    warehouse=str(input("\t1.Bios warehouse\n\t2.Ambry warehouse\n\t3.Barrier warehouse\n\t4.Exit\nChoose the warehouse?:"))
    if(warehouse=='1'):
        fileHandler=open('WBS.txt','r')
    elif(warehouse=='2'):
        fileHandler=open('WAY.txt','r')
    elif(warehouse=='3'):
        fileHandler=open('WBR.txt','r')
    elif(warehouse=='4'):
        print("\n")
        return()
    else:
        print("Invalid Entry\n")
        return()
    operation=input("\t1.Part's record\n\t2.Supplier's details\n\t3.Parts supplied by supplier\nChoose the operation:")
    if(operation=='1'): ##searching the part record by inserting the partID in a warehouse
        searchPartRecord=input("Enter part's ID:")
        for line in fileHandler:
            line = line.rstrip()
            newLine = line.split("\t")
            if(searchPartRecord.lower()== newLine[0].lower()):
                print("Part's ID:",newLine[0])
                print("Part's Name:",newLine[1])
                print("Part's Section:",newLine[2])
                print("Part's Quantity:",newLine[3])
    elif(operation=='2'): ##searching the supplier details by inserting the partID in a warehouse
        searchPartSupplier=input("Enter part's ID:")
        for line in fileHandler:
            line = line.rstrip()
            newLine = line.split("\t")
            if(searchPartSupplier.lower()== newLine[0].lower()):
                print("Part's Supplier:",newLine[4])
                print("Part's Supplier ID:",newLine[5])
    elif(operation=='3'): ##search all the part supplied by 1 supplier by inserting the supplier name or supplier ID in a warehouse
        searchParts=input("Enter part's supplier name/ID:")
        count=0
        for line in fileHandler:
            line = line.rstrip()
            newLine = line.split("\t")
            if(searchParts.lower()== newLine[4].lower()or searchParts.lower()== newLine[5].lower()):
                print("Part's ID:",newLine[0])
                print("Part's Name supplied:",newLine[1],'\n')
                count=count+1
        print("Total parts supplied:",count)
    else:
        print("Invalid Entry\n")
        return()
    return()
                      
menu() ##the main program
