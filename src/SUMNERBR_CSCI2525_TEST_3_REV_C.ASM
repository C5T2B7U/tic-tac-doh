;// BRIAN SUMNER
;// UCDENVER CSCI2525-001
;// SPRING 2016
;// TEST 3 - FINAL EXAM



;// AUTHOR'S FIRST REAL ARCADE GAME
;// BUILT IN 84 CONTIGUOUS HOURS
;// (INCLUDING SLEEP, CLASS, FOOD, ETC)
;// FINISHED RIGHT BEFORE MIDNIGHT, MAY 6




;// MASTER BEHAVIOR SETTINGS:


DISPLAY_LOADSCR_ = 1;// TO [EN/DIS]ABLE LOADSCREEN SET [1, 0] AS [T, F]


DISPLAY_ANNOYANCE_ = 0;// SHOW WARNING MESSAGE POPUP PER IRVINE32 / IRVINE32


BBS_BAUD_RATE_ = 9600;// BBS DATA TRANSFER SPEED IN BITS PER SECOND 
;// NOTE: CALL QUALITY CANNOT BE GUARANTEED! LOWER CALL QUALITY WILL RESULT IN INCREASED LATENCY







COMMENT @




;// [REVISION HISTORY]:




;// [REV. RC1]:

;// Tic-Tac-D'oh! works great! You may get "diconnected" from time to time when 
;// utilizing the CPU players.  This is entirely due to your highly unstable BBS 
;// call connection and has nothing at all to do with an unreproducible logic bug.

;// Yes, Tic-Tac-D'oh! is compatible with the xbox360 controller!





;// [REV. BETA]:

;// Tic-Tac-D'oh! is now powered by patent-pending StubbornKeys (R)
;// Passive-Agressive Input Technology!  Maybe StubbornKeys (R)
;// will register your appropriate keystroke, but then again, 
;// maybe it won't.  Everybody's a winner, sometimes.




;// [REV. ALPHA]:

;// Yes I am aware of the ReadKey loop bug which does not always register
;// an appropriate keystroke, and I am currently evaluating options for 
;// correcting this deficiency.



@





COMMENT @


;// ASSIGNMENT DOCUMENTATION:



;// CSCI – 2525 FINAL EXAM Spring 2016
;// DUE : 9 May 2016 11 : 59pm
;// 	Problem : Write a program that simulates the game of Tic - Tac - Toe.The User
;// 	will play against the computer(your assembly program) or the computer will
;// 	play against itself.
;// 	1. You must use a two - dimensional array and Base - Index operands(Row - major order)
;// 	throughout the game.The game board is created with characters.
;// 	- | -| -
;// 	-| -| -This is an example of the empty board.
;// 	- | -| -
;// 	-| x | -
;// 	-| o | -This is an example of a game in progress.
;// 	- | -| -
;// 	2. All Procedures will be called with PROTO / INVOKE / PROC.I will be checking for this.DO NOT
;// 	USE USES as discussed in class.The only exception is the Irvine32 library.These must be called
;// 	with CALL.
;// 	3. If the game is player vs computer, start the game by randomly choosing which of player or
;// 	computer to make first move.The first player will be assigned the letter x.
;// 	a.The computer chooses a move by selecting an open position randomly. (We are not
;// 		developing Artificial Intelligence)
;// 	i) However, if the game is player vs computer, and the center square is
;// 	available on the computer’s first turn, the computer MUST chose that
;// 	square(regardless of whether or not the computer the first or second
;// 		player).
;// 	ii) Afterwards, all moves by the computer will be random.
;// 	b.The player will enter a move via the keyboard.
;// 	i) You must check to see if it is a valid move, i.e. not an already occupied
;// 	‘square’, or a square that is non - existent.
;// 	ii) Keep asking for a move until a valid move is entered.
;// 	c.After each move clear the screen and redisplay the game with the new move entered.
;// 	d.At the conclusion of each game of tic - tac - toe, ask if the player wishes to play again.
;// 	Yes, even if it is computer vs computer.
;// 	CSCI – 2525 FINAL EXAM Spring 2016
;// 	e.Have a menu option that allows the user to check statistics.
;// 	i) How many games played
;// 	ii) How many games won by Player 1
;// 	iii) How many games won by Player 2
;// 	iv) How many games resulted in a draw.
;// 	f.When the user chooses to exit the above statistics should be displayed until a key is
;// 	pressed.
;// 	4. If the game is computer vs computer after each move display the current state of the game
;// 	for 2 seconds, before allowing another move to be made.The user just watch the game being
;// 		played.
;// 		5. When the game ends, display who won or if the game was a draw.
;// 		a.If someone(either player or computer) wins, highlight the winning path(either three
;// 			x’s or three o’s) with black on yellow as the final display.
;// 		6. The game will start with a menu.The options are player vs computer, computer vs
;// 		computer, and exit.
;// 		7. As always, variables used by a procedure must either be passed to that procedure or created
;// 		within the procedure.Only Main PROC can directly access the variables initialized in.data.All
;// 		others must be local to the procedures.
;// 		8. Style counts to include proper commenting.
;// 		9. I reserve the right to award extra credit for innovative code and implementation thereof.
;// 		Deliverables:
;// 1. Your code must be delivered on Canvas.Plan ahead, Canvas will not allow you to submit the
;// code late.If for some reason, CANVAS is down, then you may email me your code.
;// HOWEVER, if you try to deliver your code late, I will not accept an email.
;// 2. You must also upload a screen shot(pdf only please) of
;// a) the player vs computer game in progress after 3 moves have been made
;// b) a completed game.
;// For extra credit : You can do something unique.For example : Use non - blinding and nonclashing colors to high - light which square is an X and which is a O.I leave it to you to challenge
;// yourselves to find something which merits extra credit.How much extra credit is awarded will
;// depend on how much extra work you do.



@




TITLE SUMNERBR_CSCI2525_PA8.ASM



INCLUDE Irvine32.inc






.DATA






;// GLOBAL DATA INVARIANTS



RUNLEVELS$   DB   0,   0, 0, 0, 0, 0,   0, 0, 0, 0, 0
;// [0] P1 NOT SET 0; P1 SET 1-4
;// [1] P2 NOT SET 0; P2 SET 1 - 4
;// [2] NUMBER OF MOVES PLAYED 0-9
;// [3] NO WINNER 0; WINNER IDENTITY 1-4; DRAW 5
;// [4] SELECT1: HIGHLIGHT IDENTITY WITH EXIT 1-4; HIGHLIGHT EXIT 5
;// [5] SELECT2: DO NOT HIGHLIGHT 0; HIGHLIGHT IDENTITY 1-4; HIGHLIGHT BACK 5
;// [6] SELECT3: DO NOT HIGHLIGHT 0; HIGHLIGHT PLAY 1; SHADE PLAY/START GAME 2; HIGHLIGHT BACK 5
;// [7] SHOW SELECT1 EXIT 0; HIDE SELECT1 EXIT 1
;// [8] HIDE SELECT2 BACK 0; SHOW SELECT2 BACK 1
;// [9] HIDE SELECT3 BACK 0; SHOW SELECT3 BACK 1
;// [10] MISC BUFFER



BOARD$ DB 5, 9 DUP(0);// [0] CURSOR NOT SET O; CURSOR LOCATION 1-9
;// [1]-[9] GAMEBOARD FOR X/O CHAR STAMPS; SPOT EMPTY SENTINAL 0



; PLAYERS$ DD  DUP(0);// [0.0.0] NEXT PLAYER, [0.1.1] PLAYER 1, [0.2.2] PLAYER 2, [0.3.3] GAMES PLAYED
;// [1.0.4] ARCHEE STAMP, [1.1.5] ARCHEE WINS, [1.2.6] N/A             [1.3.7] N/A         
;// [2.0.8] VERONIKA STAMP, [2.1.9] VERONIKA WINS, [2.2.10] N/A               [2.3.11] N/A           
;// [3.0.12] BETTIE STAMP, [3.1.13] BETTIE WINS, [3.2.14] N/A             [3.3.15] N/A         
;// [4.0.16] JUGHED STAMP, [4.1.17] JUGHED WINS, [4.2.18] N/A             [4.3.19] N/A         
;// [5.0.20] DRAWS, [5.1.21] P1 WINS, [5.2.22] P2 WINS, [5.3.23] N/A
;// [6.0.24] X PLAYER 1/2; [6.1.25] O PLAYER 1/2; [6.2.26] N/A; [6.3.26]



PLAYERS$ DB 0, 0, 0, 0
DB 0, 0, 0, 0
DB 0, 0, 0, 0
DB 0, 0, 0, 0
DB 0, 0, 0, 0
DB 0, 0, 0, 0
DB 0, 0, 0, 0



;// XO_P1P2$ DB 2, 1, 4, 1;// [BP 0] X PLAYER 1/2, [BP 1] O PLAYER 1/2, [BP 2] X COLORS, [BP 3] O COLORS



CONSIDERATIONS$ DB 10 DUP(0);// FOR ACTUAL AI. NOT IMPLEMENTED.



PACKETS_LOST$ DW 255, BBS_BAUD_RATE_, BBS_BAUD_RATE_, BBS_LATENCY_, 85, BBS_LATENCY_
;// [0.0] WHIRLIGIG; [0.1] TRULYRANDOM VALID BIT
;// [1.2-3] THEORETICAL BAUD RATE
;// [2.4-5] ACTUAL BAUD RATE
;// [3.6-7] CURRENT LATENCY
;// [4.8-9] CALCULATED CALL QUALITY PERCENTAGE
;// [5.10-11] MINIMUM LATENCY




;// HEADER DECLARATIONS





RecalculateLatency PROTO,
	$RELAT_PACKETS_LOST : PTR DWORD





IsGameOver PROTO,
	$IGO_RUNLEVELS : PTR DWORD,
	$IGO_BOARD : PTR DWORD,
	$IGO_PLAYERS : PTR DWORD




AffixStamp PROTO,
	$STAMP_RUNLEVELS : PTR DWORD,
	$STAMP_BOARD : PTR DWORD,
	$STAMP_PLAYERS : PTR DWORD





RecalculatePosition PROTO,
	$RECALC_RUNLEVELS : PTR DWORD,
	$RECALC_BOARD : PTR DWORD,
	$RECALC_PLAYERS : PTR DWORD,
	_RECALC_DIRECTION : DWORD




DisplaySub PROTO,
	$SUB_RUNLEVELS : PTR DWORD,
	$SUB_BOARD : PTR DWORD,
	$SUB_PLAYERS : PTR DWORD,
	$SUB_PACKETS_LOST : PTR DWORD,
	_SUB_BBS_LATENCY : DWORD,
	_SUB_DEFAULT_COLORS : DWORD,
	_SUB_CURSOR_AVAILABLE_COLORS : DWORD,
	_SUB_CURSOR_UNAVAILABLE_COLORS : DWORD,
	_SUB_PLAYER_1_COLORS : DWORD,
	_SUB_PLAYER_2_COLORS : DWORD,
	_SUB : DWORD




DisplayScreen PROTO,
	$DISP_RUNLEVELS : PTR DWORD,
	$DISP_BOARD : PTR DWORD,
	$DISP_PLAYERS : PTR DWORD,
	$DISP_PACKETS_LOST : PTR DWORD,
	_DISP_BBS_LATENCY : DWORD,
	_DEFAULT_COLORS : DWORD,
	_CURSOR_AVAILABLE_COLORS : DWORD,
	_CURSOR_UNAVAILABLE_COLORS : DWORD,
	_PLAYER_1_COLORS : DWORD,
	_PLAYER_2_COLORS : DWORD,
	_WINNER_SQUARE_COLORS : DWORD,
	_NOT_WINNER_SQUARE_COLORS : DWORD






StubbornKeysPatentPending PROTO,
	$PACKETS_LOST : PTR DWORD




ResetData PROTO,
	$RESET_PTR : PTR DWORD,
	$RESET_BYTES : DWORD,
	$RESET_VALUE : DWORD



DoRandomRange PROTO,
	_RAND_MIN : DWORD,
	_RAND_MAX : DWORD




DoDelay PROTO,
	_DELAY_DURATION : DWORD



ArcadeControl PROTO,
	$CTRL_RUNLEVELS : PTR DWORD,
	$CTRL_BOARD : PTR DWORD,
	$CTRL_PLAYERS : PTR DWORD,
	$CTRL_PACKETS_LOST : PTR DWORD,
	_DELAY_LONG : DWORD



TicTacDoh PROTO,
	$RUNLEVELS : PTR DWORD,
	$BOARD : PTR DWORD,
	$PLAYERS : PTR DWORD,
	$CONSIDERATIONS : PTR DWORD,
	$PACKETS_LOST : PTR DWORD





	.CODE





Main PROC
;//==========================================================================
;// DESC:     LOADS THE  TIC-TAC-D'OH!  GAME                                #
;// REQUIRES: MASM                                                          #
;// REQUIRES: Irvine32 LIBRARY                                              #
;//==========================================================================


LOAD_DURATION_ = 777

BBS_LATENCY_ = 8000 / BBS_BAUD_RATE_;// THEORETICAL DELAY BETWEEN CHARACTERS IN MILLISECONDS



.DATA


LOADING_010$ DB 0DH, 0AH, 0DH, 0AH, 0
LOADING_020$ DB "     Tic-Tac-D'oh!", 0
LOADING_030$ DB 0DH, 0AH, 0DH, 0AH, 0DH, 0AH, 0DH, 0AH, 0
LOADING_040$ DB " (C) BRIAN SUMNER 2016 ", 0DH, 0AH
DB " UCDENVER CSCI2525-001"
DB 0DH, 0AH, 0DH, 0AH, 0DH, 0AH, 0DH, 0AH, 0
LOADING_050$ DB "[WARNING]: RUNNING THIS", 0DH, 0AH
DB "PROGRAM AT NON-STANDARD", 0DH, 0AH
DB "RESOLUTIONS MAY PRODUCE", 0DH, 0AH
DB "  UNDEFINED BEHAVIOR.", 0
LOADING_060$ DB 0DH, 0AH, 0DH, 0AH, 0DH, 0AH, 0DH, 0AH
DB " [LOADING]: ", 0

LOADED$ DB 0DH, 0AH, 0DH, 0AH, 0DH, 0AH
DB "  [LOADING  COMPLETE]", 0


.CODE



MOV EBX, DISPLAY_LOADSCR_
CMP EBX, 0
JZ BypassLoadScr



CALL ClrScr


MOV EDX, OFFSET LOADING_010$
CALL WriteString

MOV EDX, OFFSET LOADING_020$
CALL WriteString

MOV EDX, OFFSET LOADING_030$
CALL WriteString

MOV EDX, OFFSET LOADING_040$
CALL WriteString

MOV EDX, OFFSET LOADING_050$
CALL WriteString



MOV EDX, DISPLAY_ANNOYANCE_
CMP EDX, 0
JZ DontDisplayAnnoyance


MOV EBX, OFFSET LOADING_020$
MOV EDX, OFFSET LOADING_050$
CALL MsgBox


DontDisplayAnnoyance :


MOV EDX, OFFSET LOADING_060$
CALL WriteString

MOV ECX, 10


DoLoadLoop:


MOV AL, '#'
CALL WriteChar
INVOKE DoDelay, LOAD_DURATION_

LOOP DoLoadLoop


MOV EDX, OFFSET LOADED$
CALL WriteString
INVOKE DoDelay, LOAD_DURATION_
INVOKE DoDelay, LOAD_DURATION_
INVOKE DoDelay, LOAD_DURATION_


BypassLoadScr :


MOV EAX, 0
CALL GetTextColor
PUSH EAX


CALL Randomize


INVOKE TicTacDoh,
ADDR RUNLEVELS$,
ADDR BOARD$,
ADDR PLAYERS$,
ADDR CONSIDERATIONS$,
ADDR PACKETS_LOST$


POP EAX
CALL SetTextColor
CALL ClrScr


EndMain :


EXIT
Main ENDP
;//==========================================================================












TicTacDoh PROC,
	$RUNLEVELS : PTR DWORD,
	$BOARD : PTR DWORD,
	$PLAYERS : PTR DWORD,
	$CONSIDERATIONS : PTR DWORD,
	$PACKETS_LOST : PTR DWORD
;//==========================================================================
;// DESC: RUNS THE TIC-TAC-D'OH GAME                                        #
;//==========================================================================




;// GAMEPLAY CONSTANTS

DEFAULT_BGCOLOR_ = lightGray
DEFAULT_FGCOLOR_ = black
DEFAULT_COLORS_ = DEFAULT_BGCOLOR_ * 16 + DEFAULT_FGCOLOR_

CURSOR_AVAILABLE_BGCOLOR_ = blue
CURSOR_AVAILABLE_FGCOLOR_ = lightGray
CURSOR_AVAILABLE_COLORS_ = CURSOR_AVAILABLE_BGCOLOR_ * 16 + CURSOR_AVAILABLE_FGCOLOR_

CURSOR_UNAVAILABLE_BGCOLOR_ = red
CURSOR_UNAVAILABLE_FGCOLOR_ = lightGray
CURSOR_UNAVAILABLE_COLORS_ = CURSOR_UNAVAILABLE_BGCOLOR_ * 16 + CURSOR_UNAVAILABLE_FGCOLOR_

PLAYER_1_BGCOLOR_ = cyan
PLAYER_2_BGCOLOR_ = yellow
PLAYER_1_COLORS_ = PLAYER_1_BGCOLOR_ * 16 + PLAYER_2_BGCOLOR_
PLAYER_2_COLORS_ = PLAYER_2_BGCOLOR_ * 16 + PLAYER_1_BGCOLOR_

WINNER_SQUARE_COLORS_ = yellow * 16 + black
NOT_WINNER_SQUARE_COLORS_ = black * 16 + yellow


DELAY_DURATION_LONG_ = 2000;// LONG DURATION FOR DELAY


.DATA
.CODE


COMMENT @

CMP $RUNLEVELS, 0
CMP $BOARD, 0
CMP $PLAYERS, 0

@

CMP $CONSIDERATIONS, 0




HardReset:


MOV EAX, DEFAULT_COLORS_
CALL SetTextColor

CALL ClrScr


INVOKE ResetData, $RUNLEVELS, 10, 0
INVOKE ResetData, $BOARD, 10, 0
INVOKE ResetData, $PLAYERS, 26, 0



COMMENT @

;// MANUAL SET RUNLEVEL

;// [0] P1 NOT SET 0; P1 SET 1-4
;// [1] P2 NOT SET 0; P2 SET 1 - 4
;// [2] NUMBER OF MOVES PLAYED 0-9
;// [3] NO WINNER 0; WINNER IDENTITY 1-4; DRAW 5
;// [4] SELECT1: HIGHLIGHT IDENTITY WITH EXIT 1-4; HIGHLIGHT EXIT 5
;// [5] SELECT2: DO NOT HIGHLIGHT 0; HIGHLIGHT IDENTITY 1-4; HIGHLIGHT BACK 5
;// [6] SELECT3: DO NOT HIGHLIGHT 0; HIGHLIGHT PLAY 1; SHADE PLAY/START GAME 2; HIGHLIGHT BACK 5
;// [7] SHOW SELECT1 EXIT 0; HIDE SELECT1 EXIT 1
;// [8] HIDE SELECT2 BACK 0; SHOW SELECT2 BACK 1
;// [9] HIDE SELECT3 BACK 0; SHOW SELECT3 BACK 1
;// [10] N/A

MOV EDI, $RUNLEVELS
MOV BYTE PTR[EDI + 0], 3
MOV BYTE PTR[EDI + 1], 4
MOV BYTE PTR[EDI + 2], 0
MOV BYTE PTR[EDI + 3], 0
MOV BYTE PTR[EDI + 4], 3
MOV BYTE PTR[EDI + 5], 4
MOV BYTE PTR[EDI + 6], 1
MOV BYTE PTR[EDI + 7], 1
MOV BYTE PTR[EDI + 8], 1
MOV BYTE PTR[EDI + 9], 1
MOV BYTE PTR[EDI + 10], 0

@





MOV EDI, $RUNLEVELS
MOV BYTE PTR[EDI + 4], 1;// INIT SELECT1






INVOKE RecalculateLatency, $PACKETS_LOST


MOV EAX, 0
MOV EDX, $PACKETS_LOST
MOV AX, WORD PTR[EDX + 6];// SEND BBS LATENCY


INVOKE DisplayScreen,
$RUNLEVELS,
$BOARD,
$PLAYERS,
$PACKETS_LOST,
EAX,
DEFAULT_COLORS_,
CURSOR_AVAILABLE_COLORS_,
CURSOR_UNAVAILABLE_COLORS_,
PLAYER_1_COLORS_,
PLAYER_2_COLORS_,
WINNER_SQUARE_COLORS_,
NOT_WINNER_SQUARE_COLORS_





DOIT:



MOV EBX, $RUNLEVELS
CMP BYTE PTR[EBX], 5;// IS IT CLOSING TIME AT THE ARCADE?
JZ GameOver



INVOKE ArcadeControl, $RUNLEVELS, $BOARD, $PLAYERS, $PACKETS_LOST, DELAY_DURATION_LONG_



INVOKE RecalculateLatency, $PACKETS_LOST



MOV EAX, 0
MOV EDX, $PACKETS_LOST
MOV AX, WORD PTR[EDX + 6];// SEND BBS LATENCY


INVOKE DisplayScreen,
$RUNLEVELS,
$BOARD,
$PLAYERS,
$PACKETS_LOST,
EAX,
DEFAULT_COLORS_,
CURSOR_AVAILABLE_COLORS_,
CURSOR_UNAVAILABLE_COLORS_,
PLAYER_1_COLORS_,
PLAYER_2_COLORS_,
WINNER_SQUARE_COLORS_,
NOT_WINNER_SQUARE_COLORS_



MOV EBX, $RUNLEVELS
CMP BYTE PTR[EBX + 3], 0;// IS THE GAME OVER?
JNA DOIT




INVOKE StubbornKeysPatentPending, $PACKETS_LOST




JMP DOIT




GameOver :



;// JMP HardReset



RET
TicTacDoh ENDP
;//==========================================================================








ArcadeControl PROC,
	$CTRL_RUNLEVELS : PTR DWORD,
	$CTRL_BOARD : PTR DWORD,
	$CTRL_PLAYERS : PTR DWORD,
	$CTRL_PACKETS_LOST : PTR DWORD,
	_DELAY_LONG : DWORD
;//==========================================================================
;// DESC:  CONTROLS GAME I/O                                                #
;//==========================================================================


COMMENT @

CMP $CTRL_RUNLEVELS, 0
CMP $CTRL_BOARD, 0
CMP $CTRL_PLAYERS, 0
CMP _DELAY_LONG, 0

@

MOV EBX, $CTRL_RUNLEVELS
MOV EDI, $CTRL_BOARD
MOV ESI, $CTRL_PLAYERS



MOV EAX, 'U';// PRIME THIS


MOV EDX, 0
MOV DL, BYTE PTR[ESI];// GET NEXT PLAYER
CMP BYTE PTR[ESI + EDX], 2;// IS NEXT PLAYER CPU
JA NoInput;// CPU PLAYERS CAN'T PRESS ANY STUBBORN KEYS



INVOKE StubbornKeysPatentPending, $CTRL_PACKETS_LOST


NoInput :


MOV EBX, $CTRL_RUNLEVELS
MOV EDI, $CTRL_BOARD
MOV ESI, $CTRL_PLAYERS




CMP BYTE PTR[EBX + 0], 0;// IS RL1 AS P1 SET
JA Select2

;// DoSelect1:

CMP EAX, 'E'
JZ Select1E

CMP EAX, 'U'
JZ Select1U

CMP EAX, 'D'
JZ Select1D

JMP EndCtrl



Select1E :



MOV EAX, 0
MOV AL, BYTE PTR[EBX + 4];// GET SELECT1

CMP AL, 0
JZ Select1EInit

MOV BYTE PTR[EBX + 0], AL;// SET P1
MOV BYTE PTR[EBX + 5], 1;// PRIME SELECT2
MOV BYTE PTR[EBX + 7], 1;// DISABLE EXIT

JMP EndCtrl


Select1EInit :
MOV BYTE PTR[EBX + 4], 1;// SET SELECT1

JMP EndCtrl


Select1U :

CMP BYTE PTR[EBX + 4], 2
JB EndCtrl;// CAN'T GO UP FROM POSITION 1 OR 0

DEC BYTE PTR[EBX + 4];// ELSE MOVE SELECT1 UP

JMP EndCtrl


Select1D :

CMP BYTE PTR[EBX + 4], 4
JA EndCtrl;// CAN'T GO DOWN FROM POSITION 5

INC BYTE PTR[EBX + 4];// ELSE MOVE SELECT1 UP

JMP EndCtrl






Select2:


CMP BYTE PTR[EBX + 1], 0;// IS RL2 AS P2 SET
JA Select3


CMP EAX, 'E'
JZ Select2E

CMP EAX, 'U'
JZ Select2U

CMP EAX, 'D'
JZ Select2D

JMP EndCtrl




Select2E :


MOV EAX, 0
MOV AL, BYTE PTR[EBX + 5];// GET SELECT2

CMP AL, 5;// GO BACK
JZ GoBack2To1

CMP AL, BYTE PTR[EBX + 0]
JZ EndCtrl;// CANNOT SET, SAME PLAYER

MOV BYTE PTR[EBX + 1], AL;// SET P2
MOV BYTE PTR[EBX + 8], 1;// DISABLE BACK
MOV BYTE PTR[EBX + 6], 1;// HIGHLIGHT PLAY GAME SELECT3
MOV BYTE PTR[EBX + 9], 1;// SHOW S3 BACK


JMP EndCtrl



Select2U :

CMP BYTE PTR[EBX + 5], 2
JB EndCtrl;// CAN'T GO UP FROM POSITION 1 OR 0

DEC BYTE PTR[EBX + 5];// ELSE MOVE SELECT1 UP

JMP EndCtrl



Select2D :

CMP BYTE PTR[EBX + 5], 4
JA EndCtrl;// CAN'T GO DOWN FROM POSITION 5

INC BYTE PTR[EBX + 5];// ELSE MOVE SELECT1 UP

JMP EndCtrl



GoBack2To1 :

MOV BYTE PTR[EBX + 5], 0;// SET SELECT2 TO 0
MOV BYTE PTR[EBX + 0], 0;// UNSET P1
MOV BYTE PTR[EBX + 7], 0
MOV BYTE PTR[EBX + 8], 0

JMP EndCtrl






Select3:


CMP BYTE PTR[EBX + 9], 2;// PLAY SET TO SHADE
JZ PlayGame

CMP BYTE PTR[EBX + 3], 0;// PLAY SET TO HIGHLIGHT
JA PlayGame


CMP EAX, 'E'
JZ Select3E

CMP EAX, 'U'
JZ Select3U

CMP EAX, 'D'
JZ Select3D

JMP EndCtrl



Select3E :


MOV EAX, 0
MOV AL, BYTE PTR[EBX + 6];// GET SELECT3

CMP AL, 5;// GO BACK
JZ GoBack3To2

MOV BYTE PTR[EBX + 8], 1;// DISABLE BACK
MOV BYTE PTR[EBX + 9], 2;// PLAYING GAME NOW

JMP PlayGame



Select3U :

CMP BYTE PTR[EBX + 6], 1
JZ EndCtrl;// CAN'T GO UP FROM POSITION 1

MOV BYTE PTR[EBX + 6], 1;// ELSE MOVE SELECT3 UP

JMP EndCtrl



Select3D :

CMP BYTE PTR[EBX + 6], 5
JZ EndCtrl;// CAN'T GO DOWN FROM POSITION 5

MOV BYTE PTR[EBX + 6], 5;// ELSE MOVE SELECT3 DOWN TO BACK

JMP EndCtrl



GoBack3To2 :

MOV BYTE PTR[EBX + 1], 0;// UNSET P2
MOV BYTE PTR[EBX + 1], 0;// SET SELECT2 TO 1
MOV BYTE PTR[EBX + 6], 0;// SET SELECT3 TO 0
MOV BYTE PTR[EBX + 7], 1;// DISABLE S1 BACK
MOV BYTE PTR[EBX + 8], 0;// ENABLE S2 BACK
MOV BYTE PTR[EBX + 9], 0;// DISABLE S3 BACK

JMP EndCtrl





PlayGame:


CMP BYTE PTR[EBX + 3], 0;// IS GAME OVER
JA SoftReset

;// CMP BYTE PTR[EBX + 2], 0;// HAVE 0 MOVES BEEN MADE
CMP BYTE PTR[EDI], 0;// IS CURSOR EMPTY
JZ InitGame;// CAN'T GO DOWN FROM POSITION 5


MOV EDX, 0
MOV DL, BYTE PTR[ESI];// GET NEXT PLAYER

;// CMP BYTE PTR[ESI + EDX], 3;// IS NEXT PLAYER BETTIE
;// JZ DoBettieAI

;// CMP BYTE PTR[ESI + EDX], 4;// IS NEXT PLAYER JUGHED
;// JZ DoJughedAI


CMP BYTE PTR[ESI + EDX], 2;// IS NEXT PLAYER CPU
JA DoCPU



DoRecalc :

INVOKE RecalculatePosition, $CTRL_RUNLEVELS, $CTRL_BOARD, $CTRL_PLAYERS, EAX

JMP EndCtrl




DoCPU :



MOV EBX, $CTRL_RUNLEVELS


MOV EAX, 0
MOV AL, BYTE PTR[EBX + 2];// NUMBER OF MOVES
MOV BYTE PTR[EBX + 10], AL;// BACK UP TO BUFFER


MOV BYTE PTR[EDI], 5;// CPU IS SO DUMB IT ALWAYS STARTS FROM THE MIDDLE



INVOKE RecalculatePosition, $CTRL_RUNLEVELS, $CTRL_BOARD, $CTRL_PLAYERS, 'E'
;// WEIRDA$$ HAX MAKES THE PROGRAM NOT CRASH RANDOMLY. IT DOESN'T ALWAYS WORK



DoCPULoop:


INVOKE DoRandomRange, 0, 25;// EVENTUALLY THE CPU WILL GUESS HOW TO PLAY ...

ADD EAX, 'A';// ... BY PRESSING ALL THE KEYS! THAT'S ABOUT AS DUMB AS THEY COME


INVOKE RecalculatePosition, $CTRL_RUNLEVELS, $CTRL_BOARD, $CTRL_PLAYERS, EAX


MOV EBX, $CTRL_RUNLEVELS

MOV EAX, 0
MOV AL, BYTE PTR[EBX + 10];// RESTORE FROM BUFFER

CMP AL, BYTE PTR[EBX + 2];// TEST IF A MOVE HAS BEEN MADE BLINDLY IN THE DARK
JNZ BreakCPULoop

CMP BYTE PTR[EBX + 3], 0;// TEST IF THE GAME IS OVER
JNZ BreakCPULoop

JMP DoCPULoop


BreakCPULoop :


INVOKE DoDelay, _DELAY_LONG

;// INVOKE DoDelay, 300



JMP EndCtrl






InitGame:


CMP BYTE PTR[EDI], 0;// IS CURSOR EMPTY
JNZ DoRecalc;// CURSOR MEANS GAME STARTED


MOV BYTE PTR[EDI], 5;// OFFICIALLY START GAME


MOV BYTE PTR[EBX + 9], 2;// SET PLAY TO SHADE

MOV EDX, 0

MOV DL, BYTE PTR[EBX + 0];// GET P1 IDENTITY IN RL0
MOV BYTE PTR[ESI + 1], DL;// SET P1 IDENTITY IN PLAYERS

MOV DL, BYTE PTR[EBX + 1];// GET P2 IDENTITY IN RL1
MOV BYTE PTR[ESI + 2], DL;// SET P2 IDENTITY IN PLAYERS


PUSH EAX;// BACKUP KEY CODE


INVOKE DoRandomRange, 1, 2;// RETURNS X PLAYER AS EAX


;// DEBUG:
;// MOV EAX, 2;// MANUAL SET PLAYER X


MOV BYTE PTR[ESI + 0], AL;// NEXT UP IS PLAYER X


MOV BYTE PTR[ESI + 24], AL;// STORE PLAYER X AS P1 OR P2


MOV DL, BYTE PTR[ESI + EAX];// GET P1 IDENTITY IN RL0


MOV BYTE PTR[ESI + EDX * 4], 'X';// STORE X STAMP FOR PLAYER X
MOV EDX, 3
SUB DL, AL
MOV BYTE PTR[ESI + 25], DL;// STORE PLAYER 0 AS P1 OR P2


MOV AL, BYTE PTR[ESI + EDX];// GET P1 IDENTITY IN RL0
MOV BYTE PTR[ESI + EAX * 4], 'O';// STORE X STAMP FOR PLAYER X


POP EAX;// RESTORE KEY CODE


JMP EndCtrl





SoftReset:

;// [0] P1 NOT SET 0; P1 SET 1-4
;// [1] P2 NOT SET 0; P2 SET 1 - 4
;// [2] NUMBER OF MOVES PLAYED 0-9
;// [3] NO WINNER 0; WINNER IDENTITY 1-4; DRAW 5
;// [4] SELECT1: HIGHLIGHT IDENTITY WITH EXIT 1-4; HIGHLIGHT EXIT 5
;// [5] SELECT2: DO NOT HIGHLIGHT 0; HIGHLIGHT IDENTITY 1-4; HIGHLIGHT BACK 5
;// [6] SELECT3: DO NOT HIGHLIGHT 0; HIGHLIGHT PLAY 1; SHADE PLAY/START GAME 2; HIGHLIGHT BACK 5
;// [7] SHOW SELECT1 EXIT 0; HIDE SELECT1 EXIT 1
;// [8] HIDE SELECT2 BACK 0; SHOW SELECT2 BACK 1
;// [9] HIDE SELECT3 BACK 0; SHOW SELECT3 BACK 1
;// [10] DATA BUFFER


MOV BYTE PTR[EBX + 2], 0
MOV BYTE PTR[EBX + 3], 0
MOV BYTE PTR[EBX + 6], 1
MOV BYTE PTR[EBX + 9], 1
INVOKE ResetData, $CTRL_PLAYERS, 3, 0
INVOKE ResetData, $CTRL_BOARD, 10, 0






EndCtrl:



RET
ArcadeControl ENDP
;//==========================================================================










DoDelay PROC,
	_DELAY_DURATION : DWORD
;//==========================================================================
;// DESC:  RUNS IRVINE32 DELAY                                              #
;//==========================================================================

MOV EAX, _DELAY_DURATION
CALL Delay

RET
DoDelay ENDP
;//==========================================================================








DoRandomRange PROC,
	_RAND_MIN : DWORD,
	_RAND_MAX : DWORD
;//==========================================================================
;// DESC:     RUNS IRVINE32 RANDOMRANGE                                     #
;// RETURNS:  EAX AS RANDOM VALUE IN RANGE                                  #
;//==========================================================================

MOV EAX, _RAND_MAX
SUB EAX, _RAND_MIN
INC EAX
CALL RandomRange

MOV ECX, _RAND_MIN
ADD AL, CL

RET
DoRandomRange ENDP
;//==========================================================================








ResetData PROC,
	$RESET_PTR : PTR DWORD,
	$RESET_BYTES : DWORD,
	$RESET_VALUE : DWORD
;//==========================================================================
;// DESC:    OBLITERATES DATA                                               #
;// WARNING: THIS PROCEDURE WILL TRY TO TRASH WHATEVER YOU ASK IT TO TRASH  #
;//==========================================================================

MOV EAX, $RESET_VALUE
MOV EDI, $RESET_PTR
MOV ECX, $RESET_BYTES
CLD
REP STOSB;// MOV BYTE PTR [EDI], EAX

RET
ResetData ENDP
;//==========================================================================











StubbornKeysPatentPending PROC,
	$KEY_PACKETS_LOST : PTR DWORD
;//==========================================================================
;// DESC: RETURNS {'U', 'D', 'L', 'R', 'E'} CORRESPONDING TO ARROW OR ENTER #
;// RET:  EAX AS ENTER OR ARROW KEY CODE CHAR LISTED ABOVE                  #
;// NOTE: IF THE KEYS SEEM "STUBBORN" TO YOU, IT'S PROBABLY IRVINE32'S FAULT#
;//==========================================================================



MOV EDI, [$KEY_PACKETS_LOST];// ADDRESS FOR TRULYRANDOM DATA



DO:


INC BYTE PTR[EDI];// ROUND AND ROUND AND ROUND THE BYTE PTR GOES


CALL ReadKey;// WHERE THE BYTE PTR STOPS, NOBODY KNOWS



;// DEBUG FOR COMPREHENSION:
;// UNCOMMENT NEXT BLOCK:


;// CALL WRITEHEX
;// MOV EAX, '	'
;// CALL WRITECHAR
;// MOV EAX, EDX
;// CALL WRITEHEX
;// CALL CRLF

;// INVOKE DoDelay, 500

;// JMP DO





CMP EAX, 1C0DH;// FIRST PASS
JZ SETENTER

CMP AL, 0
JNZ DO

CMP DL, 25H
JB DO

CMP DL, 28H
JA DO


CMP DL, 26H;// SECOND PASS
JZ SETUP

CMP DL, 28H
JZ SETDOWN

CMP DL, 25H
JZ SETLEFT

CMP DL, 27H
JZ SETRIGHT


SETUP :
MOV EAX, 'U'
JMP DOEND

SETDOWN :
MOV EAX, 'D'
JMP DOEND

SETLEFT :
MOV EAX, 'L'
JMP DOEND

SETRIGHT :
MOV EAX, 'R'
JMP DOEND

SETENTER :
MOV EAX, 'E'


DOEND :


MOV BYTE PTR[EDI + 1], 1;// TRULYRANDOM VALID FLAG NOW SET; ENJOY FOR A TRULY RANDOM EXPERIENCE


;// CALL WriteChar
;// JMP DO


RET
StubbornKeysPatentPending ENDP
;//==========================================================================










DisplayScreen PROC,
	$DISP_RUNLEVELS : PTR DWORD,
	$DISP_BOARD : PTR DWORD,
	$DISP_PLAYERS : PTR DWORD,
	$DISP_PACKETS_LOST : PTR DWORD,
	_DISP_BBS_LATENCY : DWORD,
	_DEFAULT_COLORS : DWORD,
	_CURSOR_AVAILABLE_COLORS : DWORD,
	_CURSOR_UNAVAILABLE_COLORS : DWORD,
	_PLAYER_1_COLORS : DWORD,
	_PLAYER_2_COLORS : DWORD,
	_WINNER_SQUARE_COLORS : DWORD,
	_NOT_WINNER_SQUARE_COLORS : DWORD
	LOCAL DISP_X_P1P2$ : BYTE
;//==========================================================================
;// DESC:  DISPLAYS THE GAME GRID                                           #
;//==========================================================================



SENTINEL_ = 0



.DATA



GRID$ DB "*"
DB  "----------------------------------------------*---------------*--------------*", 0DH, 0AH
DB "|                                              |A|              |", 0DH, 0AH
DB "|   *-----*-----*-----*                        *---------------*              |", 0DH, 0AH
DB "|   |11111|22222|33333|        *-------------*                   *-------*    |", 0DH, 0AH
DB "|   |11#11|22#22|33#33|        |B|                   |C|    |", 0DH, 0AH
DB "|   |11111|22222|33333|        *-------------*                   *-------*    |", 0DH, 0AH
DB "|   *-----*-----*-----*        |D|", 0DH, 0AH
DB "|   |44444|55555|66666|        *-------------*          E|", 0DH, 0AH
DB "|   |44#44|55#55|66#66| F|", 0DH, 0AH
DB "|   |44444|55555|66666| G|", 0DH, 0AH
DB "|   *-----*-----*-----* H|", 0DH, 0AH
DB "|   |77777|88888|99999| I|", 0DH, 0AH
DB "|   |77#77|88#88|99#99| J|", 0DH, 0AH
DB "|   |77777|88888|99999| K|", 0DH, 0AH
DB "|   *-----*-----*-----* L|", 0DH, 0AH
DB "|M|", 0DH, 0AH
DB "*------------------------*-------------------------*--------------------------*", 0DH, 0AH
DB "|N|", 0DH, 0AH
DB "*O|", 0DH, 0AH
DB "|P|", 0DH, 0AH
DB "|Q|", 0DH, 0AH
DB "|R|", 0DH, 0AH
DB "|S|", 0DH, 0AH
DB "|T|", 0DH, 0AH
DB "*------------------------*-------------------------*--------------------------*"
DB 0







.CODE


COMMENT @

CMP $DISP_BOARD, 0
CMP $DISP_PACKETS_LOST, 0
CMP _DISP_BBS_LATENCY, 0
CMP _DEFAULT_COLORS, 0
CMP _CURSOR_AVAILABLE_COLORS, 0
CMP _CURSOR_UNAVAILABLE_COLORS, 0

@


MOV EAX, 0
MOV ESI, $DISP_PLAYERS
MOV AL, BYTE PTR[ESI + 24];// IS X P1 OR P2
MOV DISP_X_P1P2$, AL


MOV ESI, OFFSET GRID$

MOV EBX, [$DISP_BOARD];// ADDRESS OF BOARD


;// MOV BYTE PTR[EBX], 3;// DEBUG


MOV ECX, 0
MOV CL, BYTE PTR[EBX];// CURSOR POSITION


MOV EDI, 0;// CURRENT VISITED GRID POSITION




CALL ClrScr



DrawGridLoop :



MOV EDX, ECX
ADD EDX, '1'
DEC DL;// CURSOR POSITION AS ASCII

MOV AL, [ESI];// CURRENT GRID CHAR


CMP AL, 0
JZ GridDone

CMP AL, '*'
JZ WriteCorner

CMP AL, '#'
JZ VisitPosition

CMP AL, '1'
JB WriteNormal

CMP AL, '9'
JA WriteSub





;// WriteCodedSpace:



CMP AL, DL;// TEST IF AT CURSOR POSITION
JZ WriteCursorSpace



MOV EDX, $DISP_RUNLEVELS
CMP BYTE PTR[EDX + 3], 5;// IS IT A DRAW
JZ WriteDrawOpenSpace;// IT'S A DRAW


CMP BYTE PTR[EDX + 3], 0;// IS THERE A WINNER
JA WriteDrawOpenSpaceWithWinner;// THERE'S A WINNER





;// WriteNotCursorSpace:
SUB AL, '0'

CMP BYTE PTR[EBX + EAX], SENTINEL_;// IS THE SPOT STILL OPEN?
JZ ActuallyWriteSpace;// DIRTY DIRTY DIRTY HACK; VERY NAUGHTY

CMP BYTE PTR[EBX + EAX], 'X';// DOES 'X' MARK THE SPOT?
JNZ DoPAPisO

;// DoPAPisX
MOV EAX, ' '
PUSH EAX
JMP PAPisX;// SCROLL WAY DOWN

DoPAPisO:
MOV EAX, ' '
PUSH EAX
JMP PAPisO;// SCROLL WAY DOWN


WriteCursorSpace:

MOV EDX, $DISP_RUNLEVELS



CMP BYTE PTR[EBX + ECX], SENTINEL_;// IS SPOT AVAILABLE
JZ WriteCursorOpenSpace


WriteDrawOpenSpace :


MOV EAX, _CURSOR_UNAVAILABLE_COLORS
CALL SetTextColor

JMP ActuallyWriteSpace


WriteCursorOpenSpace :


CMP BYTE PTR[EDX + 3], 5;// IS IT A DRAW
JZ WriteDrawOpenSpace;// IT'S A DRAW


MOV EAX, _CURSOR_AVAILABLE_COLORS
CALL SetTextColor


ActuallyWriteSpace :


MOV EAX, ' '

CALL WriteChar

MOV EAX, _DEFAULT_COLORS
CALL SetTExtColor

JMP CharWritten





WriteCorner:
MOV EAX, 'O'


WriteNormal :
CALL WriteChar


CharWritten :


INC ESI;// PRIME NEXT GRID READ
INVOKE DoDelay, _DISP_BBS_LATENCY

JMP DrawGridLoop;// GET NEXT GRID CHARACTER






WriteDrawOpenSpaceWithWinner:


CMP BYTE PTR[EDX + 2], 1;// IS WINNER AT TOP ROW
JZ DrawWinnerTopRow

CMP BYTE PTR[EDX + 2], 2;// IS WINNER AT TOP ROW
JZ DrawWinnerMiddleRow

CMP BYTE PTR[EDX + 2], 3;// IS WINNER AT TOP ROW
JZ DrawWinnerBottomRow

CMP BYTE PTR[EDX + 2], 4;// IS WINNER AT TOP ROW
JZ DrawWinnerLeftCol

CMP BYTE PTR[EDX + 2], 5;// IS WINNER AT TOP ROW
JZ DrawWinnerMiddleCol

CMP BYTE PTR[EDX + 2], 6;// IS WINNER AT TOP ROW
JZ DrawWinnerRightCol

CMP BYTE PTR[EDX + 2], 7;// IS WINNER AT TOP ROW
JZ DrawWinnerDiagSE

CMP BYTE PTR[EDX + 2], 8;// DISREGARD COMMENTS ABOVE
JZ DrawWinnerDiagSW



DrawWinnerTopRow :
CMP AL, '1'
JZ WriteWinnerSquare
CMP AL, '2'
JZ WriteWinnerSquare
CMP AL, '3'
JZ WriteWinnerSquare
JMP WriteNotWinnerSquare


DrawWinnerMiddleRow :
CMP AL, '4'
JZ WriteWinnerSquare
CMP AL, '5'
JZ WriteWinnerSquare
CMP AL, '6'
JZ WriteWinnerSquare
JMP WriteNotWinnerSquare


DrawWinnerBottomRow :
CMP AL, '7'
JZ WriteWinnerSquare
CMP AL, '8'
JZ WriteWinnerSquare
CMP AL, '9'
JZ WriteWinnerSquare
JMP WriteNotWinnerSquare


DrawWinnerLeftCol :
CMP AL, '1'
JZ WriteWinnerSquare
CMP AL, '4'
JZ WriteWinnerSquare
CMP AL, '7'
JZ WriteWinnerSquare
JMP WriteNotWinnerSquare


DrawWinnerMiddleCol :
CMP AL, '2'
JZ WriteWinnerSquare
CMP AL, '5'
JZ WriteWinnerSquare
CMP AL, '8'
JZ WriteWinnerSquare
JMP WriteNotWinnerSquare


DrawWinnerRightCol :
CMP AL, '3'
JZ WriteWinnerSquare
CMP AL, '6'
JZ WriteWinnerSquare
CMP AL, '9'
JZ WriteWinnerSquare
JMP WriteNotWinnerSquare


DrawWinnerDiagSE :
CMP AL, '1'
JZ WriteWinnerSquare
CMP AL, '5'
JZ WriteWinnerSquare
CMP AL, '9'
JZ WriteWinnerSquare
JMP WriteNotWinnerSquare


DrawWinnerDiagSW :
CMP AL, '3'
JZ WriteWinnerSquare
CMP AL, '5'
JZ WriteWinnerSquare
CMP AL, '7'
JZ WriteWinnerSquare
JMP WriteNotWinnerSquare







VisitPosition:


INC EDI;// EDI CURRENT GRID POSITION VISITED

MOV EAX, 0
MOV AL, BYTE PTR[EBX + EDI];// PULL VALUE/STAMP AT POSITION

MOV EDX, $DISP_RUNLEVELS

CMP BYTE PTR[EDX + 3], 5;// IS IT A DRAW
JZ VisitDraw;// IT'S A DRAW

CMP BYTE PTR[EDX + 3], 0;// IS THERE A WINNER
JA VisitPositionWithWinner;// THERE'S A WINNER


CMP AL, SENTINEL_;// IS POSITION AVAILABLE?
JZ PositionAvailable





;// PositionAlreadyPlayed:

CMP EDI, ECX;// PREVIOUSLY PLAYED POSITION IS EDI; CURSOR IS ECX
JZ CursorAtPositionAlreadyPlayed


PUSH EAX;// BACKUP BOARD CHAR

CMP AL, 'X';// DOES 'X' MARK THE SPOT?
JZ PAPisX

PAPisO :
CMP DISP_X_P1P2$, 2
JZ PAPSetP1Colors;// X IS PLAYER 2

MOV EAX, _PLAYER_2_COLORS
JMP PAPSetColor

PAPSetP1Colors :
MOV EAX, _PLAYER_1_COLORS
JMP PAPSetColor

PAPisX :

CMP DISP_X_P1P2$, 2
JZ PAPSetP2Colors;// X IS PLAYER 2

MOV EAX, _PLAYER_1_COLORS
JMP PAPSetColor

PAPSetP2Colors :
MOV EAX, _PLAYER_2_COLORS
JMP PAPSetColor


PAPSetColor :


CALL SetTextColor


POP EAX;// RESTORE PREEXISTING BOARD CHAR
CALL WriteChar
MOV EAX, _DEFAULT_COLORS
CALL SetTExtColor
JMP CharWritten


CursorAtPositionAlreadyPlayed :


PUSH EAX;// BACKUP BOARD CHAR
MOV EAX, _CURSOR_UNAVAILABLE_COLORS
CALL SetTextColor
POP EAX;// RESTORE BOARD CHAR
CALL WriteChar
MOV EAX, _DEFAULT_COLORS
CALL SetTExtColor
JMP CharWritten


PositionAvailable :


CMP EDI, ECX
JZ CursorAtOpenPosition

MOV EAX, ' '
CALL WriteChar;// NOT CURSOR, OPEN POSITION
JMP CharWritten



CursorAtOpenPosition :


MOV EAX, _CURSOR_AVAILABLE_COLORS
CALL SetTextColor
MOV EAX, "?"
CALL WriteChar
MOV EAX, _DEFAULT_COLORS
CALL SetTExtColor
JMP CharWritten




VisitDraw :


PUSH EAX;// BACKUP BOARD CHAR
MOV EAX, _CURSOR_UNAVAILABLE_COLORS
CALL SetTextColor
POP EAX;// RESTORE BOARD CHAR
CALL WriteChar
MOV EAX, _DEFAULT_COLORS
CALL SetTExtColor
JMP CharWritten




VisitPositionWithWinner :


MOV EDX, $DISP_RUNLEVELS;// UNNECESSARY INSTRUCTION


CMP BYTE PTR[EDX + 2], 1;// IS WINNER AT TOP ROW
JZ VisitWinnerTopRow

CMP BYTE PTR[EDX + 2], 2;// IS WINNER AT TOP ROW
JZ VisitWinnerMiddleRow

CMP BYTE PTR[EDX + 2], 3;// IS WINNER AT TOP ROW
JZ VisitWinnerBottomRow

CMP BYTE PTR[EDX + 2], 4;// IS WINNER AT TOP ROW
JZ VisitWinnerLeftCol

CMP BYTE PTR[EDX + 2], 5;// IS WINNER AT TOP ROW
JZ VisitWinnerMiddleCol

CMP BYTE PTR[EDX + 2], 6;// IS WINNER AT TOP ROW
JZ VisitWinnerRightCol

CMP BYTE PTR[EDX + 2], 7;// IS WINNER AT TOP ROW
JZ VisitWinnerDiagSE

CMP BYTE PTR[EDX + 2], 8;// IS WINNER AT TOP ROW
JZ VisitWinnerDiagSW



VisitWinnerTopRow :
CMP EDI, 1
JZ WriteWinnerChar
CMP EDI, 2
JZ WriteWinnerChar
CMP EDI, 3
JZ WriteWinnerChar
JMP WriteNotWinnerChar


VisitWinnerMiddleRow :
CMP EDI, 4
JZ WriteWinnerChar
CMP EDI, 5
JZ WriteWinnerChar
CMP EDI, 6
JZ WriteWinnerChar
JMP WriteNotWinnerChar


VisitWinnerBottomRow :
CMP EDI, 7
JZ WriteWinnerChar
CMP EDI, 8
JZ WriteWinnerChar
CMP EDI, 9
JZ WriteWinnerChar
JMP WriteNotWinnerChar


VisitWinnerLeftCol :
CMP EDI, 1
JZ WriteWinnerChar
CMP EDI, 4
JZ WriteWinnerChar
CMP EDI, 7
JZ WriteWinnerChar
JMP WriteNotWinnerChar


VisitWinnerMiddleCol :
CMP EDI, 2
JZ WriteWinnerChar
CMP EDI, 5
JZ WriteWinnerChar
CMP EDI, 8
JZ WriteWinnerChar
JMP WriteNotWinnerChar


VisitWinnerRightCol :
CMP EDI, 3
JZ WriteWinnerChar
CMP EDI, 6
JZ WriteWinnerChar
CMP EDI, 9
JZ WriteWinnerChar
JMP WriteNotWinnerChar


VisitWinnerDiagSE :
CMP EDI, 1
JZ WriteWinnerChar
CMP EDI, 5
JZ WriteWinnerChar
CMP EDI, 9
JZ WriteWinnerChar
JMP WriteNotWinnerChar


VisitWinnerDiagSW :
CMP EDI, 3
JZ WriteWinnerChar
CMP EDI, 5
JZ WriteWinnerChar
CMP EDI, 7
JZ WriteWinnerChar
JMP WriteNotWinnerChar




WriteWinnerSquare :
MOV EAX, ' '

WriteWinnerChar :
	PUSH EAX
	MOV EAX, _WINNER_SQUARE_COLORS
	CALL SetTextColor
	POP EAX;// RESTORE STAMP

CALL WriteChar

MOV EAX, _DEFAULT_COLORS
CALL SetTextColor

JMP CharWritten



WriteNotWinnerSquare :
MOV EAX, ' '


WriteNotWinnerChar :
	PUSH EAX
	MOV EAX, _NOT_WINNER_SQUARE_COLORS
	CALL SetTextColor
	POP EAX;// RESTORE STAMP

CALL WriteChar

MOV EAX, _DEFAULT_COLORS
CALL SetTextColor

JMP CharWritten







WriteSub:


CMP AL, 'A'
JB WriteNormal
;// JZ WriteSubA

CMP AL, 'Z'
JA WriteNormal
;// JZ WriteSubW


PUSHAD
INVOKE DisplaySub,
$DISP_RUNLEVELS,
$DISP_BOARD,
$DISP_PLAYERS,
$DISP_PACKETS_LOST,
_DISP_BBS_LATENCY,
_DEFAULT_COLORS,
_CURSOR_AVAILABLE_COLORS,
_CURSOR_UNAVAILABLE_COLORS,
_PLAYER_1_COLORS,
_PLAYER_2_COLORS,
EAX
POPAD
JMP CharWritten





GridDone:



JMP EndDisplay


MOV EDX, 0
MOV EBX, [$DISP_PACKETS_LOST]
MOV EAX, [EBX]

MOV ECX, 3
DIV CL

MOV AH, 0

CALL WriteDec

MOV AL, '%'
CALL WriteChar


EndDisplay :


RET
DisplayScreen ENDP
;//==========================================================================












DisplaySub PROC,
	$SUB_RUNLEVELS : PTR DWORD,
	$SUB_BOARD : PTR DWORD,
	$SUB_PLAYERS : PTR DWORD,
	$SUB_PACKETS_LOST : PTR DWORD,
	_SUB_BBS_LATENCY : DWORD,
	_SUB_DEFAULT_COLORS : DWORD,
	_SUB_CURSOR_AVAILABLE_COLORS : DWORD,
	_SUB_CURSOR_UNAVAILABLE_COLORS : DWORD,
	_SUB_PLAYER_1_COLORS : DWORD,
	_SUB_PLAYER_2_COLORS : DWORD,
	_SUB : DWORD
	LOCAL SUB_X_P1P2$ : BYTE
;//===========================================================================
;// DESC:    DISPLAYS SUBENTRIES AS DEFINED IN THE GAME GRID DATA DEFINITION #
;// REQUIRES: _SUB IS A CHARACTER ASSOCIATED WITH A SUBENTRY IN THE GAME GRID#
;//===========================================================================



INFO_COLOR_ = blue * 16 + lightGray
LABEL_COLOR_ = blue * 16 + lightGray
TITLE_COLOR_ = red * 16 + lightGray



.DATA


SUB_A_010$ DB " Tic-Tac-D'oh! ", 0

SUB_B_000$ DB "PLEASE SELECT", 0
SUB_B_010$ DB " NEXT PLAYER ", 0
SUB_B_020$ DB "   OUTCOME   ", 0
SUB_B_030$ DB "   WINNER!   ", 0
SUB_B_040$ DB " THINKING... ", 0


SUB_C_010$ DB " STATS ", 0


SUB_D_010$ DB "       |", 0
SUB_D_100$ DB "  ", 0
SUB_D_110$ DB " X", 0
SUB_D_120$ DB " O", 0
SUB_D_300$ DB "             ", 0
SUB_D_310$ DB "    ARCHEE ", 0
SUB_D_320$ DB "  VERONIKA ", 0
SUB_D_330$ DB "    BETTIE ", 0
SUB_D_340$ DB "    JUGHED ", 0
SUB_D_350$ DB " IT'S A DRAW ", 0
SUB_D_510$ DB "|            ARCHEE WINS  =  #  ", 0
SUB_D_STAT_INDEX_ = 5


SUB_E_010$ DB "VERONIKA WINS  =  #  ", 0
SUB_E_STAT_INDEX_ = 9

SUB_F_010$ DB "                                  BETTIE WINS  =  #  ", 0
SUB_F_STAT_INDEX_ = 13

SUB_G_010$ DB "    O-------------------O         JUGHED WINS  =  #  ", 0
SUB_G_STAT_INDEX_ = 17

SUB_H_010$ DB "    |@   INSTRUCTIONS:   &|             P1 WINS  =  #  ", 0
SUB_H_STAT_INDEX_ = 21

SUB_I_010$ DB "    |@ ARROW KEYS:  MOVE &|             P2 WINS  =  #  ", 0
SUB_I_STAT_INDEX_ = 22

SUB_J_010$ DB "    |@ ENTER KEY: SELECT &|               DRAWS  =  #  ", 0
SUB_J_STAT_INDEX_ = 20

SUB_K_010$ DB "    O-------------------O        GAMES PLAYED  =  #  ", 0
SUB_K_STAT_INDEX_ = 3

SUB_L_010$ DB "                                                      ", 0

SUB_M_010$ DB "                            BBS BAUDRATE = #", "	", " CALL QUALITY  =  *% ", 0

SUB_N_010$ DB "!    PLAYER 1   SELECT   @|#    PLAYER 2   SELECT    $|                          ", 0
SUB_O_010$ DB "------------------------O-------------------------O                          ", 0
SUB_P_010$ DB "    ! ARCHEE   (HUMAN)@   |    # ARCHEE   (HUMAN)$    |     O---------------O    ", 0
SUB_Q_010$ DB "    !VERONIKA  (HUMAN)@   |    #VERONIKA  (HUMAN)$    |     |%  PLAY   GAME  ^|    ", 0
SUB_R_010$ DB "    ! BETTIE    (CPU) @   |    # BETTIE    (CPU) $    |     O---------------O    ", 0
SUB_S_010$ DB "    ! JUGHED    (CPU) @   |    # JUGHED    (CPU) $    |                          ", 0

SUB_T_010$ DB "    !<======EXIT======@   |                         |                          ", 0
SUB_T_020$ DB "                        |    #<======BACK======$    |                          ", 0
SUB_T_030$ DB "                        |                         |     %<======BACK======^    ", 0
SUB_T_040$ DB "                        |                         |                          ", 0





.CODE



CMP $SUB_BOARD, 0
CMP $SUB_PACKETS_LOST, 0
CMP _SUB_BBS_LATENCY, 0
CMP _SUB_DEFAULT_COLORS, 0
CMP _SUB_CURSOR_AVAILABLE_COLORS, 0
CMP _SUB_CURSOR_UNAVAILABLE_COLORS, 0
CMP _SUB_PLAYER_1_COLORS, 0
CMP _SUB_PLAYER_2_COLORS, 0



MOV EAX, 0
MOV EAX, $SUB_PLAYERS[24];// IS X P1 OR P2
MOV SUB_X_P1P2$, AL



MOV ESI, 0



CMP _SUB, 'A'
JZ WriteSubA

CMP _SUB, 'B'
JZ WriteSubB

CMP _SUB, 'C'
JZ WriteSubC

CMP _SUB, 'D'
JZ WriteSubD

CMP _SUB, 'E'
JZ WriteSubE

CMP _SUB, 'F'
JZ WriteSubF

CMP _SUB, 'G'
JZ WriteSubG

CMP _SUB, 'H'
JZ WriteSubH

CMP _SUB, 'I'
JZ WriteSubI

CMP _SUB, 'J'
JZ WriteSubJ

CMP _SUB, 'K'
JZ WriteSubK

CMP _SUB, 'L'
JZ WriteSubL

CMP _SUB, 'M'
JZ WriteSubM

CMP _SUB, 'N'
JZ WriteSubN

CMP _SUB, 'O'
JZ WriteSubO

CMP _SUB, 'P'
JZ WriteSubP

CMP _SUB, 'Q'
JZ WriteSubQ

CMP _SUB, 'R'
JZ WriteSubR

CMP _SUB, 'S'
JZ WriteSubS

CMP _SUB, 'T'
JZ WriteSubT




WriteSubA :


MOV EAX, 0
MOV AL, TITLE_COLOR_
CALL SetTextColor

MOV ESI, OFFSET SUB_A_010$

WriteSubA010 :

MOV AL, BYTE PTR[ESI]
CMP AL, 0
JZ EndSubA

CALL WriteChar
INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubA010


EndSubA :

MOV EAX, _SUB_DEFAULT_COLORS
CALL SetTextColor

JMP SubWritten





WriteSubB:

MOV EAX, 0


MOV ESI, $SUB_PLAYERS


CMP BYTE PTR[ESI], 0;// NO NEXT PLAYER
JZ WriteSubB000;// PLEASE SELECT


MOV ESI, $SUB_RUNLEVELS


CMP BYTE PTR[ESI + 3], 5
JZ WriteSubB020;// OUTCOME

CMP BYTE PTR[ESI + 3], 0
JA WriteSubB030;// WINNER!


MOV ESI, $SUB_PLAYERS


MOV DL, BYTE PTR[ESI];// NEXT PLAYER P1 P2
MOV AL, BYTE PTR[ESI + EDX];// NEXT PLAYER IDENTITY
CMP EAX, 2;// IS PLAYER CPU
JA WriteSubB040;// THINKING...


JMP WriteSubB010;// NEXT PLAYER


WriteSubB000:
MOV AL, TITLE_COLOR_
CALL SetTextColor
MOV ESI, OFFSET SUB_B_000$
JMP WriteSubB100


WriteSubB010 :
MOV AL, LABEL_COLOR_
CALL SetTextColor
MOV ESI, OFFSET SUB_B_010$
JMP WriteSubB100

WriteSubB020 :
MOV EAX, _SUB_CURSOR_UNAVAILABLE_COLORS
CALL SetTextColor
MOV ESI, OFFSET SUB_B_020$
JMP WriteSubB100


WriteSubB040 :
MOV EAX, _SUB_CURSOR_UNAVAILABLE_COLORS
CALL SetTextColor
MOV ESI, OFFSET SUB_B_040$
JMP WriteSubB100



WriteSubB030 :

MOV ESI, $SUB_PLAYERS
CMP BYTE PTR[ESI], 2
JZ WriteSubB030SetP2Colors

MOV EAX, _SUB_PLAYER_1_COLORS
JMP WriteSubB030SetColors

WriteSubB030SetP2Colors :

MOV EAX, _SUB_PLAYER_2_COLORS

WriteSubB030SetColors :
CALL SetTextColor


MOV ESI, OFFSET SUB_B_030$
JMP WriteSubB100


WriteSubB100 :

MOV AL, BYTE PTR[ESI]
CMP AL, 0
JZ EndSubB

CALL WriteChar
INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubB100


EndSubB :

MOV EAX, _SUB_DEFAULT_COLORS
CALL SetTextColor

JMP SubWritten





WriteSubC:


MOV EAX, 0
MOV AL, LABEL_COLOR_
CALL SetTextColor

MOV ESI, OFFSET SUB_C_010$

WriteSubC010 :

MOV AL, BYTE PTR[ESI]
CMP AL, 0
JZ EndSubC

CALL WriteChar
INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubC010


EndSubC :

MOV EAX, _SUB_DEFAULT_COLORS
CALL SetTextColor

JMP SubWritten




WriteSubD :


MOV EAX, 0

WriteSubD100 :


	MOV ESI, $SUB_PLAYERS
	MOV EAX, 0
	MOV AL, [ESI];// NEXT PLAYER NUMBER

CMP AL, 0
JZ WriteSubD300;// NO NEXT PLAYER, PLEASE SELECT

CMP AL, 5
JZ WriteSubD350;// IT'S A DRAW!

PUSH EAX
CMP AL, 2
JZ WriteSubD100SetP2Colors

MOV EAX, _SUB_PLAYER_1_COLORS
JMP WriteSubD100SetColors

WriteSubD100SetP2Colors :

MOV EAX, _SUB_PLAYER_2_COLORS

WriteSubD100SetColors :
CALL SetTextColor
POP EAX

CMP BYTE PTR[ESI + 24], AL;// IS X THE NEXT PLAYER
JZ WriteSubD110;// X IS NEXT
JMP WriteSubD120;// ELSE O IS NEXT


WriteSubD110:
MOV ESI, OFFSET SUB_D_110$
JMP WriteSubD200

WriteSubD120 :
MOV ESI, OFFSET SUB_D_120$
;// JMP WriteSubD200


WriteSubD200:


MOV AL, BYTE PTR[ESI]
CMP AL, 0
JZ WriteSubD300

CALL WriteChar
INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubD200




WriteSubD300 :


MOV ESI, $SUB_PLAYERS
MOV EAX, 0
MOV AL, [ESI];// NEXT PLAYER NUMBER

CMP BYTE PTR[ESI + EAX], 1
JZ WriteSubD310

CMP BYTE PTR[ESI + EAX], 2
JZ WriteSubD320

CMP BYTE PTR[ESI + EAX], 3
JZ WriteSubD330

CMP BYTE PTR[ESI + EAX], 4
JZ WriteSubD340


MOV ESI, OFFSET SUB_D_300$
JMP WriteSubD400


WriteSubD310 :
MOV ESI, OFFSET SUB_D_310$
JMP WriteSubD400

WriteSubD320 :
MOV ESI, OFFSET SUB_D_320$
JMP WriteSubD400

WriteSubD330 :
MOV ESI, OFFSET SUB_D_330$
JMP WriteSubD400

WriteSubD340 :
MOV ESI, OFFSET SUB_D_340$
JMP WriteSubD400


WriteSubD350 :
MOV ESI, OFFSET SUB_D_350$;// IT'S A DRAW!
MOV EAX, _SUB_CURSOR_UNAVAILABLE_COLORS
CALL SetTextColor

;// JMP WriteSubD400


WriteSubD400:

MOV AL, BYTE PTR[ESI]
CMP AL, 0
JZ EndSubD400

CALL WriteChar
INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubD400


EndSubD400 :


MOV EAX, _SUB_DEFAULT_COLORS
CALL SetTextColor


MOV EAX, 0
MOV ESI, OFFSET SUB_D_510$

WriteSubD510 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubD

CMP AL, '#'
JZ WriteSubDStat

CALL WriteChar

WroteSubDStat :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubD510


WriteSubDStat :

MOV EDX, $SUB_PLAYERS
MOV AL, BYTE PTR[EDX + SUB_D_STAT_INDEX_]
CMP AL, 9;// IS IT SINGLE DIGIT
JA WriteSubFStatSkipZero

PUSH EAX
MOV AL, '0'
CALL WriteChar
INVOKE DoDelay, _SUB_BBS_LATENCY
POP EAX

WriteSubDStatSkipZero :

CALL WriteDec
JMP WroteSubDStat


EndSubD :

JMP SubWritten






WriteSubE:

MOV EAX, 0
MOV ESI, OFFSET SUB_E_010$


WriteSubE010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubE

CMP AL, '#'
JZ WriteSubEStat

CALL WriteChar

WroteSubEStat :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubE010


WriteSubEStat :

MOV EDX, $SUB_PLAYERS
MOV AL, BYTE PTR[EDX + SUB_E_STAT_INDEX_]
CMP AL, 9;// IS IT SINGLE DIGIT
JA WriteSubEStatSkipZero

PUSH EAX
MOV AL, '0'
CALL WriteChar
INVOKE DoDelay, _SUB_BBS_LATENCY
POP EAX

WriteSubEStatSkipZero :

CALL WriteDec
JMP WroteSubEStat


EndSubE :

JMP SubWritten







WriteSubF:


MOV EAX, 0
MOV ESI, OFFSET SUB_F_010$

WriteSubF010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubF

CMP AL, '#'
JZ WriteSubFStat

CALL WriteChar

WroteSubFStat :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubF010


WriteSubFStat :

MOV EDX, $SUB_PLAYERS
MOV AL, BYTE PTR[EDX + SUB_F_STAT_INDEX_]
CMP AL, 9;// IS IT SINGLE DIGIT
JA WriteSubFStatSkipZero

PUSH EAX
MOV AL, '0'
CALL WriteChar
INVOKE DoDelay, _SUB_BBS_LATENCY
POP EAX

WriteSubFStatSkipZero :

CALL WriteDec
JMP WroteSubFStat


EndSubF :

JMP SubWritten







WriteSubG:


MOV EAX, 0
MOV ESI, OFFSET SUB_G_010$

WriteSubG010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubG

CMP AL, '#'
JZ WriteSubGStat

CALL WriteChar

WroteSubGStat :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubG010


WriteSubGStat :

MOV EDX, $SUB_PLAYERS
MOV AL, BYTE PTR[EDX + SUB_G_STAT_INDEX_]
CMP AL, 9;// IS IT SINGLE DIGIT
JA WriteSubGStatSkipZero

PUSH EAX
MOV AL, '0'
CALL WriteChar
INVOKE DoDelay, _SUB_BBS_LATENCY
POP EAX

WriteSubGStatSkipZero :

CALL WriteDec
JMP WroteSubGStat



EndSubG :

JMP SubWritten






WriteSubH:


MOV EAX, 0
MOV ESI, OFFSET SUB_H_010$

WriteSubH010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubH

CMP AL, '#'
JZ WriteSubHStat

CMP AL, '@'
JZ WriteSubHTitleColor

CMP AL, '&'
JZ WriteSubHDefaultColor

CALL WriteChar

WroteSubHStat :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubH010


WriteSubHStat :

MOV EDX, $SUB_PLAYERS
MOV AL, BYTE PTR[EDX + SUB_H_STAT_INDEX_]
CMP AL, 9;// IS IT SINGLE DIGIT
JA WriteSubHStatSkipZero

PUSH EAX
MOV AL, '0'
CALL WriteChar
INVOKE DoDelay, _SUB_BBS_LATENCY
POP EAX

WriteSubHStatSkipZero :

CALL WriteDec
JMP WroteSubHStat

WriteSubHTitleColor :
MOV EAX, TITLE_COLOR_
CALL SetTextColor
JMP WroteSubHStat

WriteSubHDefaultColor :
MOV EAX, _SUB_DEFAULT_COLORS
CALL SetTextColor
JMP WroteSubHStat

EndSubH :

JMP SubWritten







WriteSubI:


MOV EAX, 0
MOV ESI, OFFSET SUB_I_010$

WriteSubI010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubI

CMP AL, '#'
JZ WriteSubIStat

CMP AL, '@'
JZ WriteSubITitleColor

CMP AL, '&'
JZ WriteSubIDefaultColor

CALL WriteChar

WroteSubIStat :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubI010


WriteSubIStat :

MOV EDX, $SUB_PLAYERS
MOV AL, BYTE PTR[EDX + SUB_I_STAT_INDEX_]
CMP AL, 9;// IS IT SINGLE DIGIT
JA WriteSubIStatSkipZero

PUSH EAX
MOV AL, '0'
CALL WriteChar
INVOKE DoDelay, _SUB_BBS_LATENCY
POP EAX

WriteSubIStatSkipZero :

CALL WriteDec
JMP WroteSubIStat


WriteSubITitleColor :
MOV EAX, INFO_COLOR_
CALL SetTextColor
JMP WroteSubIStat

WriteSubIDefaultColor :
MOV EAX, _SUB_DEFAULT_COLORS
CALL SetTextColor
JMP WroteSubIStat

EndSubI :

JMP SubWritten








WriteSubJ:


MOV EAX, 0
MOV ESI, OFFSET SUB_J_010$

WriteSubJ010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubJ

CMP AL, '#'
JZ WriteSubJStat

CMP AL, '@'
JZ WriteSubJTitleColor

CMP AL, '&'
JZ WriteSubJDefaultColor

CALL WriteChar

WroteSubJStat :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubJ010


WriteSubJStat :

MOV EDX, $SUB_PLAYERS
MOV AL, BYTE PTR[EDX + SUB_J_STAT_INDEX_]
CMP AL, 9;// IS IT SINGLE DIGIT
JA WriteSubJStatSkipZero

PUSH EAX
MOV AL, '0'
CALL WriteChar
INVOKE DoDelay, _SUB_BBS_LATENCY
POP EAX

WriteSubJStatSkipZero :

CALL WriteDec
JMP WroteSubJStat


WriteSubJTitleColor :
MOV EAX, INFO_COLOR_
CALL SetTextColor
JMP WroteSubJStat

WriteSubJDefaultColor :
MOV EAX, _SUB_DEFAULT_COLORS
CALL SetTextColor
JMP WroteSubJStat

EndSubJ :

JMP SubWritten







WriteSubK:


MOV EAX, 0
MOV ESI, OFFSET SUB_K_010$

WriteSubK010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubK

CMP AL, '#'
JZ WriteSubKStat

CALL WriteChar

WroteSubKStat :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubK010


WriteSubKStat :

MOV EDX, $SUB_PLAYERS
MOV AL, BYTE PTR[EDX + SUB_K_STAT_INDEX_]
CMP AL, 9;// IS IT SINGLE DIGIT
JA WriteSubKStatSkipZero

PUSH EAX
MOV AL, '0'
CALL WriteChar
INVOKE DoDelay, _SUB_BBS_LATENCY
POP EAX

WriteSubKStatSkipZero :

CALL WriteDec
JMP WroteSubKStat


EndSubK :

JMP SubWritten







WriteSubL:


MOV EAX, 0
MOV ESI, OFFSET SUB_L_010$

WriteSubL010 :

MOV AL, BYTE PTR[ESI]
CMP AL, 0
JZ EndSubL

CALL WriteChar
INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubL010


EndSubL :

JMP SubWritten







WriteSubM:


MOV EAX, 0
MOV ESI, OFFSET SUB_M_010$

WriteSubM010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubM

CMP AL, '#'
JZ WriteSubM100

CMP AL, '*'
JZ WriteSubM200

CALL WriteChar

EndWriteSubM100 :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubM010


WriteSubM100 :
MOV EDX, $SUB_PACKETS_LOST
MOV AX, [EDX + 4]
CALL WriteDec
JMP EndWriteSubM100

WriteSubM200 :
MOV EDX, $SUB_PACKETS_LOST
MOV EAX, 0
MOV AX, [EDX + 8]

CMP AL, 9;// IS IT SINGLE DIGIT
JA WriteSubM210


MOV AL, ' '
CALL WriteChar

WriteSubM210 :
MOV AX, [EDX + 8]
CALL WriteDec
JMP EndWriteSubM100

EndSubM :

JMP SubWritten







WriteSubN:


MOV EAX, 0
MOV ESI, OFFSET SUB_N_010$


MOV EDI, $SUB_RUNLEVELS


WriteSubN010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubN

CMP AL, '!'
JZ HighlightSubN100

CMP AL, '@'
JZ HighlightSubN200

CMP AL, '#'
JZ HighlightSubN300

CMP AL, '$'
JZ HighlightSubN400


CALL WriteChar

EndHighlightSubN :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubN010



HighlightSubN100 :

CMP BYTE PTR[EDI], 0;// IS RL1 UNSET
JZ HighlightSubN110

MOV EAX, _SUB_CURSOR_AVAILABLE_COLORS
JMP DoHighlightSubN

HighlightSubN110 :
MOV EAX, _SUB_CURSOR_UNAVAILABLE_COLORS
JMP DoHighlightSubN




HighlightSubN200 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubN



HighlightSubN300 :

CMP BYTE PTR[EDI + 9], 0;// IS SELECT3 ACTIVE
JA HighlightSubN310

CMP BYTE PTR[EDI], 0;// IS RL1 UNSET
JNZ HighlightSubN320

HighlightSubN310 :
MOV EAX, _SUB_CURSOR_AVAILABLE_COLORS
JMP DoHighlightSubN

HighlightSubN320 :
MOV EAX, _SUB_CURSOR_UNAVAILABLE_COLORS
JMP DoHighlightSubN


HighlightSubN400 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubN


DoHighlightSubN :
CALL SetTextColor
JMP EndHighlightSubN


EndSubN :

JMP SubWritten







WriteSubO:


MOV EAX, 0
MOV ESI, OFFSET SUB_O_010$

WriteSubO010 :

MOV AL, BYTE PTR[ESI]
CMP AL, 0
JZ EndSubO

CALL WriteChar
INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubO010


EndSubO :

JMP SubWritten








WriteSubP:


MOV EAX, 0
MOV ESI, OFFSET SUB_P_010$


MOV EDI, $SUB_RUNLEVELS


WriteSubP010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubP

CMP AL, '!'
JZ HighlightSubP100

CMP AL, '@'
JZ HighlightSubP200

CMP AL, '#'
JZ HighlightSubP300

CMP AL, '$'
JZ HighlightSubP400


CALL WriteChar

EndHighlightSubP :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubP010



HighlightSubP100 :

CMP BYTE PTR[EDI], 1;// IS RL1 SET TO P1
JZ HighlightSubP110

CMP BYTE PTR[EDI + 4], 1;// IS SELECT1 ON A DIFFERENT PLAYER
JNZ EndHighlightSubP;// DON'T HIGHLIGHT NOT SELECTED

MOV EAX, INFO_COLOR_
JMP DoHighlightSubP

HighlightSubP110 :
MOV EAX, _SUB_PLAYER_1_COLORS
JMP DoHighlightSubP




HighlightSubP200 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubP


HighlightSubP300 :


CMP BYTE PTR[EDI + 5], 1;// IS SELECT2 ON A DIFFERENT PLAYER
JNZ EndHighlightSubP;// DON'T HIGHLIGHT NOT SELECTED

CMP BYTE PTR[EDI + 0], 1;// IS SELECT2 SET TO P1
JZ HighlightSubP310

CMP BYTE PTR[EDI + 1], 1;// IS SELECT2 SET TO P2
JZ HighlightSubP320


MOV EAX, INFO_COLOR_
JMP DoHighlightSubP

HighlightSubP310 :
MOV EAX, _SUB_CURSOR_UNAVAILABLE_COLORS
JMP DoHighlightSubP

HighlightSubP320 :
MOV EAX, _SUB_PLAYER_2_COLORS
JMP DoHighlightSubP


HighlightSubP400 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubP


DoHighlightSubP :
CALL SetTextColor
JMP EndHighlightSubP


EndSubP :

JMP SubWritten







WriteSubQ:


MOV EAX, 0
MOV ESI, OFFSET SUB_Q_010$


MOV EDI, $SUB_RUNLEVELS


WriteSubQ010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubQ

CMP AL, '!'
JZ HighlightSubQ100

CMP AL, '@'
JZ HighlightSubQ200

CMP AL, '#'
JZ HighlightSubQ300

CMP AL, '$'
JZ HighlightSubQ400

CMP AL, '%'
JZ HighlightSubQ500

CMP AL, '^'
JZ HighlightSubQ600


CALL WriteChar

EndHighlightSubQ :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubQ010



HighlightSubQ100 :

CMP BYTE PTR[EDI], 2;// IS RL1 SET TO P1
JZ HighlightSubQ110

CMP BYTE PTR[EDI + 4], 2;// IS SELECT1 ON A DIFFERENT PLAYER
JNZ EndHighlightSubQ;// DON'T HIGHLIGHT NOT SELECTED

MOV EAX, INFO_COLOR_
JMP DoHighlightSubQ

HighlightSubQ110 :
MOV EAX, _SUB_PLAYER_1_COLORS
JMP DoHighlightSubQ




HighlightSubQ200 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubQ


HighlightSubQ300 :

CMP BYTE PTR[EDI + 5], 2;// IS SELECT2 ON A DIFFERENT PLAYER
JNZ EndHighlightSubQ;// DON'T HIGHLIGHT NOT SELECTED

CMP BYTE PTR[EDI + 0], 2;// IS SELECT2 SET TO P1
JZ HighlightSubQ310

CMP BYTE PTR[EDI + 1], 2;// IS SELECT2 SET TO P2
JZ HighlightSubQ320


MOV EAX, INFO_COLOR_
JMP DoHighlightSubQ

HighlightSubQ310 :
MOV EAX, _SUB_CURSOR_UNAVAILABLE_COLORS
JMP DoHighlightSubQ

HighlightSubQ320 :
MOV EAX, _SUB_PLAYER_2_COLORS
JMP DoHighlightSubQ


HighlightSubQ400 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubQ


HighlightSubQ500 :

CMP BYTE PTR[EDI + 9], 2;// IS SELECT3 ON SHADE
JZ HighlightSubQ510;// DO SHADE HIGHLIGHT

CMP BYTE PTR[EDI + 6], 1;// IS SELECT3 ON PLAY
JNZ EndHighlightSubQ;// DON'T HIGHLIGHT NOT SELECTED

MOV EAX, TITLE_COLOR_
JMP DoHighlightSubQ

HighlightSubQ510 :
MOV EAX, INFO_COLOR_
JMP DoHighlightSubQ


HighlightSubQ600 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubQ


DoHighlightSubQ :
CALL SetTextColor
JMP EndHighlightSubQ


EndSubQ :

JMP SubWritten









WriteSubR:


MOV EAX, 0
MOV ESI, OFFSET SUB_R_010$


MOV EDI, $SUB_RUNLEVELS


WriteSubR010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubR

CMP AL, '!'
JZ HighlightSubR100

CMP AL, '@'
JZ HighlightSubR200

CMP AL, '#'
JZ HighlightSubR300

CMP AL, '$'
JZ HighlightSubR400


CALL WriteChar

EndHighlightSubR :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubR010


HighlightSubR100 :

CMP BYTE PTR[EDI], 3;// IS RL1 SET TO P1
JZ HighlightSubR110

CMP BYTE PTR[EDI + 4], 3;// IS SELECT1 ON A DIFFERENT PLAYER
JNZ EndHighlightSubR;// DON'T HIGHLIGHT NOT SELECTED

MOV EAX, INFO_COLOR_
JMP DoHighlightSubR

HighlightSubR110 :
MOV EAX, _SUB_PLAYER_1_COLORS
JMP DoHighlightSubR


HighlightSubR200 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubR


HighlightSubR300 :

CMP BYTE PTR[EDI + 5], 3;// IS SELECT2 ON A DIFFERENT PLAYER
JNZ EndHighlightSubR;// DON'T HIGHLIGHT NOT SELECTED

CMP BYTE PTR[EDI + 0], 3;// IS SELECT2 SET TO P1
JZ HighlightSubR310

CMP BYTE PTR[EDI + 1], 3;// IS SELECT2 SET TO P2
JZ HighlightSubR320


MOV EAX, INFO_COLOR_
JMP DoHighlightSubR

HighlightSubR310 :
MOV EAX, _SUB_CURSOR_UNAVAILABLE_COLORS
JMP DoHighlightSubR

HighlightSubR320 :
MOV EAX, _SUB_PLAYER_2_COLORS
JMP DoHighlightSubR


HighlightSubR400 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubR


DoHighlightSubR :
CALL SetTextColor
JMP EndHighlightSubR


EndSubR :

JMP SubWritten







WriteSubS:


MOV EAX, 0


MOV ESI, OFFSET SUB_S_010$


MOV EDI, $SUB_RUNLEVELS


WriteSubS010 :

MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubS

CMP AL, '!'
JZ HighlightSubS100

CMP AL, '@'
JZ HighlightSubS200

CMP AL, '#'
JZ HighlightSubS300

CMP AL, '$'
JZ HighlightSubS400


CALL WriteChar

EndHighlightSubS :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubS010


HighlightSubS100 :

CMP BYTE PTR[EDI], 4;// IS RL1 SET TO P1
JZ HighlightSubS110

CMP BYTE PTR[EDI + 4], 4;// IS SELECT1 ON A DIFFERENT PLAYER
JNZ EndHighlightSubS;// DON'T HIGHLIGHT NOT SELECTED

MOV EAX, INFO_COLOR_
JMP DoHighlightSubS

HighlightSubS110 :
MOV EAX, _SUB_PLAYER_1_COLORS
JMP DoHighlightSubS


HighlightSubS200 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubS


HighlightSubS300 :

CMP BYTE PTR[EDI + 5], 4;// IS SELECT2 ON A DIFFERENT PLAYER
JNZ EndHighlightSubS;// DON'T HIGHLIGHT NOT SELECTED

CMP BYTE PTR[EDI + 0], 4;// IS SELECT2 SET TO P1
JZ HighlightSubS310

CMP BYTE PTR[EDI + 1], 4;// IS SELECT2 SET TO P2
JZ HighlightSubS320


MOV EAX, INFO_COLOR_
JMP DoHighlightSubS

HighlightSubS310 :
MOV EAX, _SUB_CURSOR_UNAVAILABLE_COLORS
JMP DoHighlightSubS

HighlightSubS320 :
MOV EAX, _SUB_PLAYER_2_COLORS
JMP DoHighlightSubS


HighlightSubS400 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubS


DoHighlightSubS :
CALL SetTextColor
JMP EndHighlightSubS


EndSubS :

JMP SubWritten






WriteSubT:


MOV EAX, 0

MOV EDI, $SUB_RUNLEVELS


CMP BYTE PTR[EDI + 9], 2
JZ WriteSubT040;// NOTHING AT BOTTOM

CMP BYTE PTR[EDI + 8], 1
JZ WriteSubT030;// NOTHING AT BOTTOM

CMP BYTE PTR[EDI + 7], 1
JZ WriteSubT020;// NOTHING AT BOTTOM



MOV ESI, OFFSET SUB_T_010$
JMP WriteSubT077

WriteSubT020 :
MOV ESI, OFFSET SUB_T_020$
JMP WriteSubT077

WriteSubT030 :
MOV ESI, OFFSET SUB_T_030$
JMP WriteSubT077

WriteSubT040 :
MOV ESI, OFFSET SUB_T_040$
;// JMP WriteSubT077


WriteSubT077:


MOV AL, BYTE PTR[ESI]

CMP AL, 0
JZ EndSubT

CMP AL, '!'
JZ HighlightSubT100

CMP AL, '@'
JZ HighlightSubT200

CMP AL, '#'
JZ HighlightSubT300

CMP AL, '$'
JZ HighlightSubT400

CMP AL, '%'
JZ HighlightSubT500

CMP AL, '^'
JZ HighlightSubT600


CALL WriteChar

EndHighlightSubT :

INC ESI
INVOKE DoDelay, _SUB_BBS_LATENCY
JMP WriteSubT077


HighlightSubT100 :

CMP BYTE PTR[EDI + 4], 5;// IS SELECT1 ON A PLAYER
JNZ EndHighlightSubT;// DON'T HIGHLIGHT NOT SELECTED

MOV EAX, TITLE_COLOR_
JMP DoHighlightSubT

HighlightSubT200 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubT


HighlightSubT300 :
CMP BYTE PTR[EDI + 5], 5;// IS SELECT2 ON A PLAYER
JNZ EndHighlightSubT;// DON'T HIGHLIGHT NOT SELECTED

MOV EAX, TITLE_COLOR_
JMP DoHighlightSubT


HighlightSubT400 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubT


HighlightSubT500 :
CMP BYTE PTR[EDI + 6], 5;// IS SELECT3 NOT ON BACK
JNZ EndHighlightSubT;// DON'T HIGHLIGHT NOT SELECTED

MOV EAX, TITLE_COLOR_
JMP DoHighlightSubT


HighlightSubT600 :
MOV EAX, _SUB_DEFAULT_COLORS
JMP DoHighlightSubT


DoHighlightSubT :
CALL SetTextColor
JMP EndHighlightSubT


EndSubT :

JMP SubWritten







SubWritten:
;// CharWritten:


RET
DisplaySub ENDP
;//==========================================================================












RecalculatePosition PROC,
	$RECALC_RUNLEVELS : PTR DWORD,
	$RECALC_BOARD : PTR DWORD,
	$RECALC_PLAYERS : PTR DWORD,
	_RECALC_DIRECTION : DWORD
;//==========================================================================
;// DESC:  RECALCULATES POSITION BASED ON GAME VARIABLES                    #
;// NOTE:  _RECALC_DIRECTION OPERATES WITH CHARS 'E', 'U', 'D', 'L', 'R'    #
;//==========================================================================


MOV EDI, [$RECALC_BOARD]


MOV EBX, 0
MOV BL, BYTE PTR[EDI];// CURSOR VALUE


CMP BL, 0;// CANNOT MOVE CURSOR FROM NULL POSITION
JZ DoInit

CMP _RECALC_DIRECTION, 'E'
JE DoAffixStamp

CMP _RECALC_DIRECTION, 'U'
JZ GoUp

CMP _RECALC_DIRECTION, 'D'
JZ GoDown

CMP _RECALC_DIRECTION, 'L'
JZ GoLeft

CMP _RECALC_DIRECTION, 'R'
JZ GoRight


DoInit :

MOV BYTE PTR[EDI], 5;// MOVE CURSOR TO MIDDLE
JMP GoReturn




DoAffixStamp :

INVOKE AffixStamp, $RECALC_RUNLEVELS, $RECALC_BOARD, $RECALC_PLAYERS

JMP GoReturn




GoUp :

;// 1,2,3 CAN'T GO UP, ADD 6
;// ALL OTHERS SUBTRACT 3

CMP BL, 4
JB GoUpDown

SUB BL, 3
MOV BYTE PTR[EDI], BL
JMP GoReturn

GoUpDown :
ADD BL, 6
MOV BYTE PTR[EDI], BL
JMP GoReturn



GoDown :

;// 7,8,9 CAN'T GO DOWN, SUBTRACT 6
;// ALL OTHERS ADD 3

CMP BL, 6
JA GoDownUp

ADD BL, 3
MOV BYTE PTR[EDI], BL
JMP GoReturn

GoDownUp :
SUB BL, 6
MOV BYTE PTR[EDI], BL
JMP GoReturn



GoLeft :

;// 1,4,7 CAN'T GO LEFT, ADD 2
;// ALL OTHERS SUBTRACT 1

CMP BL, 1
JZ GoLeftRight

CMP BL, 4
JZ GoLeftRight

CMP BL, 7
JZ GoLeftRight

SUB BL, 1
MOV BYTE PTR[EDI], BL
JMP GoReturn

GoLeftRight :
ADD BL, 2
MOV BYTE PTR[EDI], BL
JMP GoReturn



GoRight :

;// 3,6,9 CAN'T GO RIGHT, SUBTRACT 2
;// ALL OTHERS ADD 1

CMP BL, 3
JZ GoRightLeft

CMP BL, 6
JZ GoRightLeft

CMP BL, 9
JZ GoRightLeft

ADD BL, 1
MOV BYTE PTR[EDI], BL
JMP GoReturn

GoRightLeft :
SUB BL, 2
MOV BYTE PTR[EDI], BL
JMP GoReturn



GoReturn :


RET
RecalculatePosition ENDP
;//==========================================================================













AffixStamp PROC,
	$STAMP_RUNLEVELS : PTR DWORD,
	$STAMP_BOARD : PTR DWORD,
	$STAMP_PLAYERS : PTR DWORD
;//==========================================================================
;// DESC: ATTEMPTS TO AFFIX A STAMP WHEREVER 'E' FOR ENTER IS RECALCULATED  #
;//==========================================================================


MOV EBX, $STAMP_RUNLEVELS
MOV EDI, $STAMP_BOARD
MOV ESI, $STAMP_PLAYERS


MOV EDX, 0
MOV DL, BYTE PTR[EDI]

CMP BYTE PTR[EDI], 0;// CANNOT AFFIX STAMP TO NULL POSITION
JZ DoInit


CMP BYTE PTR[EDI + EDX], 'X'
JZ GoReturn;// KINDLY IGNORE THE TROLL

CMP BYTE PTR[EDI + EDX], 'O'
JZ GoReturn;// KEEP IGNORING THE TROLL


INC BYTE PTR[EBX + 2];// INC RUNLEVEL 2


MOV EBX, 0
MOV BL, BYTE PTR[ESI];// GET NEXT PLAYER [1,2]

MOV EDX, 0
MOV DL, BYTE PTR[ESI + EBX];// GET NEXT PLAYER DWORD IDENTITY [1,4]

MOV EAX, 0
MOV AL, BYTE PTR[ESI + 4 * EDX];// GET NEXT PLAYER STAMP ['X','O']


MOV ECX, 0
MOV CL, BYTE PTR[EDI];// GET CURSOR POSITION [1,9]


MOV BYTE PTR[EDI + ECX], AL;// AFFIX STAMP AT CURSOR POSITION


INVOKE IsGameOver, $STAMP_RUNLEVELS, $STAMP_BOARD, $STAMP_PLAYERS

MOV EDX, $STAMP_RUNLEVELS
CMP BYTE PTR[EDX + 3], 0
JA GoReturn;// GAME OVER, DON'T SWITCH PLAYERS


MOV EDX, 3
SUB DL, BL
MOV BYTE PTR[ESI], DL;// SWITCH PLAYERS FOR NEXT

JMP GoReturn


DoInit :

MOV BYTE PTR[EDI], 5;// MOVE CURSOR TO MIDDLE

GoReturn:



RET
AffixStamp ENDP
;//==========================================================================









IsGameOver PROC,
	$IGO_RUNLEVELS : PTR DWORD,
	$IGO_BOARD : PTR DWORD,
	$IGO_PLAYERS : PTR DWORD
;//==========================================================================
;// DESC:  CHECKS TO SEE IF THE GAME IS OVER OR NOT                         #
;//==========================================================================


IGO_SENTINAL_ = 0



PUSHAD


MOV EBX, $IGO_RUNLEVELS
MOV EDI, $IGO_BOARD
MOV ESI, $IGO_PLAYERS

MOV EAX, 0
MOV EDX, 0




CheckTopRow:

MOV DL, BYTE PTR[EDI + 1]

CMP DL, IGO_SENTINAL_
JZ CheckMiddleRow

CMP DL, BYTE PTR[EDI + 2]
JNZ CheckMiddleRow

CMP DL, BYTE PTR[EDI + 3]
JNZ CheckMiddleRow

MOV BYTE PTR[EBX + 2], 1;// STORE ROW/COL CODE

JMP SaveWinner





CheckMiddleRow:

MOV DL, BYTE PTR[EDI + 4]

CMP DL, IGO_SENTINAL_
JZ CheckBottomRow

CMP DL, BYTE PTR[EDI + 5]
JNZ CheckBottomRow

CMP DL, BYTE PTR[EDI + 6]
JNZ CheckBottomRow

MOV BYTE PTR[EBX + 2], 2;// STORE ROW/COL CODE

JMP SaveWinner




CheckBottomRow :

MOV DL, BYTE PTR[EDI + 7]

CMP DL, IGO_SENTINAL_
JZ CheckLeftCol

CMP DL, BYTE PTR[EDI + 8]
JNZ CheckLeftCol

CMP DL, BYTE PTR[EDI + 9]
JNZ CheckLeftCol

MOV BYTE PTR[EBX + 2], 3;// STORE ROW/COL CODE

JMP SaveWinner




CheckLEftCol :

MOV DL, BYTE PTR[EDI + 1]

CMP DL, IGO_SENTINAL_
JZ CheckMiddleCol

CMP DL, BYTE PTR[EDI + 4]
JNZ CheckMiddleCol

CMP DL, BYTE PTR[EDI + 7]
JNZ CheckMiddleCol

MOV BYTE PTR[EBX + 2], 4;// STORE ROW/COL CODE

JMP SaveWinner





CheckMiddleCol:

MOV DL, BYTE PTR[EDI + 2]

CMP DL, IGO_SENTINAL_
JZ CheckRightCol

CMP DL, BYTE PTR[EDI + 5]
JNZ CheckRightCol

CMP DL, BYTE PTR[EDI + 8]
JNZ CheckRightCol

MOV BYTE PTR[EBX + 2], 5;// STORE ROW/COL CODE

JMP SaveWinner






CheckRightCol:

MOV DL, BYTE PTR[EDI + 3]

CMP DL, IGO_SENTINAL_
JZ CheckDiagSE

CMP DL, BYTE PTR[EDI + 6]
JNZ CheckDiagSE

CMP DL, BYTE PTR[EDI + 9]
JNZ CheckDiagSE

MOV BYTE PTR[EBX + 2], 6;// STORE ROW/COL CODE

JMP SaveWinner





CheckDiagSE:

MOV DL, BYTE PTR[EDI + 1]

CMP DL, IGO_SENTINAL_
JZ CheckDiagSW

CMP DL, BYTE PTR[EDI + 5]
JNZ CheckDiagSw

CMP DL, BYTE PTR[EDI + 9]
JNZ CheckDiagSw

MOV BYTE PTR[EBX + 2], 7;// STORE ROW/COL CODE

JMP SaveWinner





CheckDiagSw:

MOV DL, BYTE PTR[EDI + 3]

CMP DL, IGO_SENTINAL_
JZ CheckDraw

CMP DL, BYTE PTR[EDI + 5]
JNZ CheckDraw

CMP DL, BYTE PTR[EDI + 7]
JNZ CheckDraw

MOV BYTE PTR[EBX + 2], 8;// STORE ROW/COL CODE

JMP SaveWinner





CheckDraw:

CMP BYTE PTR[EBX + 2], 9
JB DoneChecking

MOV BYTE PTR[EBX + 3], 5;// STORE DRAW
MOV BYTE PTR[EBX + 2], 0;// STORE ROW/COL CODE
MOV BYTE PTR[EDI], 0;// DISENGAGE CURSOR
INC BYTE PTR[ESI + 5 * 4];// STORE STAT FOR DRAW
MOV BYTE PTR[ESI], 5;// NEXT PLAYER IS DRAW
INC BYTE PTR[ESI + 3];// INCREMENT GAMES PLAYED COUNTER

MOV BYTE PTR[EBX + 6], 5;// HIGHLIGHT SELECT3 BACK
MOV BYTE PTR[EBX + 9], 1;// DISPLAY SELECT3 BACK

JMP DoneChecking



SaveWinner :

MOV AL, BYTE PTR[ESI];// GET NEXT PLAYER
MOV DL, BYTE PTR[ESI + EAX];// GET NEXT PLAYER IDENTITY
MOV BYTE PTR[EBX + 3], DL;// STORE WINNER
INC BYTE PTR[ESI + EDX * 4 + 1];// BUMP IDENTITY WINNER STAT
INC BYTE PTR[ESI + EAX + 20];// INCREMENT P1/P2 WIN COUNTER
MOV BYTE PTR[EDI], 0;// DISENGAGE CURSOR
INC BYTE PTR[ESI + 3];// INCREMENT GAMES PLAYED COUNTER

MOV BYTE PTR[EBX + 6], 5;// HIGHLIGHT SELECT3 BACK
MOV BYTE PTR[EBX + 9], 1;// DISPLAY SELECT3 BACK



DoneChecking:

POPAD

RET
IsGameOver ENDP
;//==========================================================================








RecalculateLatency PROC,
	$RELAT_PACKETS_LOST : PTR DWORD
;//==========================================================================
;// DESC:  RECALCULATES THE BBS BAUD RATE AND LATENCY                       #
;//==========================================================================

CALL_QUALITY_MIN_ = 1
CALL_QUALITY_MAX_ = 85;// 100% CALL QUALITY DOESN'T EXIST

HIGH_LAT_THRESH_ = 3
MED_LAT_THRESH_ = 10

MOV EDI, $RELAT_PACKETS_LOST
MOV EAX, 0
MOV EDX, 0
MOV ECX, 0

INVOKE DoRandomRange, CALL_QUALITY_MIN_, CALL_QUALITY_MAX_

MOV WORD PTR[EDI + 8], AX;// FROM RANDOM RANGE

MOV CX, WORD PTR[EDI + 2];// DEFAULT BAUDRATE
MOV BX, WORD PTR[EDI + 6];// MINIMUM LATENCY


CMP AX, HIGH_LAT_THRESH_
JBE DoHighLatency

CMP AX, MED_LAT_THRESH_
JBE DoMedLatency


MOV WORD PTR[EDI + 4], CX;// USE DEFAULT BAUDRATE
MOV AX, 8000
DIV CX
MOV WORD PTR[EDI + 6], AX;// STORE LATENCY
JMP EndLat


DoHighLatency :
MOV AX, CX
MOV CX, 4
DIV CX
MOV WORD PTR[EDI + 4], AX;// STORE BAUD RATE
MOV CX, AX
MOV AX, 8000
DIV CX
MOV WORD PTR[EDI + 6], AX;// STORE LATENCY
JMP EndLat


DoMedLatency :
MOV AX, CX
MOV CX, 2
DIV CX
MOV WORD PTR[EDI + 4], AX;// STORE BAUD RATE
MOV CX, AX
MOV AX, 8000
DIV CX
MOV WORD PTR[EDI + 6], AX;// STORE LATENCY
JMP EndLat


EndLat :


RET
RecalculateLatency ENDP
;//==========================================================================



END MAIN
;//==========================================================================
;//==========================================================================



