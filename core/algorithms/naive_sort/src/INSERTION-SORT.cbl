*> ====================================================================
*> INSERTION-SORT.cbl — Insertion Sort algorithm
*> ====================================================================

IDENTIFICATION DIVISION.
PROGRAM-ID. INSERTION-SORT.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-I              PIC 9(02).
01 WS-J              PIC 9(02).
01 WS-KEY            PIC S9(9).
01 WS-LENGTH         PIC 9(02).

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
    
    *> Insertion sort algorithm
    PERFORM VARYING WS-I FROM 2 BY 1 UNTIL WS-I > WS-LENGTH
        MOVE LN-ENTRY(WS-I) TO WS-KEY
        SUBTRACT 1 FROM WS-I GIVING WS-J
        PERFORM UNTIL WS-J < 1 OR LN-ENTRY(WS-J) <= WS-KEY
            MOVE LN-ENTRY(WS-J) TO LN-ENTRY(WS-J + 1)
            SUBTRACT 1 FROM WS-J
        END-PERFORM
        ADD 1 TO WS-J GIVING WS-J
        MOVE WS-KEY TO LN-ENTRY(WS-J)
    END-PERFORM
    
    MOVE 0 TO RETURN-CODE
    GOBACK.

END PROGRAM INSERTION-SORT.
