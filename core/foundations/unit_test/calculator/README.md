# Calculator — COBOL

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **COBOL**, compilado con **GnuCOBOL (cobc)** y probado con un test runner propio (sin framework externo).

Implementa las 5 operaciones aritméticas básicas usando únicamente suma y resta (sin operadores `*`, `/` ni `MOD` directos), con propósitos educativos.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| `src/CALCULATOR.cbl` | Implementación de las 5 operaciones aritméticas básicas. |
| `test/RUN-TESTS.cbl` | Suite de pruebas unitarias (test runner propio). |
| `test/ASSERTS.cpy` | Copybook de aserciones (reservado para uso futuro). |
| `Makefile` | Automatización de compilación y pruebas. |
| `config.properties` | Configuración para COBOLCheck (no utilizado actualmente). |

**Estructura de directorios esperada:**

```text
calculator/
├── src/
│   └── CALCULATOR.cbl         # Implementación (formato libre)
├── test/
│   ├── RUN-TESTS.cbl          # Test runner
│   └── ASSERTS.cpy            # Copybook de aserciones
├── Makefile                   # Build y pruebas
├── config.properties          # Config. COBOLCheck
└── README.md                  # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se construyó manualmente con un único archivo fuente y un test runner propio, usando **GnuCOBOL** como compilador.

1. **Biblioteca** — `src/CALCULATOR.cbl` con las 5 operaciones como subprograma (`CALL`).
2. **Pruebas** — `test/RUN-TESTS.cbl` con 5 tests mediante `CALL` + verificación manual con `IF`.
3. **Makefile** — Compila ambos fuentes juntos y ejecuta el test runner.

**EN:** The project was built manually with a single source file and a custom test runner, using **GnuCOBOL** as the compiler.

1. **Library** — `src/CALCULATOR.cbl` with the 5 operations as a subprogram (`CALL`).
2. **Tests** — `test/RUN-TESTS.cbl` with 5 tests via `CALL` + manual verification with `IF`.
3. **Makefile** — Compiles both sources together and runs the test runner.

### Cómo se creó / How it was created

```bash
# Compilar y ejecutar pruebas
make test
```

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `src/CALCULATOR.cbl` — Implementación

**ES:** Subprograma COBOL invocado mediante `CALL`. Recibe 4 parámetros via `LINKAGE SECTION`:
- `OP-CODE` (1: suma, 2: resta, 3: mult, 4: div, 5: módulo)
- `A`, `B` (operandos)
- `RESULT` (resultado)

Usa `EVALUATE` para seleccionar la operación, similar a un `switch` en otros lenguajes.

**EN:** COBOL subprogram invoked via `CALL`. Receives 4 parameters via `LINKAGE SECTION`:
- `OP-CODE` (1: add, 2: subtract, 3: multiply, 4: divide, 5: modulus)
- `A`, `B` (operands)
- `RESULT` (result)

Uses `EVALUATE` to select the operation, similar to a `switch` in other languages.

```cobol
PROCEDURE DIVISION USING OP-CODE A B RESULT.
MAIN.
    EVALUATE OP-CODE
        WHEN 1
            PERFORM ADDITION
        WHEN 2
            PERFORM SUBTRACTION
        WHEN 3
            PERFORM MULTIPLICATION
        WHEN 4
            PERFORM DIVISION-PROC
        WHEN 5
            PERFORM MODULUS
        WHEN OTHER
            MOVE 0 TO RESULT
    END-EVALUATE
    GOBACK.
```

### `test/RUN-TESTS.cbl` — Test runner

**ES:** Programa independiente que:
1. Define valores de entrada y esperados en `WORKING-STORAGE`.
2. Invoca `CALCULATOR` con `CALL ... USING`.
3. Compara el resultado con `IF WS-RESULTADO = WS-ESPERADO`.
4. Acumula contadores de pasadas/falladas.
5. Retorna código de salida 0 si todo pasó, 1 si hay fallos.

**EN:** Independent program that:
1. Defines input and expected values in `WORKING-STORAGE`.
2. Invokes `CALCULATOR` with `CALL ... USING`.
3. Compares the result with `IF WS-RESULTADO = WS-ESPERADO`.
4. Accumulates passed/failed counters.
5. Returns exit code 0 if all passed, 1 if any failed.

### `Makefile` — Automatización

**ES:** Targets disponibles:
- `make build` — Compila `run_tests` desde `RUN-TESTS.cbl` + `CALCULATOR.cbl`.
- `make test` — Compila y ejecuta las pruebas.
- `make clean` — Limpia artefactos compilados.

**EN:** Available targets:
- `make build` — Compiles `run_tests` from `RUN-TESTS.cbl` + `CALCULATOR.cbl`.
- `make test` — Builds and runs the tests.
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
cobc -x -free -o run_tests test/RUN-TESTS.cbl src/CALCULATOR.cbl
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

RESULTADOS:
  Pruebas ejecutadas: 005
  Pasadas: 005
  Falladas: 000
```

---

## 🧠 Algoritmos / operaciones

| Operación | Código | Algoritmo | Descripción |
|-----------|--------|-----------|-------------|
| Suma | `1` | Directo | `ADD A TO B GIVING RESULT` (nativo de COBOL) |
| Resta | `2` | Directo | `SUBTRACT B FROM A GIVING RESULT` (nativo de COBOL) |
| Multiplicación | `3` | Iterativo | Suma repetitiva con `PERFORM VARYING` sin usar `*` |
| División | `4` | Iterativo | Restas sucesivas con `PERFORM UNTIL` sin usar `/` |
| Módulo | `5` | Compuesto | Cociente + multiplicación nativa + resta: `a - (b * (a / b))` |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** COBOL no permite operadores aritméticos como `*` o `/` en el sentido tradicional. La multiplicación se implementa con un bucle `PERFORM VARYING` que suma `A` repetidamente.
- **EN:** COBOL does not allow arithmetic operators like `*` or `/` in the traditional sense. Multiplication is implemented with a `PERFORM VARYING` loop that adds `A` repeatedly.
- **ES:** El subprograma usa `LINKAGE SECTION` para recibir parámetros y `GOBACK` para retornar, que es el estándar COBOL para subprogramas.
- **EN:** The subprogram uses `LINKAGE SECTION` to receive parameters and `GOBACK` to return, which is the COBOL standard for subprograms.
- **ES:** No se necesita un framework de testing externo; el test runner usa `CALL`, `IF` y contadores manuales con `RETURN-CODE` para reportar resultados.
- **EN:** No external testing framework is needed; the test runner uses `CALL`, `IF`, and manual counters with `RETURN-CODE` to report results.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
