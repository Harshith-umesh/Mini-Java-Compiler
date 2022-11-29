# REG 0 - 12 are the available Registers

import sys
import time

if len(sys.argv) != 2:
    print("Correct USAGE- python3 assembly.py output.txt\n")
    exit()


unused_registers = ['REG0','REG1','REG2','REG3','REG4','REG5','REG6','REG7','REG8','REG9','REG10','REG11','REG12']
used_registers  = []
register_values = {}
iffalse_condition = " "

def line_manager(line):	#main function that evaluates each line.

    global iffalse_condition
    line = line.split()
        
    if(len(line) == 1):
    	print("       ",line[0])
    	return            
    
    if 'goto' in line and len(line) == 2:
        print("ARM STATEMENT:  B {}".format(line[1]))
        time.sleep(0.05)
        return               
    
    for op in ['+','-','*','/']: 
        if op in line and len(line) == 5 :
        	if(op == "+"):
        		st = "ADD"
        	elif(op == "-"):
        		st = "SUB"        	
        	elif(op == "*"):
        		st = "MUL"        	
        	elif(op == "/"):
        		st = "DIV"        	
        	binary_ops(line,st)
        	return            
          
    
    for op in ['==','!=','<','>','<=','>=']:
        if op in line and len(line) == 5 :
        	if(op == "=="):
        		stt = "BNE"        	
        	elif(op == "!="):
        		stt = "BE"
        	elif(op == "<="):
        		stt = "BGE"
        	elif(op == ">="):
        		stt = "BLE"        	
        	elif(op == "<"):
        		stt = "BGT"        	
        	elif(op == ">"):
        		stt = "BLT"
        		
        	iffalse_condition =stt        	
        	comparison_ops(line)
        	return       
    
    
    if 'ifFalse' in line:
        print("ARM STATEMENT:  {} {}".format(iffalse_condition,line[3]))
        time.sleep(0.05)
        return  
    
    
    if '=' in line and len(line) == 3:
        reg1 = check_register(line[2])
        print("ARM STATEMENT:  STR {},{}".format(reg1,line[0]))
        time.sleep(0.05)
                
        for reg in register_values.keys():
            if(register_values[reg] == line[0]):
                register_values.pop(reg)
                used_registers.remove(reg)
                unused_registers.append(reg)
                break        
       
        if(register_values[reg1].isnumeric() or line[2][0] == 't'):
            used_registers.remove(reg1)
            used_registers.append(reg1)
            register_values[reg1] = line[0]           
            
        return 

def check_register(arg):	#function to check the availability of registers and return existing or new registers.
    for i in register_values:
        if(register_values[i] == arg):
        
            reg = i
            used_registers.remove(reg)
            used_registers.append(reg)
            return reg
            
    reg = new_register()
    
    if(arg.isnumeric()):
    	print("ARM STATEMENT:  MOV {},{}".format(reg,'#'+arg))
    else:
    	print("ARM STATEMENT:  MOV {},{}".format(reg,arg))
    time.sleep(0.05)
    
    register_values[reg]=arg
    return reg

def new_register(): #function to assign a new register or reuse the oldest register in LRU method.
    
    if unused_registers:    
        reg = unused_registers.pop(0)
        used_registers.append(reg)
    else:
        reg = used_registers[0]
        reg = used_registers.pop(0)
        register_values.pop(reg)
        used_registers.append(reg)
    return reg


def comparison_ops(line):  # function for conditional operators
    reg1 = check_register(line[2])
    reg2 = line[4]
    print("ARM STATEMENT:  CMP {},{}".format(reg1,'#'+reg2))
    time.sleep(0.05)

def binary_ops(line,op):   #function for binary mathematical operators
    reg2 = check_register(line[2])
    reg1 = check_register(line[0])  
    reg3 = line[4]     
    print("ARM STATEMENT:  {} {},{},{}".format(op,reg1,reg2,'#'+reg3))
    time.sleep(0.05)
       	        
    register_values[reg1] = line[0]    

    
if __name__ == "__main__":
    if len(sys.argv) == 2:
        icg = str(sys.argv[1])

    lines = []
    code = open(icg, "r")
    for line in code:
        lines.append(line)
    code.close()

    for line in lines:
        line_manager(line)
