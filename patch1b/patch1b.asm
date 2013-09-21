
    .486                                    ; create 32 bit code
    .model flat, stdcall                    ; 32 bit memory model
    option casemap :none                    ; case sensitive
 
    include \masm32\include\windows.inc     ; always first
    include \masm32\macros\macros.asm       ; MASM support macros
    include \masm32\include\masm32.inc
    include \masm32\include\gdi32.inc
    include \masm32\include\user32.inc
    include \masm32\include\kernel32.inc

    includelib \masm32\lib\masm32.lib
    includelib \masm32\lib\gdi32.lib
    includelib \masm32\lib\user32.lib
    includelib \masm32\lib\kernel32.lib

    .data
    a1  dd  1d533f8h
    p1  db  50h, 0E8h, 62h, 0D2h, 0FEh, 0FFh, 83h, 0C4h, 04h
    p1sz    dd  9    
    winname    db  "Counter-Strike",0
    .data?
    pid  dd  ?
    hwnd  dd  ?
    hproc  dd  ?
    .code                      


start:
    lea eax, winname
    push    eax
    push    0
    call    FindWindow
    mov hwnd, eax
    
    lea ebx, pid
    push ebx
    push    eax
    call    GetWindowThreadProcessId

    push    pid
    push    0
    push    PROCESS_ALL_ACCESS  ;1F0FFFh
    call    OpenProcess
    mov hproc, eax

    ;now writing!!!
    push    0
    push    p1sz
    lea eax, p1
    push    eax
    push    a1
    push    hproc
    call    WriteProcessMemory

    push    hproc
    call CloseHandle   

    push 0
    call ExitProcess
end start                       