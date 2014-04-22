
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
    a1  dd  01D9D450h
    p1  db  0E8h, 29h, 9Ch, 0F5h, 0FFh, 90h, 90h, 90h
    p1sz    dd  8    

    a2  dd  01CF707Eh 
    p2  db  68h, 71h, 0Bh, 00h, 00h, 0ffh, 15h, 05ch, 2bh, 7eh, 02h, 6ah, 05h, 0ffh, 15h
        db  0ech, 2bh, 7eh, 02h, 0c3h
    p2sz    dd  20 

    a3  dd  01D9D555h
    p3  db  0E8h, 62h, 9Bh, 0F5h, 0FFh, 90h
    p3sz    dd  6
    
    a4  dd  01CF70BCh
    p4  db  0FFh, 15h, 0B4h, 23h, 7Eh, 02h, 68h, 71h, 0Bh, 00h, 00h, 0ffh, 15h, 20h, 23h
        db  7eh, 02h, 0c3h
    p4sz    dd  18
    
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

    push    0
    push    p2sz
    lea eax, p2
    push    eax
    push    a2
    push    hproc
    call    WriteProcessMemory

    push    0
    push    p3sz
    lea eax, p3
    push    eax
    push    a3
    push    hproc
    call    WriteProcessMemory

    push    0
    push    p4sz
    lea eax, p4
    push    eax
    push    a4
    push    hproc
    call    WriteProcessMemory

    push    hproc
    call    CloseHandle

    push 0
    call ExitProcess
end start                       