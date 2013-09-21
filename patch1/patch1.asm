
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
    p1  db  0E8h, 81h, 3Ch, 0FAh, 0FFh, 90h, 90h, 90h, 90h
    p1sz    dd  9    
    a2  dd  01CF707Eh 
    p2  db  50h, 0E8h, 0DCh, 95h, 04h, 00h, 83h, 0C4h, 04h, 60h, 68h, 03h, 03h, 00h, 00h, 68h
        db  02h, 03h, 00h, 00h, 0E8h, 99h, 0D7h, 52h, 5Dh, 68h, 71h, 0Bh, 00h, 00h, 0E8h, 0A7h
        db  0BDh, 52h, 5Dh, 68h, 0E2h, 0Bh, 00h, 00h, 0E8h, 0A9h, 0BDh, 52h, 5Dh, 68h, 66h, 66h
        db  0E6h, 3Eh, 68h, 66h, 66h, 66h, 3Fh, 68h, 66h, 66h, 66h, 3Fh, 68h, 66h, 66h, 66h
        db  3Fh, 0E8h, 28h, 0B9h, 52h, 5Dh, 61h, 0C3h
    p2sz    dd  72 
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

    push    hproc
    call    CloseHandle

    push 0
    call ExitProcess
end start                       