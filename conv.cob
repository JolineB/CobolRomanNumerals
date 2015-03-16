IDENTIFICATION DIVISION.
PROGRAM-ID. conv.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT STANDARD-OUTPUT ASSIGN TO DISPLAY.

DATA DIVISION.
FILE SECTION.
FD STANDARD-OUTPUT.
    01 STDOUT-RECORD  PICTURE X(80).

WORKING-STORAGE SECTION.
77  I    PICTURE S99 USAGE IS COMPUTATIONAL.
77  PREV PICTURE S9(8) USAGE IS COMPUTATIONAL.
77  D    PICTURE S9(4) USAGE IS COMPUTATIONAL.
01 ERROR-MESS.
    02 FILLER PICTURE X(22) VALUE ' ILLEGAL ROMAN NUMERAL'.

LINKAGE SECTION.
77  M    PICTURE S99 USAGE IS COMPUTATIONAL.
77  ERR  PICTURE S9 USAGE IS COMPUTATIONAL-3.
77  SUM1 PICTURE S9(8) USAGE IS COMPUTATIONAL.
01  ARRAY-AREA.
    02 S PICTURE X(1) OCCURS 30 TIMES.

PROCEDURE DIVISION USING ARRAY-AREA, M, ERR, SUM1.
    MOVE ZERO TO SUM1. MOVE 1001 TO PREV.
    PERFORM LOOP THRU END-LOOP VARYING I FROM 1 BY 1
       UNTIL I IS GREATER THAN M.
    MOVE 1 TO ERR. GO TO B8.
LOOP.
    IF S(I) = 'I'
        MOVE 1 TO D 
        perform 3
    else
        if S(I) = 'V'
            move 5 to D
            perform 3
        end-if.
    end-if.
B2. IF S(I) NOT = 'X' GO TO B3 end-if.
    MOVE 10 TO D. perform 3.
B3. IF S(I) NOT = 'L' GO TO B4 end-if.
    MOVE 50 TO D. perform 3.
B4. IF S(I) NOT = 'C' GO TO B5 end-if.
    MOVE 100 TO D. perform 3.
B5. IF S(I) NOT = 'D' GO TO B6 end-if.
    MOVE 500 TO D. perform 3.
B6. IF S(I) NOT = 'M' GO TO B7 end-if.
    MOVE 1000 TO D. perform 3.
3.  ADD D TO SUM1.
    IF D IS GREATER THAN PREV
       COMPUTE SUM1 = SUM1 - 2 * PREV
       end-if.
END-LOOP. MOVE D TO PREV.
B7. OPEN OUTPUT STANDARD-OUTPUT.
    WRITE STDOUT-RECORD FROM ERROR-MESS AFTER ADVANCING 1 LINE.
    MOVE 2 TO ERR. CLOSE STANDARD-OUTPUT.
B8. GOBACK. 
