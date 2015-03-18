identification division.
program-id. romannumerals.
environment division.
input-output section.
file-control.
    SELECT STANDARD-INPUT ASSIGN TO KEYBOARD.
    SELECT STANDARD-OUTPUT ASSIGN TO DISPLAY.

data division.
file section.
FD STANDARD-INPUT.
    01 STDIN-RECORD   pic X(80).
FD STANDARD-OUTPUT.
    01 STDOUT-RECORD  pic X(80).
working-storage section.
77  N    pic S99.
77  TEMP pic S9(8).
77  RET  pic S9 comp-3.
01  ARRAY-AREA.
    02 R pic X(1) occurs 30 times.
01  INPUT-AREA.
    02 IN-R   pic X(1).
    02 filler pic X(79).
01  TITLE-line.
    02 filler pic X(11) value spaces.
    02 filler pic X(24) value "ROMAN NUMBER EQUIVALENTS".
01  UNDERLINE-1.
    02 filler pic X(45) value 
       " --------------------------------------------".
01  COL-HEADS.
    02 filler pic X(9) value spaces.
    02 filler pic X(12) value "ROMAN NUMBER".
    02 filler pic X(13) value spaces.
    02 filler pic X(11) value "DEC. EQUIV.".
01  UNDERLINE-2.
    02 filler pic X(45) value
       " ------------------------------   -----------".
01  PRINT-line.
    02 filler pic X value space.
    02 OUT-R  pic X(30).
    02 filler pic X(3) value space.
    02 OUT-EQ pic Z(9).
01  total pic 99 value zero.
01  len pic 99 value zero.
01  inputNum pic X(80).
01  question.
    02 filler pic X(17) value ' Continue? (Y/N)'.
    02  filler pic X value space.

procedure division.
    open input STANDARD-INPUT, output STANDARD-OUTPUT.
    write STDOUT-RECORD  from TITLE-line after advancing 0 lines.
    write STDOUT-RECORD  from UNDERLINE-1 after advancing 1 line.
    write STDOUT-RECORD  from COL-HEADS after advancing 1 line.
    write STDOUT-RECORD  from UNDERLINE-2 after advancing 1 line.
L1. move 1 to N. move SPACES to ARRAY-AREA.
L2. read STANDARD-INPUT into inputNum at end perform B3 end-read.
    move inputNum to ARRAY-AREA.
    inspect inputNum tallying total for all characters before initial '\0'.
    inspect inputNum tallying len for trailing spaces.
    compute len = total - len.
    move len to N.

B1. call "conv" using ARRAY-AREA, N, RET, TEMP.
    move 1 TO RET.
    evaluate RET
        when 1 perform B2
        when 0 perform L1
    end-evaluate.
B2. move TEMP TO OUT-EQ. move ARRAY-AREA to OUT-R.
    write STDOUT-RECORD from PRINT-LINE after advancing 1 LINE.
    perform L1.
B3. write STDOUT-RECORD from question after advancing 1 line.
    read STANDARD-INPUT into INPUT-AREA at end perform B4 end-read.
B4. if IN-R = 'Y'
        perform L1
    else
        if IN-R = 'N'
            perform B5
        else
            perform B3
        end-if
    end-if.
B5. close STANDARD-INPUT, STANDARD-OUTPUT. 
    stop run.
