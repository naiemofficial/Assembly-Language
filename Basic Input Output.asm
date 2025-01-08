.MODEL SMALL
MAIN PROC
    MOV AH, 1   ; Mode=input
    INT 21H     ; Take input (stored to AL)
    
    MOV DL, AL  ; Store input value (AL) to DL
    MOV AH, 2   ; Mode=output
    INT 21H     ; Show output
MAIN ENDP
END MAIN