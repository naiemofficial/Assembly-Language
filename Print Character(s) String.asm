.MODEL SMALL         
.DATA
    MYSTRING DB "HELLO WORLD!$"
   
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MYSTRING
    MOV AH, 9   ; Mode = print character(s) stirng
    INT 21H     ; Show output
MAIN ENDP
END MAIN