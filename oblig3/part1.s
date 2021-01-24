.text
.global main

main:
    MOV R0, #13 @ N
    MOV R1, #0  @ current
    MOV R2, #1  @ previous

	FOR:
		MOV R3, R2
		CMP R0, #0
		BEQ DONE
		ADD R2, R1, R2
		MOV R1, R3
		SUB R0, R0, #1	
		B FOR
	DONE:
	
exit:
    BX LR
