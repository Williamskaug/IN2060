
@ The two numbers we want to add
num1:   .word   0x3f800000 @Num 1 for addition
num2:   .word   0x3f800000 @Num 2 for addition
num3:   .word   0x7f800000 @Num to mask out eksponent
num4:   .word   0x007fffff @Num to mask out mantissa
num5:   .word   0x00800000 @Lead number
num6:   .word   0x00ffffff 

.text
.global main
main:
    @ Load numbers
    LDR r0, num1
    LDR r1, num2
    LDR r2, num3
    LDR r3, num4
    
    AND r1, r0, r2      @masking out exponent
    AND r2, r1, r2      @masking out exponent
    LSR r1, r1, #23
    LSR r2, r1, #23
    push {r1,r2}        @adding to stack
    
    LDR r1, num1        @overriding memory back to num1
    LDR r2, num2        @overriding memory back to num2
    AND r1, r0, r3      @masking out decimal
    AND r2, r1, r3      @masking out decimal
    LDR r3, num5        @loading leading number
    ORR r1, r1, r3      @adding leading 1
    ORR r2, r2, r3      @adding leading 1
	
	
	POP {r4}            @popping from stack - masked exponent from num2
    POP {r3}            @popping from stack - masked exponent from num1
   

    CMP r3, r4          @comparing the two exponents
    BLMI biggerthan      @branching to function biggerthan or lessthan
    BLPL lessthan
    
	biggerthan:
		PUSH {r3}           @saving masked exponent for later in stack num1
		PUSH {r4}           @saving masked exponent for later in stack num2
		PUSH {r1}           @saving masked decimal + leading 1 for later in stack num1
		PUSH {r2}           @saving masked decimal + leading 1 for later in stack num2
		
		SUB r2, r3, r4      @finding the difference
		LSR r4, r4, r2      @right shifting the lowest number with the difference	
		ADD r0, r4, r3      @adding the decimals
		
		POP {r2}            @getting masked decimal for num2
		POP {r1}            @getting masked decimal for num1
		POP {r4}            @getting masked exponent for num2
		POP {r3}            @getting masked exponent for num1
		
		MOV r3, r2
		
	BX lr
	
	lessthan:
	    PUSH {r3}           @saving exponent for later in stack num1
		PUSH {r4}           @saving exponent for later in stack num2
		PUSH {r1}           @saving decimal + leading 1 for later in stack num1
		PUSH {r2}           @saving decimal + leading 1 for later in stack num2
	
		SUB r2, r4, r3      @finding the difference
		LSR r3, r3, r2      @right shifting the lowest number with the difference
		ADD r0, r4, r3      @adding the decimals
				
		POP {r2}            @getting masked decimal for num2
		POP {r1}            @getting masked decimal for num1
		POP {r4}            @getting masked exponent for num2
		POP {r3}            @getting masked exponent for num1

		
	BX lr
	
	LDR r0, num6
	CMP r0, r3
	BLMI rest
	BLPL norest

	rest:
		LDR r4, num5
		LSL r4, #1
		BIC r0, r4
		LSR r0, #1
		ADD r3, r3, #1
	BX lr
	
	norest:
		LDR r4, num5
		BIC r0, r4
	BX lr
	
	LSL r3, r3, #23
	ORR r0, r0, r3
    
    
    @ ! Perform addition here !
    @ When done, return
    BX lr
