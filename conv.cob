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
77  I    PICTURE S99.
77  PREV PICTURE S9(8).
77  D    PICTURE S9(4).
01 ERROR-MESS.
    02 FILLER PICTURE X(22) VALUE ' ILLEGAL ROMAN NUMERAL'.

LINKAGE SECTION.
77  M    PICTURE S99.
77  ERR  PICTURE S9 comp-3.
77  SUM1 PICTURE S9(8).
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
        display 'Party rock' 
        perform 3
    else
        if S(I) = 'V'
            move 5 to D
            perform 3
        else
            if S(I) = 'X'
                move 10 to D
                perform 3
            else
                if S(I) = 'L'
                    move 50 to D
                    perform 3
                else
                    if S(I) = 'C'
                        move 100 to D
                        perform 3
                    else
                        if S(I) = 'D'
                            move 500 to D
                            perform 3
                        else
                            if S(I) = 'M'
                                move 1000 to D
                                perform 3
                            else
                                perform B7
                            end-if
                        end-if
                    end-if
                end-if
            end-if
        end-if
    end-if.
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
