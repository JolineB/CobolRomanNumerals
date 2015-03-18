IDENTIFICATION DIVISION.
PROGRAM-ID. ROMANNUMERALS.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT STANDARD-INPUT ASSIGN to KEYBOARD.
    SELECT STANDARD-OUTPUT ASSIGN to DISPLAY.

DATA DIVISION.
FILE SECTION.
FD STANDARD-INPUT.
    01 STDIN-RECORD   pic X(80).
FD STANDARD-OUTPUT.
    01 STDOUT-RECORD  pic X(80).
WORKING-STORAGE SECTION.
77  N    pic S99.
77  TEMP pic S9(8).
77  RET  pic S9 comp-3.
01  ARRAY-AREA.
    02 R pic X(1) occurs 30 times.
01  INPUT-AREA.
    02 IN-R   pic X(1).
    02 filler pic X(79).
01  TITLE-line.
    02 filler pic X(11) value SPACES.
    02 filler pic X(24) value "ROMAN NUMBER EQUIVALENTS".
01  UNDERLINE-1.
    02 filler pic X(45) value 
       " --------------------------------------------".
01  COL-HEADS.
    02 filler pic X(9) value SPACES.
    02 filler pic X(12) value "ROMAN NUMBER".
    02 filler pic X(13) value SPACES.
    02 filler pic X(11) value "DEC. EQUIV.".
01  UNDERLINE-2.
    02 filler pic X(45) value
       " ------------------------------   -----------".
01  PRINT-line.
    02 filler pic X value SPACE.
    02 OUT-R  pic X(30).
    02 filler pic X(3) value SPACES.
    02 OUT-EQ pic Z(9).

PROCEDURE DIVISION.
    open input STANDARD-INPUT, output STANDARD-OUTPUT.
    write stdout-record from TITLE-line after advancing 0 lines.
    write stdout-record from UNDERLINE-1 after advancing 1 line.
    write stdout-record from COL-HEADS after advancing 1 line.
    write stdout-record from UNDERLINE-2 after advancing 1 line.

L1. move 1 to N. move SPACES to ARRAY-AREA.
L2. read STANDARD-INPUT into INPUT-AREA at end perform B3 end-read.
    move IN-R to R(N).
    if IN-R = SPACE then
        perform B1
    end-if.
    add 1 to N. perform L2.
B1. subtract 1 from N.
    call "rConv" using ARRAY-AREA, N, RET, TEMP.
    move 1 to RET.
    GO to B2, L1 depending on RET.
B2. move TEMP to OUT-EQ. move ARRAY-AREA to OUT-R.
    write stdout-record from PRINT-line after advancing 1 line.
    perform L1.
B3. close STANDARD-INPUT, STANDARD-OUTPUT. 
    stop run.
