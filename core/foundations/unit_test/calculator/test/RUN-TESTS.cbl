       IDENTIFICATION DIVISION.
       PROGRAM-ID. RUN-TESTS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-TOTAL-PRUEBAS  PIC 9(03) VALUE 0.
       01 WS-PASADOS        PIC 9(03) VALUE 0.
       01 WS-FALLADOS       PIC 9(03) VALUE 0.
       01 WS-OP-CODE        PIC 9(1).
       01 WS-A              PIC S9(9).
       01 WS-B              PIC S9(9).
       01 WS-RESULTADO      PIC S9(9).
       01 WS-ESPERADO       PIC S9(9).
       01 WS-NOMBRE-PRUEBA  PIC X(30).

       PROCEDURE DIVISION.
       MAIN.
           MOVE 0 TO WS-TOTAL-PRUEBAS
                       WS-PASADOS
                       WS-FALLADOS.

           DISPLAY "Ejecutando pruebas de CALCULATOR..."
           DISPLAY " "

      *> Prueba 1: Suma (2 + 3 = 5)
           MOVE "Suma: 2 + 3" TO WS-NOMBRE-PRUEBA
           MOVE 1 TO WS-OP-CODE
           MOVE 2 TO WS-A
           MOVE 3 TO WS-B
           MOVE 5 TO WS-ESPERADO
           CALL "CALCULATOR" USING WS-OP-CODE WS-A WS-B WS-RESULTADO
           PERFORM VERIFICAR-RESULTADO

      *> Prueba 2: Resta (5 - 2 = 3)
           MOVE "Resta: 5 - 2" TO WS-NOMBRE-PRUEBA
           MOVE 2 TO WS-OP-CODE
           MOVE 5 TO WS-A
           MOVE 2 TO WS-B
           MOVE 3 TO WS-ESPERADO
           CALL "CALCULATOR" USING WS-OP-CODE WS-A WS-B WS-RESULTADO
           PERFORM VERIFICAR-RESULTADO

      *> Prueba 3: Multiplicacion (3 * 4 = 12)
           MOVE "Mult: 3 * 4" TO WS-NOMBRE-PRUEBA
           MOVE 3 TO WS-OP-CODE
           MOVE 3 TO WS-A
           MOVE 4 TO WS-B
           MOVE 12 TO WS-ESPERADO
           CALL "CALCULATOR" USING WS-OP-CODE WS-A WS-B WS-RESULTADO
           PERFORM VERIFICAR-RESULTADO

      *> Prueba 4: Division (10 / 3 = 3)
           MOVE "Div: 10 / 3" TO WS-NOMBRE-PRUEBA
           MOVE 4 TO WS-OP-CODE
           MOVE 10 TO WS-A
           MOVE 3 TO WS-B
           MOVE 3 TO WS-ESPERADO
           CALL "CALCULATOR" USING WS-OP-CODE WS-A WS-B WS-RESULTADO
           PERFORM VERIFICAR-RESULTADO

      *> Prueba 5: Modulo (10 % 3 = 1)
           MOVE "Mod: 10 % 3" TO WS-NOMBRE-PRUEBA
           MOVE 5 TO WS-OP-CODE
           MOVE 10 TO WS-A
           MOVE 3 TO WS-B
           MOVE 1 TO WS-ESPERADO
           CALL "CALCULATOR" USING WS-OP-CODE WS-A WS-B WS-RESULTADO
           PERFORM VERIFICAR-RESULTADO

           DISPLAY " "
           DISPLAY "RESULTADOS:"
           DISPLAY "  Pruebas ejecutadas: " WS-TOTAL-PRUEBAS
           DISPLAY "  Pasadas: " WS-PASADOS
           DISPLAY "  Falladas: " WS-FALLADOS

           IF WS-FALLADOS > 0
               MOVE 1 TO RETURN-CODE
           ELSE
               MOVE 0 TO RETURN-CODE
           END-IF

           GOBACK.

       VERIFICAR-RESULTADO.
           ADD 1 TO WS-TOTAL-PRUEBAS.
           IF WS-RESULTADO = WS-ESPERADO
               ADD 1 TO WS-PASADOS
               DISPLAY "  [OK] " WS-NOMBRE-PRUEBA
           ELSE
               ADD 1 TO WS-FALLADOS
               DISPLAY "  [FAIL] " WS-NOMBRE-PRUEBA
               DISPLAY "         Esperado: " WS-ESPERADO
               DISPLAY "         Obtenido: " WS-RESULTADO
           END-IF.
           EXIT.
