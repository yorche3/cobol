# Naive Sort — COBOL

Implementación de la especificación [05 — Naive Sort](../../docs/core/algorithms/05_Naive_Sort.md) en **COBOL**, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

Describe la estructura del proyecto y el propósito de cada archivo.

| Archivo / Directory | Propósito / Purpose |
|---|---|
| `src/SELECTION-SORT.cbl` | Código fuente principal - Selection Sort / Main source code - Selection Sort |
| `src/BUBBLE-SORT.cbl` | Código fuente principal - Bubble Sort / Main source code - Bubble Sort |
| `src/INSERTION-SORT.cbl` | Código fuente principal - Insertion Sort / Main source code - Insertion Sort |
| `test/NAIVE-SORT-TESTS.cbl` | Pruebas unitarias para los algoritmos de ordenamiento / Unit tests for sorting algorithms |
| `test/RUN-TESTS.cbl` | Runner de pruebas / Test runner |
| `test/ASSERTS.cpy` | Macros de aserción reutilizables / Reusable assertion macros |
| `Makefile` | Configuración de construcción / Build configuration |
| `.gitignore` | Archivos generados excluidos / Ignored generated files |

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente con un enfoque minimalista, implementando los tres algoritmos de ordenamiento elemental sin usar bibliotecas de ordenamiento del sistema. La construcción se realiza mediante un Makefile que automatiza la compilación con GNU COBOL.

**EN:** The project was created manually with a minimalist approach, implementing the three elementary sorting algorithms without using system sorting libraries. Build is performed using a Makefile that automates compilation with GNU COBOL.

## 📄 Configuración clave / Key Configuration

El archivo `Makefile` define las reglas de compilación para generar el ejecutable `run_tests` que ejecuta todas las pruebas. El proyecto sigue la convención de separar el código fuente en `src/` y las pruebas en `test/`.

## 🚀 Compilación y ejecución / Build & Run

```bash
cd cobol/core/algorithms/naive_sort
make clean && make
./run_tests
```

**Salida real / Actual output:**

```text
=========================================
 NAIVE SORT — Pruebas unitarias
=========================================

=========================================
 NAIVE SORT — Pruebas unitarias
=========================================

--- selection_sort tests ---


  [OK] selection_sort       -  sort unsorted array

  [OK] selection_sort       -  sort unsorted array

  [OK] selection_sort       -  sort unsorted array

  [OK] selection_sort       -  sort unsorted array

  [OK] selection_sort       -  sort unsorted array

  [OK] selection_sort       -  sort unsorted array


  [OK] selection_sort       -  sort already sorted array

  [OK] selection_sort       -  sort already sorted array

  [OK] selection_sort       -  sort already sorted array

  [OK] selection_sort       -  sort already sorted array

  [OK] selection_sort       -  sort already sorted array


  [OK] selection_sort       -  sort reverse order array

  [OK] selection_sort       -  sort reverse order array

  [OK] selection_sort       -  sort reverse order array

  [OK] selection_sort       -  sort reverse order array

  [OK] selection_sort       -  sort reverse order array


  [OK] selection_sort       -  sort identical elements

  [OK] selection_sort       -  sort identical elements

  [OK] selection_sort       -  sort identical elements

  [OK] selection_sort       -  sort identical elements


  [OK] selection_sort       -  sort with negative numbers

  [OK] selection_sort       -  sort with negative numbers

  [OK] selection_sort       -  sort with negative numbers

  [OK] selection_sort       -  sort with negative numbers

  [OK] selection_sort       -  sort with negative numbers


  [OK] selection_sort       -  sort single element


SUMMARY:
  Total:    026
  Passed:   026
  Failed:   000
  >>> ALL TESTS PASSED <<<
--- bubble_sort tests ---


  [OK] bubble_sort          -  sort unsorted array

  [OK] bubble_sort          -  sort unsorted array

  [OK] bubble_sort          -  sort unsorted array

  [OK] bubble_sort          -  sort unsorted array

  [OK] bubble_sort          -  sort unsorted array

  [OK] bubble_sort          -  sort unsorted array


  [OK] bubble_sort          -  sort already sorted array

  [OK] bubble_sort          -  sort already sorted array

  [OK] bubble_sort          -  sort already sorted array

  [OK] bubble_sort          -  sort already sorted array

  [OK] bubble_sort          -  sort already sorted array


  [OK] bubble_sort          -  sort reverse order array

  [OK] bubble_sort          -  sort reverse order array

  [OK] bubble_sort          -  sort reverse order array

  [OK] bubble_sort          -  sort reverse order array

  [OK] bubble_sort          -  sort reverse order array


  [OK] bubble_sort          -  sort identical elements

  [OK] bubble_sort          -  sort identical elements

  [OK] bubble_sort          -  sort identical elements

  [OK] bubble_sort          -  sort identical elements


  [OK] bubble_sort          -  sort with negative numbers

  [OK] bubble_sort          -  sort with negative numbers

  [OK] bubble_sort          -  sort with negative numbers

  [OK] bubble_sort          -  sort with negative numbers

  [OK] bubble_sort          -  sort with negative numbers


  [OK] bubble_sort          -  sort single element


SUMMARY:
  Total:    052
  Passed:   052
  Failed:   000
  >>> ALL TESTS PASSED <<<
--- insertion_sort tests ---


  [OK] insertion_sort       -  sort unsorted array

  [OK] insertion_sort       -  sort unsorted array

  [OK] insertion_sort       -  sort unsorted array

  [OK] insertion_sort       -  sort unsorted array

  [OK] insertion_sort       -  sort unsorted array

  [OK] insertion_sort       -  sort unsorted array


  [OK] insertion_sort       -  sort already sorted array

  [OK] insertion_sort       -  sort already sorted array

  [OK] insertion_sort       -  sort already sorted array

  [OK] insertion_sort       -  sort already sorted array

  [OK] insertion_sort       -  sort already sorted array


  [OK] insertion_sort       -  sort reverse order array

  [OK] insertion_sort       -  sort reverse order array

  [OK] insertion_sort       -  sort reverse order array

  [OK] insertion_sort       -  sort reverse order array

  [OK] insertion_sort       -  sort reverse order array


  [OK] insertion_sort       -  sort identical elements

  [OK] insertion_sort       -  sort identical elements

  [OK] insertion_sort       -  sort identical elements

  [OK] insertion_sort       -  sort identical elements


  [OK] insertion_sort       -  sort with negative numbers

  [OK] insertion_sort       -  sort with negative numbers

  [OK] insertion_sort       -  sort with negative numbers

  [OK] insertion_sort       -  sort with negative numbers

  [OK] insertion_sort       -  sort with negative numbers


  [OK] insertion_sort       -  sort single element


SUMMARY:
  Total:    078
  Passed:   078
  Failed:   000
  >>> ALL TESTS PASSED <<<

=========================================
 GLOBAL RESULTS
=========================================
```

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Función / Algorithm | Enfoques / Approaches | Descripción / Description |
|---|---|---|
| `SELECTION-SORT.cbl` | `ite` | Implementación iterativa de Selection Sort: encuentra el mínimo del resto no ordenado y lo ubica al inicio |
| `BUBBLE-SORT.cbl` | `ite` | Implementación iterativa de Bubble Sort: compara e intercambia adyacentes con optimización de bandera swapped |
| `INSERTION-SORT.cbl` | `ite` | Implementación iterativa de Insertion Sort: construye el sub-array ordenado insertando cada elemento en su posición |

## 📝 Notas de implementación / Implementation Notes

Documenta aquí las particularidades verificadas del lenguaje: recursión,
iteración, TCO, manejo de errores, tipos de retorno, memoria y organización de
tests. Si el lenguaje no garantiza TCO, explica el papel educativo de la
versión con acumulador y qué tests cubren su comportamiento.

**ES:** COBOL es un lenguaje orientado a procedimientos que no soporta recursión de forma natural. Todos los algoritmos se implementaron de manera iterativa. El manejo de arrays se realiza mediante estructuras con cláusulas OCCURS. La implementación sigue el patrón de devolver un código de retorno (RETURN-CODE) para indicar éxito o fracaso. El proyecto incluye un framework de pruebas unitarias reutilizable basado en macros de aserción.

**EN:** COBOL is a procedural language that does not naturally support recursion. All algorithms were implemented iteratively. Array handling is performed using structures with OCCURS clauses. The implementation follows the pattern of returning a return code (RETURN-CODE) to indicate success or failure. The project includes a reusable unit testing framework based on assertion macros.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el
repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main
repository to see the other versions.

Este proyecto forma parte del monorepo de lenguajes de programación y se distribuye bajo la misma licencia que el proyecto principal.

---