# Calculator — COBOL

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **COBOL**, compilado con **GnuCOBOL (cobc)** y probado con un test runner propio (sin framework externo).

Implementa las 5 operaciones aritméticas básicas usando únicamente suma y resta (sin operadores `*`, `/` ni `MOD` directos), con propósitos educativos.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| `src/CALCULATOR.cbl` | Subprograma con las 5 operaciones aritméticas básicas. |
| `src/CALCULATOR-PARAMS.cpy` | Copybook con la estructura de parámetros (`CALC-PARAMS`), compartida entre `CALCULATOR` y `RUN-TESTS`. |
| `test/RUN-TESTS.cbl` | Suite de pruebas unitarias con tabla de datos (`OCCURS`). |
| `test/ASSERTS.cpy` | Copybook con utilidades de aserción reutilizables (`ASSERT-EQUAL`, `ASSERT-REPORT`). |
| `Makefile` | Automatización de compilación y pruebas. |
| `.gitignore` | Ignora artefactos compilados (`run_tests`, `*.so`, `*.o`). |
| `config.properties` | Configuración para COBOLCheck (no utilizado). |

**Estructura de directorios esperada:**

```text
calculator/
├── .gitignore                  # Artefactos ignorados
├── src/
│   ├── CALCULATOR.cbl          # Implementacion (formato libre)
│   └── CALCULATOR-PARAMS.cpy   # Copybook de parametros
├── test/
│   ├── RUN-TESTS.cbl           # Test runner (tabla + bucle)
│   └── ASSERTS.cpy             # Copybook de aserciones
├── Makefile                    # Build y pruebas
└── README.md                   # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto sigue las buenas prácticas de COBOL empresarial:

1. **Subprograma único** (`CALCULATOR.cbl`) con las 5 operaciones como párrafos internos, invocado mediante `CALL`.
2. **Copybook de parámetros** (`CALCULATOR-PARAMS.cpy`) con un grupo `01 CALC-PARAMS` que garantiza que el layout de memoria entre llamador y llamado sea idéntico.
3. **Copybook de aserciones** (`ASSERTS.cpy`) con párrafos `ASSERT-EQUAL` y `ASSERT-REPORT` reutilizables en cualquier suite de pruebas.
4. **Tabla de datos** (`OCCURS 5 TIMES`) en el test runner, eliminando código repetitivo mediante un bucle `PERFORM VARYING`.
5. **Formato libre** (`-free`) consistente en todos los archivos.

**EN:** The project follows enterprise COBOL best practices:

1. **Single subprogram** (`CALCULATOR.cbl`) with the 5 operations as internal paragraphs, invoked via `CALL`.
2. **Parameter copybook** (`CALCULATOR-PARAMS.cpy`) with a `01 CALC-PARAMS` group ensuring identical memory layout between caller and callee.
3. **Assert copybook** (`ASSERTS.cpy`) with reusable `ASSERT-EQUAL` and `ASSERT-REPORT` paragraphs.
4. **Data table** (`OCCURS 5 TIMES`) in the test runner, eliminating repetitive code via a `PERFORM VARYING` loop.
5. **Free format** (`-free`) consistently across all files.

### Cómo se creó / How it was created

```bash
make test
```

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `src/CALCULATOR-PARAMS.cpy` — Copybook de parámetros

**ES:** Define un grupo de 4 campos que se pasa como un único parámetro a `CALCULATOR`. Ambos programas (`CALCULATOR.cbl` y `RUN-TESTS.cbl`) incluyen este copybook, garantizando que el layout de memoria coincida exactamente.

**EN:** Defines a 4-field group passed as a single parameter to `CALCULATOR`. Both programs (`CALCULATOR.cbl` and `RUN-TESTS.cbl`) include this copybook, ensuring identical memory layout.

```cobol
01 CALC-PARAMS.
   05 CALC-OP-CODE     PIC 9(1).
   05 CALC-A           PIC S9(9).
   05 CALC-B           PIC S9(9).
   05 CALC-RESULT      PIC S9(9).
```

| Campo | Propósito |
|-------|-----------|
| `CALC-OP-CODE` | Código de operación (1=suma, 2=resta, 3=mult, 4=div, 5=módulo) |
| `CALC-A` | Primer operando |
| `CALC-B` | Segundo operando |
| `CALC-RESULT` | Resultado de la operación |

### `src/CALCULATOR.cbl` — Implementación

**ES:** Subprograma COBOL invocado mediante `CALL "CALCULATOR" USING CALC-PARAMS`. Usa `LINKAGE SECTION` para recibir parámetros y `GOBACK` para retornar. Las 5 operaciones se implementan como párrafos internos, despachadas con `EVALUATE`.

**EN:** COBOL subprogram invoked via `CALL "CALCULATOR" USING CALC-PARAMS`. Uses `LINKAGE SECTION` to receive parameters and `GOBACK` to return. The 5 operations are implemented as internal paragraphs, dispatched via `EVALUATE`.

```cobol
LINKAGE SECTION.
COPY CALCULATOR-PARAMS.

PROCEDURE DIVISION USING CALC-PARAMS.
MAIN.
    EVALUATE CALC-OP-CODE
        WHEN 1
            PERFORM ADDITION
        WHEN 2
            PERFORM SUBTRACTION
        ...
    END-EVALUATE
    GOBACK.
```

### `test/ASSERTS.cpy` — Copybook de aserciones

**ES:** Proporciona dos párrafos reutilizables:
- `ASSERT-EQUAL` — compara `WS-ASSERT-ACTUAL` con `WS-ASSERT-EXPECTED` e imprime `[OK]` o `[FAIL]`.
- `ASSERT-REPORT` — muestra el resumen final y establece `RETURN-CODE`.

Se incluye via `COPY ASSERTS` en la `PROCEDURE DIVISION`.

**EN:** Provides two reusable paragraphs:
- `ASSERT-EQUAL` — compares `WS-ASSERT-ACTUAL` with `WS-ASSERT-EXPECTED` and prints `[OK]` or `[FAIL]`.
- `ASSERT-REPORT` — shows the final summary and sets `RETURN-CODE`.

Included via `COPY ASSERTS` in the `PROCEDURE DIVISION`.

```cobol
COPY ASSERTS.
...
MOVE <expected> TO WS-ASSERT-EXPECTED
MOVE <actual>   TO WS-ASSERT-ACTUAL
MOVE "<name>"   TO WS-ASSERT-NAME
PERFORM ASSERT-EQUAL
...
PERFORM ASSERT-REPORT
```

### `test/RUN-TESTS.cbl` — Test runner

**ES:** Usa una tabla `OCCURS 5 TIMES` para definir los 5 casos de prueba (operación, operandos, resultado esperado). Un bucle `PERFORM VARYING` itera sobre la tabla, invoca `CALCULATOR` y verifica con `ASSERT-EQUAL`.

**EN:** Uses an `OCCURS 5 TIMES` table to define the 5 test cases (operation, operands, expected result). A `PERFORM VARYING` loop iterates over the table, invokes `CALCULATOR`, and verifies with `ASSERT-EQUAL`.

```cobol
PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-TEST-COUNT
    MOVE TC-OP-CODE(WS-IDX) TO CALC-OP-CODE
    MOVE TC-A(WS-IDX)       TO CALC-A
    MOVE TC-B(WS-IDX)       TO CALC-B
    ...
    CALL "CALCULATOR" USING CALC-PARAMS
    PERFORM ASSERT-EQUAL
END-PERFORM
```

### `Makefile` — Automatización

**ES:** Targets disponibles:
- `make build` — Compila con `cobc -x -free -Isrc -Itest`.
- `make test` — Compila y ejecuta `run_tests`.
- `make clean` — Limpia artefactos compilados.

**EN:** Available targets:
- `make build` — Compiles with `cobc -x -free -Isrc -Itest`.
- `make test` — Builds and runs `run_tests`.
- `make clean` — Cleans compiled artifacts.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener GnuCOBOL instalado

```bash
# Linux (Debian/Ubuntu)
sudo apt install gnucobol

# macOS (con Homebrew)
brew install gnucobol

# Verificar instalación
cobc --version
```

### Compilar y ejecutar pruebas

```bash
make test
```

O manualmente:

```bash
cobc -x -free -Isrc -Itest -o run_tests test/RUN-TESTS.cbl src/CALCULATOR.cbl
./run_tests
```

**Salida esperada / Expected output:**

```text
Ejecutando pruebas de CALCULATOR...

  [OK] Suma: 2 + 3
  [OK] Resta: 5 - 2
  [OK] Mult: 3 * 4
  [OK] Div: 10 / 3
  [OK] Mod: 10 % 3

RESUMEN:
  Total:     005
  Pasadas:   005
  Falladas:  000
  >>> TODAS LAS PRUEBAS PASARON <<<
```

---

## 🧠 Algoritmos / operaciones

| Operación | Código | Algoritmo | Descripción |
|-----------|--------|-----------|-------------|
| Suma | `1` | Directo | `ADD CALC-A TO CALC-B GIVING CALC-RESULT` |
| Resta | `2` | Directo | `SUBTRACT CALC-B FROM CALC-A GIVING CALC-RESULT` |
| Multiplicación | `3` | Iterativo | `PERFORM VARYING` sumando `CALC-A` repetidamente (sin `*`) |
| División | `4` | Iterativo | `PERFORM UNTIL` restando `CALC-B` de `CALC-A` (sin `/`) |
| Módulo | `5` | Compuesto educ. | `division(a,b)` → cociente → `multiplication(cociente,b)` → `a - producto` |

> **ES:** `modulus` sigue exactamente el pseudocódigo de la especificación: llama a `DIVISION-PROC` para obtener el cociente, luego a `MULTIPLICATION` (suma repetitiva) para el producto, y finalmente resta. No usa el operador `*` ni `MOD` directos.
> **EN:** `modulus` follows the specification pseudocode exactly: calls `DIVISION-PROC` for the quotient, then `MULTIPLICATION` (repeated addition) for the product, and finally subtracts. It does not use the `*` or `MOD` operators directly.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Todos los archivos usan **formato libre** (`-free`). Los comentarios usan `*>` en lugar de `*` para evitar que GnuCOBOL interprete palabras clave dentro de comentarios.
- **EN:** All files use **free format** (`-free`). Comments use `*>` instead of `*` to prevent GnuCOBOL from interpreting keywords inside comments.
- **ES:** El copybook `CALCULATOR-PARAMS.cpy` se incluye tanto en `LINKAGE SECTION` (llamado) como en `WORKING-STORAGE` (llamador), garantizando que el layout de los parámetros coincida exactamente.
- **EN:** The `CALCULATOR-PARAMS.cpy` copybook is included both in `LINKAGE SECTION` (callee) and `WORKING-STORAGE` (caller), ensuring the parameter layout matches exactly.
- **ES:** El subprograma usa `GOBACK` para retornar al llamador. El programa principal usa `STOP RUN` para terminar.
- **EN:** The subprogram uses `GOBACK` to return to the caller. The main program uses `STOP RUN` to terminate.
- **ES:** Las variables de `WORKING-STORAGE` se inicializan con `VALUE` para evitar valores basura.
- **EN:** `WORKING-STORAGE` variables are initialized with `VALUE` to prevent garbage values.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
