#calculate the gain in T+0 operation

ratio = 0.0008


def calc():
    #with open ("ratio.conf.txt","r") as f:
    #    ratio = f.readline()
    num = int(raw_input("Input Quantity: "))
    bPrice = float(raw_input("Buy Rate: "))
    cPrice = float(raw_input("Sell Rate: "))
    bCommission = num*float(bPrice)*ratio
    cCommission = num*float(cPrice)*ratio
    stampDuty = num*float(cPrice)*0.001
    #scripFee = float(num)/1000
    scripFee = 0
    if (bCommission<5.0):
        bCommission = 5.0
    if (cCommission<5.0):
        cCommission = 5.0
    income = (cPrice - bPrice)*num - bCommission - cCommission - stampDuty - scripFee
    print "\t"
    print "Result: \n\r"
    print "========================="
    print " Income: {} \n\r bCommission: {}\n\r cCommission: {}\n\r stampDuty: {}\n\r scripFee: {}\n\r ".format(income, bCommission,cCommission,stampDuty,scripFee)
    raw_input("press any key to continue")
	
class shanghai():
    def __init__():
        scripFeeBase = 2
        pass
		
class shenzhen():
    def __init__():
        scripFeeBase = 0
        pass	
	
	
	
if __name__ == "__main__":
    calc()
