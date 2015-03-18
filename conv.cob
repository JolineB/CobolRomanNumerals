identification division.
program-id. rConv.
environment division.
input-output section.
file-control.
    select STANDARD-OUTPUT assign to display.

data division.
file section.
fd STANDARD-OUTPUT.
    01 STDOUT-RECORD  pic X(80).

working-storage section.
77  I    pic S99.
77  PREV pic S9(8).
77  D    pic S9(4).
01 ERROR-MESS.
    02 FILLER pic X(25) value "Illegal Roman Numeral ".

linkage section.
77  M    pic S99.
77  ERR  pic S9 comp-3.
77  SUM1 pic S9(8).
01  ARRAY-AREA.
    02 S pic X(1) occurs 30 times.

procedure division using ARRAY-AREA, M, ERR, SUM1.
    move 0 to SUM1. move 1001 to PREV.
    perform LOOP thru END-LOOP varying I from 1 by 1
       until I > M.
    move 1 to ERR. GO to B8.
LOOP.
    if S(I) = 'I'
        MOVE 1 TO D
    else
        if S(I) = 'V'
            move 5 to D
        else
            if S(I) = 'X'
                move 10 to D
            else
                if S(I) = 'L'
                    move 50 to D
                else
                    if S(I) = 'C'
                        move 100 to D
                    else
                        if S(I) = 'D'
                            move 500 to D
                        else
                            if S(I) = 'M'
                                move 1000 to D
                            else
                                perform B7
                            end-if
                        end-if
                    end-if
                end-if
            end-if
        end-if
    end-if.
3.  ADD D TO SUM1.
    IF D IS GREATER THAN PREV
       COMPUTE SUM1 = SUM1 - 2 * PREV
       end-if.
END-LOOP. MOVE D TO PREV.
B7. OPEN OUTPUT STANDARD-OUTPUT.
    WRITE STDOUT-RECORD FROM ERROR-MESS AFTER ADVANCING 1 LINE.
    MOVE 2 TO ERR. CLOSE STANDARD-OUTPUT.
B8. GOBACK. 
