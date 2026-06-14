IDENTIFICATION DIVISION.
PROGRAM-ID. RUN-TESTS.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-GLOBAL-PASSED   PIC 9(03) VALUE 0.
01 WS-GLOBAL-FAILED   PIC 9(03) VALUE 0.

PROCEDURE DIVISION.
MAIN.
    DISPLAY "========================================="
    DISPLAY " NUMBERS — Pruebas unitarias"
    DISPLAY "========================================="
    DISPLAY " "

    CALL "RECURSIVE-TESTS"
    ADD RETURN-CODE TO WS-GLOBAL-FAILED

    CALL "ITERATIVE-TESTS"
    ADD RETURN-CODE TO WS-GLOBAL-FAILED

    DISPLAY " "
    DISPLAY "========================================="
        DISPLAY " GLOBAL RESULTS"
    DISPLAY "========================================="
    IF WS-GLOBAL-FAILED > 0
        DISPLAY "  >>> SOME TESTS FAILED <<<"
        MOVE 1 TO RETURN-CODE
    ELSE
        DISPLAY "  >>> ALL TESTS PASSED <<<"
        MOVE 0 TO RETURN-CODE
    END-IF

    STOP RUN.

END PROGRAM RUN-TESTS.
