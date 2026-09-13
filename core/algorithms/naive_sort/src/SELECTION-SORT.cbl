*> ====================================================================
*> SELECTION-SORT.cbl — Selection Sort algorithm
*> ====================================================================

IDENTIFICATION DIVISION.
PROGRAM-ID. SELECTION-SORT.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-I              PIC 9(02).
01 WS-J              PIC 9(02).
01 WS-MIN-IDX        PIC 9(02).
01 WS-TEMP           PIC S9(9).
01 WS-LENGTH         PIC 9(02).
01 WS-J-START        PIC 9(02).

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
    
    *> Selection sort algorithm
    PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I >= WS-LENGTH
        MOVE WS-I TO WS-MIN-IDX
        COMPUTE WS-J-START = WS-I + 1
        PERFORM VARYING WS-J FROM WS-J-START BY 1 UNTIL WS-J > WS-LENGTH
            IF LN-ENTRY(WS-J) < LN-ENTRY(WS-MIN-IDX)
                MOVE WS-J TO WS-MIN-IDX
            END-IF
        END-PERFORM
        IF WS-MIN-IDX NOT EQUAL WS-I
            MOVE LN-ENTRY(WS-I) TO WS-TEMP
            MOVE LN-ENTRY(WS-MIN-IDX) TO LN-ENTRY(WS-I)
            MOVE WS-TEMP TO LN-ENTRY(WS-MIN-IDX)
        END-IF
    END-PERFORM
    
    MOVE 0 TO RETURN-CODE
    GOBACK.

END PROGRAM SELECTION-SORT.
