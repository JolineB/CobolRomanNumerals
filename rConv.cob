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
    if S(I) = 'I' then
        move 1 to D
        perform the_sum
    else
        if S(I) = 'V' then
            move 5 to D
            perform the_sum
        else
            if S(I) = 'X' then
                move 10 to D
                perform the_sum
            else
                if S(I) = 'L' then
                    move 50 to D
                    perform the_sum
                else
                    if S(I) = 'C' then
                        move 100 to D
                        perform the_sum
        
                    else
                        if S(I) = 'D' then
                            move 500 to D
                            perform the_sum
                        else
                            if S(I) = 'M' then
                                move 1000 to D
                                perform the_sum
                            else
                                open output STANDARD-OUTPUT
                                write STDOUT-RECORD from ERROR-MESS after advancing 1 line
                                move 2 to ERR close STANDARD-OUTPUT
                            end-if
                        end-if
                    end-if
                end-if 
            end-if 
        end-if
    end-if.
the_sum.  
    ADD D to SUM1.
    display SUM1.
    if D > PREV
       compute SUM1 = SUM1 - 2 * PREV
    end-if.
END-LOOP. move D to PREV.
B8. 
    goback. 
