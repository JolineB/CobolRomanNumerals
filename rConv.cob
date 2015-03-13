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
    02 FILLER pic X(25) value "Illegal Roman Numeral".

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
    if S(I) is not = 'I' then
        continue
    else
        move 1 to D
        perform the_sum
    end-if.
    if S(I) is not = 'V' then
        continue
    else
        move 5 to D
        perform the_sum
    end-if.
    if S(I) is not = 'X' then
        continue
    else
        move 10 to D
        perform the_sum
    end-if.
    if S(I) is not = 'L' then
        continue
    else
        move 50 to D
        perform the_sum
    end-if.
    if S(I) is not = 'C' then
        continue
    else
        move 100 to D
        perform the_sum
    end-if
    if S(I) is not = 'D' then
        continue
    else
        move 500 to D
        perform the_sum
    end-if.
    if S(I) is not = 'M' then
        perform B7 1 times
    else
        move 1000 to D
        perform the_sum
    end-if.
the_sum.  
    ADD D to SUM1.
    if D > PREV
       compute SUM1 = SUM1 - 2 * PREV
    end-if.
END-LOOP. move D to PREV.
B7. 
    open output STANDARD-OUTPUT.
    write STDOUT-RECORD from ERROR-MESS after advancing 1 line.
    move 2 to ERR. close STANDARD-OUTPUT.
B8. 
    goback. 
