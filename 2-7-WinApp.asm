; Description: WinApp assignment
; Modified by Zhaoyang, 2016-10-11

INCLUDE Irvine32.inc
INCLUDE 2-7-GraphWin.inc

; Windows Application (WinApp.asm)
; This program displays a resizable application window and
; several popup message boxes. Special thanks to Tom Joyce
; for the first version of this program.


;==================== DATA =======================
.data
AppLoadMsgTitle BYTE "Application Loaded",0
AppLoadMsgText BYTE "This window displays when the WM_CREATE "
               BYTE "message is received",0
PopupTitle BYTE "Popup Window",0
PopupText  BYTE "This window was activated by a "
           BYTE "WM_LBUTTONDOWN message",0
GreetTitle BYTE "Main Window Active",0
GreetText  BYTE "This window is shown immediately after "
           BYTE "CreateWindow and UpdateWindow are called.",0
WelcomeMsg BYTE "Welcome",0
CloseMsg   BYTE "WM_CLOSE message received",0
ByeMsg     BYTE "Bye",0
ErrorTitle BYTE "Error",0
WindowName BYTE "ASM Windows App",0
className  BYTE "ASMWin",0
; Define the Application's Window class structure.
MainWin WNDCLASS <NULL,WinProc,NULL,NULL,NULL,NULL,NULL, \
COLOR_WINDOW,NULL,className>
msg MSGStruct <>
winRect RECT <>
hMainWnd DWORD ?
hInstance DWORD ?
;=================== CODE =========================
.code
WinMain PROC
; Get a handle to the current process.
        INVOKE  GetModuleHandle, NULL
        mov     hInstance, eax
mov MainWin.hInstance, eax
; Load the program's icon and cursor.
        INVOKE  LoadIcon, NULL, IDI_APPLICATION
mov MainWin.hIcon, eax
        INVOKE  LoadCursor, NULL, IDC_ARROW
mov MainWin.hCursor, eax
; Register the window class.
        INVOKE  RegisterClass, ADDR MainWin
.IF eax == 0
call ErrorHandler
jmp Exit_Program
.ENDIF
; Create the application's main window.
        INVOKE  CreateWindowEx, 0, ADDR className,
          ADDR  WindowName, MAIN_WINDOW_STYLE,
CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,
CW_USEDEFAULT,NULL,NULL,hInstance,NULL
; If    CreateWindowEx  failed, display a message and exit.
.IF eax == 0
call ErrorHandler
jmp Exit_Program
.ENDIF
; Save the      window  handle, show and draw the window.
        mov     hMainWnd, eax
        INVOKE  ShowWindow, hMainWnd, SW_SHOW
        INVOKE  UpdateWindow, hMainWnd
; Display a greeting message.
        INVOKE  MessageBox, hMainWnd, ADDR GreetText,
          ADDR  GreetTitle, MB_OK
; Begin the program's continuous message-handling loop.
Message_Loop:
; Get next message from the queue.
        INVOKE  GetMessage, ADDR msg, NULL,NULL,NULL
; Quit if no more messages.
.IF eax == 0
jmp Exit_Program
.ENDIF
; Relay the message to the program's WinProc.
        INVOKE  DispatchMessage, ADDR msg
jmp Message_Loop
Exit_Program:
        INVOKE  ExitProcess, 0
WinMain ENDP
;-----------------------------------------------------
        WinProc PROC,
hWnd:DWORD, localMsg:DWORD, wParam:DWORD, lParam:DWORD
;
; The application's     message handler, which handles
; application-specific messages. All other messages
; are forwarded to the default Windows message
; handler.
;-----------------------------------------------------
        mov     eax, localMsg
.IF eax == WM_LBUTTONDOWN ; mouse button?
        INVOKE  MessageBox, hWnd, ADDR PopupText,
		  ADDR  PopupTitle, MB_OK
jmp WinProcExit
.ELSEIF eax == WM_KEYDOWN ; key button?
        INVOKE  MessageBox, hWnd, ADDR WelcomeMsg,
          ADDR  PopupTitle, MB_OK
jmp WinProcExit
.ELSEIF eax == WM_CREATE ; create window?
        INVOKE  MessageBox, hWnd, ADDR AppLoadMsgText,
          ADDR  AppLoadMsgTitle, MB_OK
jmp WinProcExit
.ELSEIF eax == WM_CLOSE ; close window?
        INVOKE  MessageBox, hWnd, ADDR ByeMsg,
		  ADDR  WindowName, MB_OK
        INVOKE  MessageBox, hWnd, ADDR CloseMsg,
          ADDR  WindowName, MB_OK
        INVOKE  PostQuitMessage, 0
jmp WinProcExit
.ELSE ; other message?
        INVOKE  DefWindowProc, hWnd, localMsg, wParam, lParam
jmp WinProcExit
.ENDIF
WinProcExit:
ret
WinProc ENDP
;---------------------------------------------------
ErrorHandler PROC
; Display the appropriate system error message.
;---------------------------------------------------
.data
pErrorMsg DWORD ? ; ptr to error message
messageID DWORD ?
.code
INVOKE GetLastError ; Returns message ID in EAX
        mov     messageID, eax
; Get the corresponding message string.
        INVOKE  FormatMessage, FORMAT_MESSAGE_ALLOCATE_BUFFER + \
FORMAT_MESSAGE_FROM_SYSTEM,NULL,messageID,NULL,
          ADDR  pErrorMsg, NULL,NULL
; Display the error message.
        INVOKE  MessageBox, NULL, pErrorMsg, ADDR ErrorTitle,
MB_ICONERROR+MB_OK
; Free the error message string.
        INVOKE  LocalFree, pErrorMsg
ret
ErrorHandler ENDP
END WinMain
