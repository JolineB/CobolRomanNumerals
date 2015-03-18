IDENTIFICATION DIVISION.
PROGRAM-ID. ROMANNUMERALS.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT STANDARD-INPUT ASSIGN TO KEYBOARD.
    SELECT STANDARD-OUTPUT ASSIGN TO DISPLAY.

DATA DIVISION.
FILE SECTION.
FD STANDARD-INPUT.
    01 STDIN-RECORD   PICTURE X(80).
FD STANDARD-OUTPUT.
    01 STDOUT-RECORD  PICTURE X(80).
WORKING-STORAGE SECTION.
77  N    PICTURE S99.
77  TEMP PICTURE S9(8).
77  RET  PICTURE S9 comp-3.
01  ARRAY-AREA.
    05 R PICTURE X OCCURS 80 TIMES.
01  INPUT-AREA.
    02 IN-R   PICTURE X(1).
    02 FILLER PICTURE X(79).
01  TITLE-LINE.
    02 FILLER PICTURE X(11) VALUE SPACES.
    02 FILLER PICTURE X(24) VALUE 'ROMAN NUMBER EQUIVALENTS'.
01  UNDERLINE-1.
    02 FILLER PICTURE X(45) VALUE 
       ' --------------------------------------------'.
01  COL-HEADS.
    02 FILLER PICTURE X(9) VALUE SPACES.
    02 FILLER PICTURE X(12) VALUE 'ROMAN NUMBER'.
    02 FILLER PICTURE X(13) VALUE SPACES.
    02 FILLER PICTURE X(11) VALUE 'DEC. EQUIV.'.
01  UNDERLINE-2.
    02 FILLER PICTURE X(45) VALUE
       ' ------------------------------   -----------'.
    02  filler pic X value space.
01  PRINT-LINE.
    02 FILLER PICTURE X VALUE SPACE.
    02 OUT-R  PICTURE X(30).
    02 FILLER PICTURE X(3) VALUE SPACES.
    02 OUT-EQ PICTURE Z(9).
01  total pic 99 value zero.
01  len pic 99 value zero.
01  inputNum pic X(80).
01  question.
    02 filler pic X(17) value ' Continue? (Y/N)'.
    02  filler pic X value space.

PROCEDURE DIVISION.
    OPEN INPUT STANDARD-INPUT, OUTPUT STANDARD-OUTPUT.
    WRITE STDOUT-RECORD FROM TITLE-LINE AFTER ADVANCING 0 LINES.
    WRITE STDOUT-RECORD FROM UNDERLINE-1 AFTER ADVANCING 1 LINE.
    WRITE STDOUT-RECORD FROM COL-HEADS AFTER ADVANCING 1 LINE.
    WRITE STDOUT-RECORD FROM UNDERLINE-2 AFTER ADVANCING 1 LINE.
L1. MOVE 1 TO N. MOVE SPACES TO ARRAY-AREA.
L2. read STANDARD-INPUT into inputNum at end perform B3 end-read.
    move inputNum to ARRAY-AREA.
    inspect inputNum tallying total for all characters before initial '\0'.
    inspect inputNum tallying len for trailing spaces.
    compute len = total - len.
    move len to N.

B1. CALL "conv" USING ARRAY-AREA, N, RET, TEMP.
    MOVE 1 TO RET.
    evaluate RET
        when 1 perform B2
        when 0 perform L1
    end-evaluate.
B2. MOVE TEMP TO OUT-EQ. MOVE ARRAY-AREA TO OUT-R.
    WRITE STDOUT-RECORD FROM PRINT-LINE AFTER ADVANCING 1 LINE.
    perform L1.
B3. write STDOUT-RECORD from question after advancing 1 line.
    read STANDARD-INPUT into INPUT-AREA end-read.
    if IN-R = 'Y'
        perform L1
    else
        if IN-R = 'N'
            perform B4
        else
            perform B3
        end-if
    end-if.
B4. CLOSE STANDARD-INPUT, STANDARD-OUTPUT. 
    STOP RUN.
