*> ====================================================================
*> NUMBERS.cbl — Algoritmos numericos en 3 enfoques
*> ====================================================================

*> ====================================================================
*> SUM-REC
*> ====================================================================
PROGRAM-ID. SUM-REC IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 WS-N         PIC S9(9).
01 WS-SUB-RES   PIC S9(9).
LINKAGE SECTION.
01 LN-N         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-N LN-RESULT.
    IF LN-N <= 0
        MOVE 0 TO LN-RESULT
    ELSE
        COMPUTE WS-N = LN-N - 1
        CALL "SUM-REC" USING WS-N WS-SUB-RES
        COMPUTE LN-RESULT = LN-N + WS-SUB-RES
    END-IF
    GOBACK.
END PROGRAM SUM-REC.

*> ====================================================================
*> FACTORIAL-REC
*> ====================================================================
PROGRAM-ID. FACTORIAL-REC IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 WS-N         PIC S9(9).
01 WS-SUB-RES   PIC S9(9).
LINKAGE SECTION.
01 LN-N         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-N LN-RESULT.
    IF LN-N <= 1
        MOVE 1 TO LN-RESULT
    ELSE
        COMPUTE WS-N = LN-N - 1
        CALL "FACTORIAL-REC" USING WS-N WS-SUB-RES
        COMPUTE LN-RESULT = LN-N * WS-SUB-RES
    END-IF
    GOBACK.
END PROGRAM FACTORIAL-REC.

*> ====================================================================
*> FIBONACCI-REC
*> ====================================================================
PROGRAM-ID. FIBONACCI-REC IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 WS-N1        PIC S9(9).
01 WS-N2        PIC S9(9).
01 WS-RES1      PIC S9(9).
01 WS-RES2      PIC S9(9).
LINKAGE SECTION.
01 LN-N         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-N LN-RESULT.
    IF LN-N <= 1
        MOVE LN-N TO LN-RESULT
    ELSE
        COMPUTE WS-N1 = LN-N - 1
        COMPUTE WS-N2 = LN-N - 2
        CALL "FIBONACCI-REC" USING WS-N1 WS-RES1
        CALL "FIBONACCI-REC" USING WS-N2 WS-RES2
        COMPUTE LN-RESULT = WS-RES1 + WS-RES2
    END-IF
    GOBACK.
END PROGRAM FIBONACCI-REC.

*> ====================================================================
*> GCD-REC — Maximo comun divisor (recursivo, Euclides)
*>   gcd_rec(a, b) = a si b = 0, gcd_rec(b, a MOD b) si b != 0
*> ====================================================================
PROGRAM-ID. GCD-REC IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 WS-A         PIC S9(9).
01 WS-B         PIC S9(9).
01 WS-SUB-RES   PIC S9(9).
LINKAGE SECTION.
01 LN-A         PIC S9(9).
01 LN-B         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-A LN-B LN-RESULT.
    IF LN-B = 0
        MOVE LN-A TO LN-RESULT
    ELSE
        MOVE LN-B TO WS-A
        COMPUTE WS-B = FUNCTION MOD(LN-A, LN-B)
        CALL "GCD-REC" USING WS-A WS-B WS-SUB-RES
        MOVE WS-SUB-RES TO LN-RESULT
    END-IF
    GOBACK.
END PROGRAM GCD-REC.

*> ====================================================================
*> LCM-REC — Minimo comun multiplo (usa GCD-REC)
*>   lcm_rec(a, b) = (a * b) / gcd_rec(a, b)
*> ====================================================================
PROGRAM-ID. LCM-REC.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-A         PIC S9(9).
01 WS-B         PIC S9(9).
01 WS-GCD-VAL   PIC S9(9).
LINKAGE SECTION.
01 LN-A         PIC S9(9).
01 LN-B         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-A LN-B LN-RESULT.
    MOVE LN-A TO WS-A
    MOVE LN-B TO WS-B
    CALL "GCD-REC" USING WS-A WS-B WS-GCD-VAL
    IF WS-GCD-VAL NOT = 0
        COMPUTE LN-RESULT =
            (LN-A * LN-B) / WS-GCD-VAL
    ELSE
        MOVE 0 TO LN-RESULT
    END-IF
    GOBACK.
END PROGRAM LCM-REC.

*> ====================================================================
*> SUM-ACC
*> ====================================================================
PROGRAM-ID. SUM-ACC.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-N         PIC S9(9).
01 WS-ACC       PIC S9(9).
LINKAGE SECTION.
01 LN-N         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-N LN-RESULT.
    MOVE LN-N TO WS-N
    MOVE 0 TO WS-ACC
    CALL "SUM-ACC-HELP" USING WS-N WS-ACC LN-RESULT
    GOBACK.
END PROGRAM SUM-ACC.

PROGRAM-ID. SUM-ACC-HELP IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 WS-N         PIC S9(9).
01 WS-ACC       PIC S9(9).
LINKAGE SECTION.
01 LN-N         PIC S9(9).
01 LN-ACC       PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-N LN-ACC LN-RESULT.
    IF LN-N <= 0
        MOVE LN-ACC TO LN-RESULT
    ELSE
        COMPUTE WS-N = LN-N - 1
        COMPUTE WS-ACC = LN-N + LN-ACC
        CALL "SUM-ACC-HELP" USING WS-N WS-ACC LN-RESULT
    END-IF
    GOBACK.
END PROGRAM SUM-ACC-HELP.

*> ====================================================================
*> FACTORIAL-ACC
*> ====================================================================
PROGRAM-ID. FACTORIAL-ACC.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-N         PIC S9(9).
01 WS-ACC       PIC S9(9).
LINKAGE SECTION.
01 LN-N         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-N LN-RESULT.
    MOVE LN-N TO WS-N
    MOVE 1 TO WS-ACC
    CALL "FACTORIAL-ACC-HELP" USING WS-N WS-ACC LN-RESULT
    GOBACK.
END PROGRAM FACTORIAL-ACC.

PROGRAM-ID. FACTORIAL-ACC-HELP IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 WS-N         PIC S9(9).
01 WS-ACC       PIC S9(9).
LINKAGE SECTION.
01 LN-N         PIC S9(9).
01 LN-ACC       PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-N LN-ACC LN-RESULT.
    IF LN-N <= 1
        MOVE LN-ACC TO LN-RESULT
    ELSE
        COMPUTE WS-N = LN-N - 1
        COMPUTE WS-ACC = LN-N * LN-ACC
        CALL "FACTORIAL-ACC-HELP" USING WS-N WS-ACC LN-RESULT
    END-IF
    GOBACK.
END PROGRAM FACTORIAL-ACC-HELP.

*> ====================================================================
*> FIBONACCI-ACC
*> ====================================================================
PROGRAM-ID. FIBONACCI-ACC.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-N         PIC S9(9).
01 WS-ACC1      PIC S9(9).
01 WS-ACC2      PIC S9(9).
LINKAGE SECTION.
01 LN-N         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-N LN-RESULT.
    IF LN-N <= 0
        MOVE 0 TO LN-RESULT
    ELSE
        MOVE LN-N TO WS-N
        MOVE 0 TO WS-ACC2
        MOVE 1 TO WS-ACC1
        CALL "FIBONACCI-ACC-HELP"
            USING WS-N WS-ACC2 WS-ACC1 LN-RESULT
    END-IF
    GOBACK.
END PROGRAM FIBONACCI-ACC.

PROGRAM-ID. FIBONACCI-ACC-HELP IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 WS-N         PIC S9(9).
01 WS-ACC1      PIC S9(9).
01 WS-ACC2      PIC S9(9).
LINKAGE SECTION.
01 LN-N         PIC S9(9).
01 LN-ACC2      PIC S9(9).
01 LN-ACC1      PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-N LN-ACC2 LN-ACC1 LN-RESULT.
    IF LN-N <= 0
        MOVE 0 TO LN-RESULT
    END-IF
    IF LN-N = 1
        MOVE LN-ACC1 TO LN-RESULT
    ELSE
        COMPUTE WS-N = LN-N - 1
        MOVE LN-ACC1 TO WS-ACC2
        COMPUTE WS-ACC1 = LN-ACC1 + LN-ACC2
        CALL "FIBONACCI-ACC-HELP"
            USING WS-N WS-ACC2 WS-ACC1 LN-RESULT
    END-IF
    GOBACK.
END PROGRAM FIBONACCI-ACC-HELP.

*> ====================================================================
*> GCD-ACC
*> ====================================================================
PROGRAM-ID. GCD-ACC.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-A         PIC S9(9).
01 WS-B         PIC S9(9).
LINKAGE SECTION.
01 LN-A         PIC S9(9).
01 LN-B         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-A LN-B LN-RESULT.
    MOVE LN-A TO WS-A
    MOVE LN-B TO WS-B
    CALL "GCD-ACC-HELP" USING WS-A WS-B LN-RESULT
    GOBACK.
END PROGRAM GCD-ACC.

PROGRAM-ID. GCD-ACC-HELP IS RECURSIVE.
DATA DIVISION.
LOCAL-STORAGE SECTION.
01 WS-A         PIC S9(9).
01 WS-B         PIC S9(9).
LINKAGE SECTION.
01 LN-A         PIC S9(9).
01 LN-B         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-A LN-B LN-RESULT.
    IF LN-B = 0
        MOVE LN-A TO LN-RESULT
    ELSE
        MOVE LN-B TO WS-A
        COMPUTE WS-B = FUNCTION MOD(LN-A, LN-B)
        CALL "GCD-ACC-HELP" USING WS-A WS-B LN-RESULT
    END-IF
    GOBACK.
END PROGRAM GCD-ACC-HELP.

*> ====================================================================
*> LCM-ACC
*> ====================================================================
PROGRAM-ID. LCM-ACC.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-A         PIC S9(9).
01 WS-B         PIC S9(9).
01 WS-GCD-VAL   PIC S9(9).
LINKAGE SECTION.
01 LN-A         PIC S9(9).
01 LN-B         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-A LN-B LN-RESULT.
    MOVE LN-A TO WS-A
    MOVE LN-B TO WS-B
    CALL "GCD-ACC" USING WS-A WS-B WS-GCD-VAL
    IF WS-GCD-VAL NOT = 0
        COMPUTE LN-RESULT =
            (LN-A * LN-B) / WS-GCD-VAL
    ELSE
        MOVE 0 TO LN-RESULT
    END-IF
    GOBACK.
END PROGRAM LCM-ACC.

*> ====================================================================
*> SUM-ITE
*> ====================================================================
PROGRAM-ID. SUM-ITE.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-I         PIC S9(9).
LINKAGE SECTION.
01 LN-N         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-N LN-RESULT.
    MOVE 0 TO LN-RESULT
    PERFORM VARYING WS-I FROM 1 BY 1
            UNTIL WS-I > LN-N
        ADD WS-I TO LN-RESULT
    END-PERFORM
    GOBACK.
END PROGRAM SUM-ITE.

*> ====================================================================
*> FACTORIAL-ITE
*> ====================================================================
PROGRAM-ID. FACTORIAL-ITE.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-I         PIC S9(9).
LINKAGE SECTION.
01 LN-N         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-N LN-RESULT.
    MOVE 1 TO LN-RESULT
    IF LN-N > 1
        PERFORM VARYING WS-I FROM 2 BY 1
                UNTIL WS-I > LN-N
            MULTIPLY WS-I BY LN-RESULT
        END-PERFORM
    END-IF
    GOBACK.
END PROGRAM FACTORIAL-ITE.

*> ====================================================================
*> FIBONACCI-ITE
*> ====================================================================
PROGRAM-ID. FIBONACCI-ITE.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-I         PIC S9(9).
01 WS-ACC1      PIC S9(9).
01 WS-ACC2      PIC S9(9).
01 WS-TEMP      PIC S9(9).
LINKAGE SECTION.
01 LN-N         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-N LN-RESULT.
    IF LN-N <= 1
        MOVE LN-N TO LN-RESULT
    ELSE
        MOVE 0 TO WS-ACC2
        MOVE 1 TO WS-ACC1
        PERFORM VARYING WS-I FROM 2 BY 1
                UNTIL WS-I > LN-N
            COMPUTE WS-TEMP = WS-ACC1 + WS-ACC2
            MOVE WS-ACC1 TO WS-ACC2
            MOVE WS-TEMP TO WS-ACC1
        END-PERFORM
        MOVE WS-ACC1 TO LN-RESULT
    END-IF
    GOBACK.
END PROGRAM FIBONACCI-ITE.

*> ====================================================================
*> GCD-ITE
*> ====================================================================
PROGRAM-ID. GCD-ITE.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-A         PIC S9(9).
01 WS-B         PIC S9(9).
01 WS-TEMP      PIC S9(9).
LINKAGE SECTION.
01 LN-A         PIC S9(9).
01 LN-B         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-A LN-B LN-RESULT.
    MOVE LN-A TO WS-A
    MOVE LN-B TO WS-B
    PERFORM UNTIL WS-B = 0
        MOVE WS-B TO WS-TEMP
        COMPUTE WS-B = FUNCTION MOD(WS-A, WS-B)
        MOVE WS-TEMP TO WS-A
    END-PERFORM
    MOVE WS-A TO LN-RESULT
    GOBACK.
END PROGRAM GCD-ITE.

*> ====================================================================
*> LCM-ITE
*> ====================================================================
PROGRAM-ID. LCM-ITE.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-A         PIC S9(9).
01 WS-B         PIC S9(9).
01 WS-GCD-VAL   PIC S9(9).
LINKAGE SECTION.
01 LN-A         PIC S9(9).
01 LN-B         PIC S9(9).
01 LN-RESULT    PIC S9(9).
PROCEDURE DIVISION USING LN-A LN-B LN-RESULT.
    MOVE LN-A TO WS-A
    MOVE LN-B TO WS-B
    CALL "GCD-ITE" USING WS-A WS-B WS-GCD-VAL
    IF WS-GCD-VAL NOT = 0
        COMPUTE LN-RESULT =
            (LN-A * LN-B) / WS-GCD-VAL
    ELSE
        MOVE 0 TO LN-RESULT
    END-IF
    GOBACK.
END PROGRAM LCM-ITE.
