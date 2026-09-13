*> ====================================================================
*> BUBBLE-SORT.cbl — Bubble Sort algorithm with early-exit optimization
*> ====================================================================

IDENTIFICATION DIVISION.
PROGRAM-ID. BUBBLE-SORT.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-I              PIC 9(02).
01 WS-J              PIC 9(02).
01 WS-TEMP           PIC S9(9).
01 WS-SWAPPED        PIC 9(01) VALUE 0.
01 WS-LENGTH         PIC 9(02).
01 WS-INNER-LIMIT    PIC 9(02).

LINKAGE SECTION.
01 LN-ARRAY.
   05 LN-ENTRY       PIC S9(9) OCCURS 6 TIMES.
01 LN-LENGTH         PIC 9(02).

PROCEDURE DIVISION USING LN-ARRAY LN-LENGTH.
    MOVE LN-LENGTH TO WS-LENGTH
    
    *> If length is 0 or 1, array is already sorted
    IF WS-LENGTH <= 1
        MOVE 0 TO RETURN-CODE
        GOBACK
    END-IF
    
    *> Bubble sort algorithm with early-exit optimization
    PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I >= WS-LENGTH
        MOVE 0 TO WS-SWAPPED
        COMPUTE WS-INNER-LIMIT = WS-LENGTH - WS-I
        PERFORM VARYING WS-J FROM 1 BY 1 UNTIL WS-J > WS-INNER-LIMIT
            IF LN-ENTRY(WS-J) > LN-ENTRY(WS-J + 1)
                MOVE LN-ENTRY(WS-J) TO WS-TEMP
                MOVE LN-ENTRY(WS-J + 1) TO LN-ENTRY(WS-J)
                MOVE WS-TEMP TO LN-ENTRY(WS-J + 1)
                MOVE 1 TO WS-SWAPPED
            END-IF
        END-PERFORM
        IF WS-SWAPPED = 0
            EXIT PERFORM
        END-IF
    END-PERFORM
    
    MOVE 0 TO RETURN-CODE
    GOBACK.

END PROGRAM BUBBLE-SORT.
