# Numbers — COBOL

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **COBOL (GnuCOBOL)**, utilizando **cobc** como compilador y aserciones artesanales via `COPY` como framework de pruebas unitarias.

Este módulo implementa algoritmos fundamentales (suma de los primeros N naturales, factorial, Fibonacci, MCD, MCM) utilizando tres enfoques: **recursivo directo**, **recursivo con acumulador** e **iterativo**.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| `src/lib/NUMBERS.cbl` | Archivo único con los 15 subprogramas (3 enfoques × 5 algoritmos). |
| `src/copybooks/NUMBERS-PARAMS.cpy` | Tipos de datos compartidos entre subprogramas. |
| `test/RUN-TESTS.cbl` | Punto de entrada — orquestador de todas las suites. |
| `test/RECURSIVE-TESTS.cbl` | 11 tests para el enfoque recursivo directo. |
| `test/ITERATIVE-TESTS.cbl` | 11 tests para el enfoque iterativo. |
| `test/ASSERTS.cpy` | Aserciones reutilizables (`ASSERT-EQUAL`, `ASSERT-REPORT`). |
| `Makefile` | Compilación y ejecución de pruebas. |
| `.gitignore` | Archivos y carpetas ignoradas. |

**Estructura de directorios esperada:**

```text
numbers/
├── .gitignore
├── Makefile
├── README.md                       # Este archivo
├── src/
│   ├── copybooks/
│   │   └── NUMBERS-PARAMS.cpy      # Tipos compartidos
│   └── lib/
│       └── NUMBERS.cbl             # 15 subprogramas
└── test/
    ├── ASSERTS.cpy                 # Aserciones reutilizables
    ├── RECURSIVE-TESTS.cbl         # 11 tests recursivos
    ├── ITERATIVE-TESTS.cbl         # 11 tests iterativos
    └── RUN-TESTS.cbl               # Orquestador de pruebas
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding, para controlar cada detalle del COBOL.

Cada algoritmo se implementa de tres formas distintas para comparar eficiencia y estilo:

1. **Recursivo Directo (`...-REC`)**: Basado directamente en la definición matemática, con llamadas recursivas. Usan `IS RECURSIVE` y `LOCAL-STORAGE SECTION` para que cada invocación tenga su propio entorno de variables.
2. **Recursivo con Acumulador (`...-ACC`)**: Expone un subprograma limpio que delega en un helper recursivo interno que transporta el resultado parcial como acumulador.
3. **Iterativo (`...-ITE`)**: Utiliza bucles `PERFORM` sin recursión. Es la única vía realmente eficiente en COBOL.

**EN:** The project was created manually, without scaffolding tools, to control every detail of COBOL.

Each algorithm is implemented in three different ways to compare efficiency and style:

1. **Direct Recursive (`...-REC`)**: Based directly on the mathematical definition, with recursive calls. They use `IS RECURSIVE` and `LOCAL-STORAGE SECTION` so each invocation has its own variable environment.
2. **Accumulator Recursive (`...-ACC`)**: Exposes a clean subprogram that delegates to an internal recursive helper that carries the partial result as an accumulator.
3. **Iterative (`...-ITE`)**: Uses `PERFORM` loops without recursion. This is the only truly efficient approach in COBOL.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `Makefile` – Configuración de compilación

**ES:** Define cómo compilar: fuentes, directorios de búsqueda de copybooks y opciones del compilador.
**EN:** Defines how to build: sources, copybook search directories, and compiler options.

```makefile
COBC      = cobc
CFLAGS    = -x -free -Isrc/copybooks -Itest
SRC_DIR   = src/lib
TEST_DIR  = test
TARGET    = run_tests

$(TARGET): $(TEST_DIR)/RUN-TESTS.cbl \
           $(TEST_DIR)/RECURSIVE-TESTS.cbl \
           $(TEST_DIR)/ITERATIVE-TESTS.cbl \
           $(SRC_DIR)/NUMBERS.cbl
	$(COBC) $(CFLAGS) -o $@ $^
```

### `.gitignore` – Archivos ignorados

**ES:** Patrones para no versionar archivos generados (ejecutables, objetos, directorios de compilación).
**EN:** Patterns to avoid versioning generated files (executables, objects, build directories).

```gitignore
# Ejecutable compilado
run_tests
run_tests.exe

# Modulos compilados
*.so
*.dll
*.o

# Directorios de compilacion
target/
build/
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener GnuCOBOL instalado

```bash
# Ubuntu / Debian
sudo apt install gnucobol

# macOS (con Homebrew)
brew install gnucobol

# Windows (con MSYS2 o WSL)
# Ver: https://gnucobol.sourceforge.io/faq/index.html
```

### Compilar y ejecutar pruebas

```bash
# Compilar el ejecutable de pruebas
make

# Compilar y ejecutar las 22 pruebas
make test

# Limpiar archivos generados
make clean
```

**Salida esperada / Expected output:**

```text
--- RECURSIVE tests ---
  [OK] sum_rec(0)
  [OK] sum_rec(3)
  [OK] factorial_rec(0)
  [OK] factorial_rec(4)
  [OK] fibonacci_rec(0)
  [OK] fibonacci_rec(1)
  [OK] fibonacci_rec(6)
  [OK] gcd_rec(12, 8)
  [OK] gcd_rec(7, 5)
  [OK] lcm_rec(4, 6)
  [OK] lcm_rec(6, 8)

SUMMARY:
  Total:    011
  Passed:   011
  Failed:   000
  >>> ALL TESTS PASSED <<<

--- ITERATIVE tests ---
  [OK] sum_ite(0)
  [OK] sum_ite(3)
  [OK] factorial_ite(0)
  [OK] factorial_ite(4)
  [OK] fibonacci_ite(0)
  [OK] fibonacci_ite(1)
  [OK] fibonacci_ite(6)
  [OK] gcd_ite(12, 8)
  [OK] gcd_ite(7, 5)
  [OK] lcm_ite(4, 6)
  [OK] lcm_ite(6, 8)

SUMMARY:
  Total:    011
  Passed:   011
  Failed:   000
  >>> ALL TESTS PASSED <<<

=========================================
 GLOBAL RESULTS
=========================================
  >>> ALL TESTS PASSED <<<
```

---

## 🧠 Algoritmos / operaciones (según el módulo)

### 3 enfoques × 5 algoritmos = 15 funciones / 22 tests

| Algoritmo | Casos de prueba | `REC` | `ACC` | `ITE` |
|-----------|----------------|:-----:|:-----:|:-----:|
| `SumOfFirstN` | `(0) = 0`, `(3) = 6` | ✅ | ✅¹ | ✅ |
| `Factorial` | `(0) = 1`, `(4) = 24` | ✅ | ✅¹ | ✅ |
| `Fibonacci` | `(0) = 0`, `(1) = 1`, `(6) = 8` | ✅ | ✅¹ | ✅ |
| `GreatestCommonDivisor` | `(12, 8) = 4`, `(7, 5) = 1` | ✅ | ✅¹ | ✅ |
| `LeastCommonMultiple` | `(4, 6) = 12`, `(6, 8) = 24` | ✅ | ✅¹ | ✅ |

> ¹ Los acumuladores se prueban implícitamente al ejecutar `ACC(n)`, que internamente llama al helper recursivo. No tienen tests directos porque COBOL no garantiza TCO y son detalles de implementación.
> ¹ Accumulators are implicitly tested when `ACC(n)` runs, which internally calls the recursive helper. They have no direct tests because COBOL does not guarantee TCO and they are implementation details.

---

## 📝 Notas de implementación / Implementation Notes

### 🔁 Sobre recursión con acumulador y Tail Call Optimization (TCO) / On recursion with accumulator and Tail Call Optimization (TCO)

**ES:**

*Tail recursion* ocurre cuando la llamada recursiva es la última acción que ejecuta una función/método; después de la llamada no hay más instrucciones, la función devuelve el resultado de la llamada recursiva. La recursión con acumulador consigue esto pasando el estado previo como parámetro a cada llamada, sin dejar trabajo pendiente en la pila.

**COBOL no garantiza TCO.** GnuCOBOL compila a C y luego a código máquina; aunque el compilador C subyacente (gcc/clang) puede aplicar TCO en ciertos casos, esto no es parte de la especificación COBOL ni es confiable. Por lo tanto, la implementación con acumulador se conserva únicamente con fines educativos: sirve como puente conceptual entre la recursión directa (más cercana a la definición matemática) y la versión iterativa (más eficiente). Como en este contexto no hay un beneficio práctico de rendimiento, no se desarrollan pruebas unitarias específicas para los métodos con acumulador. La validación del comportamiento se cubre a través de las pruebas de los enfoques recursivo e iterativo, que juntos ejercitan los mismos resultados.

**EN:**

*Tail recursion* occurs when the recursive call is the last action that runs a function/method; after the call there are no more instructions, the function returns the result of the recursive call. Recursion with accumulator achieves this by passing the previous state as a parameter to each call, without leaving any pending work on the stack.

**COBOL does not guarantee TCO.** GnuCOBOL compiles to C and then to machine code; although the underlying C compiler (gcc/clang) may apply TCO in certain cases, this is not part of the COBOL specification nor is it reliable. Therefore, the accumulator implementation is preserved only for educational purposes: it serves as a conceptual bridge between the direct recursive (closer to mathematical definition) and the iterative version (more efficient). Since there is no practical performance benefit in this context, no specific unit tests are developed for the recursive methods with accumulator. Behavior validation is covered through the recursive and iterative test suites, which together exercise the same results.

### 🔁 Sobre recursión en COBOL / On recursion in COBOL

**ES:**

- Los subprogramas recursivos se declaran con `IS RECURSIVE` en el `PROGRAM-ID`.
- Las variables locales se colocan en `LOCAL-STORAGE SECTION` para que cada invocación tenga su propia copia. Si se usara `WORKING-STORAGE SECTION` (estática), todas las llamadas recursivas compartirían las mismas variables, corrompiendo los resultados.
- Los subprogramas no recursivos (`...-ACC` wrapper, `...-ITE`, `LCM-*`) usan `WORKING-STORAGE SECTION` normal.

**EN:**

- Recursive subprograms are declared with `IS RECURSIVE` in the `PROGRAM-ID`.
- Local variables are placed in `LOCAL-STORAGE SECTION` so each invocation has its own copy. If `WORKING-STORAGE SECTION` (static) were used, all recursive calls would share the same variables, corrupting the results.
- Non-recursive subprograms (`...-ACC` wrapper, `...-ITE`, `LCM-*`) use normal `WORKING-STORAGE SECTION`.

### 🔁 Sobre paso de parámetros / On parameter passing

**ES:** En COBOL los parámetros se pasan por referencia por defecto. Los subprogramas que llaman a otros (`LCM-ACC`, `LCM-ITE`, `GCD-ITE`) hacen copias locales de los parámetros de entrada para no corromper las variables del llamador.

**EN:** In COBOL, parameters are passed by reference by default. Subprograms that call others (`LCM-ACC`, `LCM-ITE`, `GCD-ITE`) make local copies of input parameters to avoid corrupting the caller's variables.

### 🔁 Sobre tipos de datos / On data types

**ES:** Todos los números se declaran como `PIC S9(9)` (entero con signo de 9 dígitos, rango aproximado ±999,999,999).

**EN:** All numbers are declared as `PIC S9(9)` (signed 9-digit integer, approximate range ±999,999,999).

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---
*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
