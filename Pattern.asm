.MODEL SMALL
.STACK 100H
.DATA
    N DB 0                   ; To store the user input value of N
    SPACE DB '  $'           ; Space string
    NUMFMT DB '%D $'         ; Number format string (not directly used)
    NEWLINE DB 0DH, 0AH, '$' ; Newline
.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Take input for N
    LEA DX, SPACE          ; Prompt user (using space as an example for prompt)
    MOV AH, 09H
    INT 21H

    MOV AH, 01H            ; Read a single character
    INT 21H
    SUB AL, '0'            ; Convert ASCII to numeric
    MOV N, AL              ; Store the numeric value in N

    ; Print newline after input
    LEA DX, NEWLINE
    MOV AH, 09H
    INT 21H

    ; Upper Triangle
    MOV AL, N              ; AL = N
    MOV CL, AL             ; CL = N (outer loop variable for i)

UPPEROUTERLOOP:
    ; Leading spaces
    MOV BL, N              ; BL = N
    SUB BL, CL             ; BL = N - i
    CMP BL, 0
    JE UPPERPRINTNUMBERS   ; Skip if no spaces
UPPERSPACELOOP:
    LEA DX, SPACE
    MOV AH, 09H
    INT 21H                ; Print space
    DEC BL                 ; Decrement space counter
    JNZ UPPERSPACELOOP

UPPERPRINTNUMBERS:
    ; Print descending numbers
    MOV BL, CL             ; BL = i
    SHL BL, 1              ; BL = 2 * i
    DEC BL                 ; BL = 2 * i - 1 (K)
UPPERNUMBERLOOP:
    MOV DL, BL             ; DL = K
    ADD DL, '0'            ; Convert to ASCII
    MOV AH, 02H
    INT 21H                ; Print number
    MOV AH, 02H
    MOV DL, ' '            ; Print space after number
    INT 21H
    DEC BL                 ; Decrement K
    CMP BL, 0
    JNZ UPPERNUMBERLOOP

    ; Print newline
    LEA DX, NEWLINE
    MOV AH, 09H
    INT 21H

    DEC CL                 ; i--
    CMP CL, 0
    JNZ UPPEROUTERLOOP

    ; Lower Triangle
    MOV CL, 2              ; i = 2

LOWEROUTERLOOP:
    ; Leading spaces
    MOV BL, N              ; BL = N
    SUB BL, CL             ; BL = N - i
    CMP BL, 0
    JE LOWERPRINTNUMBERS   ; Skip if no spaces
LOWERSPACELOOP:
    LEA DX, SPACE
    MOV AH, 09H
    INT 21H                ; Print space
    DEC BL                 ; Decrement space counter
    JNZ LOWERSPACELOOP

LOWERPRINTNUMBERS:
    ; Print descending numbers
    MOV BL, CL             ; BL = i
    SHL BL, 1              ; BL = 2 * i
    DEC BL                 ; BL = 2 * i - 1 (K)
LOWERNUMBERLOOP:
    MOV DL, BL             ; DL = K
    ADD DL, '0'            ; Convert to ASCII
    MOV AH, 02H
    INT 21H                ; Print number
    MOV AH, 02H
    MOV DL, ' '            ; Print space after number
    INT 21H
    DEC BL                 ; Decrement K
    CMP BL, 0
    JNZ LOWERNUMBERLOOP

    ; Print newline
    LEA DX, NEWLINE
    MOV AH, 09H
    INT 21H

    INC CL                 ; i++
    CMP CL, N
    JLE LOWEROUTERLOOP

    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
