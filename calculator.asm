;Program description Calculator in assembly
;Author Vladyslav Kuzil
;Creation date 30.01.2025

.386
INCLUDE Irvine32.inc
.model flat, stdcall

.data
    MenuMsg BYTE "Simple Calculator", 0Dh, 0Ah, 
              "Choose an operation:", 0Dh, 0Ah,
              "1. Addition", 0Dh, 0Ah,
              "2. Subtraction", 0Dh, 0Ah,
              "3. Multiplication", 0Dh, 0Ah,
              "4. Division", 0Dh, 0Ah,
              "5. Power", 0Dh, 0Ah,
              "Enter your choice: ", 0
    Num1Msg BYTE "Enter the first number: ", 0
    Num2Msg BYTE "Enter the second number: ", 0
    ResultMsg BYTE "The result is: ", 0
    Choice DWORD ?                  
    Num1 DWORD ?                    
    Num2 DWORD ?                    
    Result DWORD ? 
    invalidMsg BYTE "Invalid option! Choose the other one", 0

.code
main PROC
    ; Display the menu
    lea edx, MenuMsg
    call WriteString

    ; Read user's choice
    call ReadInt
    mov [Choice], eax


    ; Prompt for the first number
    lea edx, Num1Msg
    call WriteString
    call ReadInt
    mov [Num1], eax

    ; Prompt for the second number
    lea edx, Num2Msg
    call WriteString
    call ReadInt
    mov [Num2], eax

    mov eax, [Num1]         
    mov ebx, [Num2]         

    mov ecx, [Choice]       
    cmp ecx, 1              
    je Addition
    cmp ecx, 2              
    je Subtraction
    cmp ecx, 3              
    je Multiplication
    cmp ecx, 4              
    je Division
    cmp ecx, 5              
    je Power


    lea edx, invalidMsg
    call WriteString
    jmp if_exit

Addition:
    add eax, ebx            
    jmp StoreResult

Subtraction:
    sub eax, ebx            
    jmp StoreResult

Multiplication:
    imul ebx                
    jmp StoreResult

Division:
    xor edx, edx            
    div ebx                 
    jmp StoreResult

Power:
    mov ecx, ebx            
    mov ebx, eax            
    mov eax, 1              
PowerLoop:
    imul eax, ebx           
    loop PowerLoop          
    jmp StoreResult

StoreResult:
    mov [Result], eax       

    ; Display the result
    mov edx, OFFSET ResultMsg
    call WriteString
    mov eax, [Result]
    call WriteInt

if_exit:
    ret
main ENDP
END main
