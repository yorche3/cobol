*> ASSERTS.cpy
*> Utilidades reutilizables para pruebas unitarias en COBOL.
*> Uso: declarar contadores en WORKING-STORAGE y COPY en PROCEDURE DIVISION.

ASSERT-EQUAL.
    ADD 1 TO WS-ASSERT-TOTAL.
    IF WS-ASSERT-ACTUAL = WS-ASSERT-EXPECTED
        ADD 1 TO WS-ASSERT-PASSED
        DISPLAY "  [OK] " WS-ASSERT-NAME
    ELSE
        ADD 1 TO WS-ASSERT-FAILED
        DISPLAY "  [FAIL] " WS-ASSERT-NAME
                DISPLAY "         Expected: " WS-ASSERT-EXPECTED
                DISPLAY "           Actual: " WS-ASSERT-ACTUAL
    END-IF.

ASSERT-REPORT.
    DISPLAY " "
    DISPLAY "SUMMARY:"
    DISPLAY "  Total:    " WS-ASSERT-TOTAL
    DISPLAY "  Passed:   " WS-ASSERT-PASSED
    DISPLAY "  Failed:   " WS-ASSERT-FAILED
    IF WS-ASSERT-FAILED > 0
        DISPLAY "  >>> SOME TESTS FAILED <<<"
        MOVE 1 TO RETURN-CODE
    ELSE
        DISPLAY "  >>> ALL TESTS PASSED <<<"
        MOVE 0 TO RETURN-CODE
    END-IF.
