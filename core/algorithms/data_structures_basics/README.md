# Data Structures Basics — COBOL

Implementación de la especificación [06 — Data Structures Basics](../../../../docs/core/algorithms/06_Data_Structures_Basics.md) en **COBOL**, con un enfoque manual y minimalista.

**ES:** El módulo implementa `Node`, `LinkedList`, `Stack` y `Queue` sobre memoria dinámica (`ALLOCATE`/`FREE`) en GnuCOBOL formato libre. Cada operación del contrato es un subprograma independiente; las aserciones son artesanales mediante contadores propios del programa de pruebas.

**EN:** The module implements `Node`, `LinkedList`, `Stack` and `Queue` over dynamic memory (`ALLOCATE`/`FREE`) in GnuCOBOL free format. Each contract operation is an independent subprogram; assertions are hand-rolled via counters in the test program.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| `src/lib/DATA-STRUCTURES.cbl` | Subprogramas de `Node`, `LinkedList`, `Stack` y `Queue` / Subprograms for `Node`, `LinkedList`, `Stack` and `Queue` |
| `src/copybooks/DATA-STRUCTURES-PARAMS.cpy` | Tipos de dominio compartidos: `DS-NODE` (BASED), `DS-LINKED-LIST`, `DS-STACK`, `DS-QUEUE` y `DS-FAILURE-VALUE` / Shared domain types |
| `test/RUN-TESTS.cbl` | Programa de pruebas con aserciones artesanales / Test program with hand-rolled assertions |
| `Makefile` | Reglas de compilación y ejecución de pruebas / Build and test execution rules |
| `.gitignore` | Excluye el ejecutable `run_tests` y artefactos generados / Excludes the `run_tests` executable and generated artifacts |

**Nota de desviación / Deviation note:** La especificación propone `src/data_structures_basics.ext` y `test/run_tests.ext`. En COBOL el naming en mayúsculas y guiones (`DATA-STRUCTURES.cbl`, `RUN-TESTS.cbl`) es la convención idiomática del lenguaje; el copybook de parámetros vive en `src/copybooks/` (siguiendo el patrón de `naive_sort`). La especificación permite declarar toda desviación en el README.

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente. Cada operación del contrato es un subprograma COBOL identificado con `PROGRAM-ID`; el copybook `DATA-STRUCTURES-PARAMS.cpy` declara los tipos de dominio compartidos (`DS-NODE BASED`, `DS-LINKED-LIST`, `DS-STACK`, `DS-QUEUE`). Los nodos se reservan con `ALLOCATE DS-NODE` y se liberan con `FREE DS-NODE`; el acceso a sus campos se hace superponiendo la vista `BASED` con `SET ADDRESS OF DS-NODE TO <puntero>`.

**EN:** The project was created manually. Each contract operation is a COBOL subprogram identified by `PROGRAM-ID`; the `DATA-STRUCTURES-PARAMS.cpy` copybook declares the shared domain types (`DS-NODE BASED`, `DS-LINKED-LIST`, `DS-STACK`, `DS-QUEUE`). Nodes are allocated with `ALLOCATE DS-NODE` and freed with `FREE DS-NODE`; field access is done by overlaying the `BASED` view with `SET ADDRESS OF DS-NODE TO <pointer>`.

## 📄 Configuración clave / Key Configuration

El `Makefile` compila `test/RUN-TESTS.cbl` y `src/lib/DATA-STRUCTURES.cbl` con:

```
cobc -x -free -Isrc/copybooks -Itest -o run_tests test/RUN-TESTS.cbl src/lib/DATA-STRUCTURES.cbl
```

Las banderas `-Isrc/copybooks` y `-Itest` permiten que las directivas `COPY` resuelvan `DATA-STRUCTURES-PARAMS` desde cualquiera de los dos archivos fuente. El compilador es GnuCOBOL (`cobc`); el formato libre (`-free`) suprime la restricción de columnas del formato fijo.

## 🚀 Compilación y ejecución / Build & Run

```bash
cd cobol/core/algorithms/data_structures_basics
make clean && make
./run_tests
# o bien / or
make test
```

**Salida real / Actual output:**

```text
=========================================
 DATA STRUCTURES BASICS - Unit tests
=========================================
--- Node tests ---
  [OK] node initialize and observe value should return 10                              
  [OK] node initialize and observe link should be absent                               
  [OK] node link and traverse should return 20                                         
  [OK] linked node next should be absent                                               
--- LinkedList tests ---
  [OK] linked list empty state should report empty                                     
  [OK] linked list empty state should have size 0                                      
  [OK] linked list empty state head should fail                                        
  [OK] linked list insert both ends should have size 4                                 
  [OK] linked list insert both ends should have head 5                                 
  [OK] linked list delete first occurrence should succeed                              
  [OK] linked list state should retain head 5                                          
  [OK] linked list state should retain size 3                                          
  [OK] linked list delete absent value should fail                                     
  [OK] linked list state should retain head 5                                          
  [OK] linked list state should retain size 3                                          
  [OK] linked list empty should delete head                                            
  [OK] linked list empty should delete middle                                          
  [OK] linked list empty should delete tail                                            
  [OK] linked list empty should report empty                                           
  [OK] linked list empty should have size 0                                            
  [OK] linked list empty head should fail                                              
--- Stack tests ---
  [OK] stack empty state should report empty                                           
  [OK] stack empty state should have size 0                                            
  [OK] stack empty peek should fail                                                    
  [OK] stack empty pop should fail                                                     
  [OK] stack LIFO peek should return 30                                                
  [OK] stack non-mutating peek should retain size 3                                    
  [OK] stack removal should pop 30                                                     
  [OK] stack reuse should pop 40                                                       
  [OK] stack removal should pop 20                                                     
  [OK] stack removal should pop 10                                                     
  [OK] stack removal should finish empty                                               
  [OK] stack removal should finish with size 0                                         
  [OK] stack empty after removal pop should fail                                       
  [OK] stack empty after removal should remain empty                                   
--- Queue tests ---
  [OK] queue empty state should report empty                                           
  [OK] queue empty state should have size 0                                            
  [OK] queue empty peek should fail                                                    
  [OK] queue empty dequeue should fail                                                 
  [OK] queue FIFO peek should return 10                                                
  [OK] queue non-mutating peek should retain size 3                                    
  [OK] queue removal should dequeue 10                                                 
  [OK] queue reuse should dequeue 20                                                   
  [OK] queue removal should dequeue 30                                                 
  [OK] queue removal should dequeue 40                                                 
  [OK] queue removal should finish empty                                               
  [OK] queue removal should finish with size 0                                         
  [OK] queue empty after removal dequeue should fail                                   
  [OK] queue empty after removal should remain empty                                   
 
SUMMARY:
  Total:    049
  Passed:   049
  Failed:   000
 
=========================================
 GLOBAL RESULTS
=========================================
  >>> ALL TESTS PASSED <<<
```

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `NODE-INIT` | `POINTER, S9(9)` → nodo reservado / allocated node | `O(1)` | `ALLOCATE DS-NODE`; `next` queda `NULL` |
| `NODE-GET-VALUE` | `POINTER` → `S9(9)` | `O(1)` | Superposición de vista `BASED` |
| `NODE-GET-NEXT` | `POINTER` → `POINTER` | `O(1)` | Devuelve `NULL` si el enlace es ausente / Returns `NULL` if link is absent |
| `NODE-SET-NEXT` | `POINTER, POINTER` → (efecto / side-effect) | `O(1)` | Actualiza `DS-NODE-NEXT` in-place |
| `LINKED-LIST-INIT` | `DS-LINKED-LIST` → (efecto) | `O(1)` | Cabeza, cola a `NULL`; contador a 0 |
| `LINKED-LIST-GET-HEAD` | `DS-LINKED-LIST` → `S9(9)` | `O(1)` | `-1` si vacía / `-1` if empty |
| `LINKED-LIST-INSERT-HEAD` | `DS-LINKED-LIST, S9(9)` → (efecto) | `O(1)` | Nodo nuevo pasa a ser cabeza |
| `LINKED-LIST-INSERT-TAIL` | `DS-LINKED-LIST, S9(9)` → (efecto) | `O(1)` | Nodo nuevo pasa a ser cola; `LOCAL-STORAGE` guarda el puntero auxiliar |
| `LINKED-LIST-DELETE` | `DS-LINKED-LIST, S9(9)` → `S9(9)` | `O(n)` | `0` éxito; `-1` fallo; `FREE` libera el nodo eliminado |
| `LINKED-LIST-IS-EMPTY` | `DS-LINKED-LIST` → `PIC 9` | `O(1)` | `1` vacía; `0` no vacía |
| `LINKED-LIST-SIZE` | `DS-LINKED-LIST` → `9(9)` | `O(1)` | Contador `DS-LIST-COUNT` |
| `STACK-INIT` | `DS-STACK` → (efecto) | `O(1)` | `top` a `NULL`; contador a 0 |
| `STACK-PUSH` | `DS-STACK, S9(9)` → (efecto) | `O(1)` | Nodo nuevo enlaza con el tope anterior |
| `STACK-POP` | `DS-STACK` → `S9(9)` | `O(1)` | Extrae valor; `FREE` libera el nodo; `-1` si vacía |
| `STACK-PEEK` | `DS-STACK` → `S9(9)` | `O(1)` | No muta; `-1` si vacía |
| `STACK-IS-EMPTY` | `DS-STACK` → `PIC 9` | `O(1)` | `1` vacía; `0` no vacía |
| `STACK-SIZE` | `DS-STACK` → `9(9)` | `O(1)` | Contador `DS-STACK-COUNT` |
| `QUEUE-INIT` | `DS-QUEUE` → (efecto) | `O(1)` | `front`/`rear` a `NULL`; contador a 0 |
| `QUEUE-ENQUEUE` | `DS-QUEUE, S9(9)` → (efecto) | `O(1)` | Nodo nuevo enlaza tras el `rear`; `LOCAL-STORAGE` guarda el puntero auxiliar |
| `QUEUE-DEQUEUE` | `DS-QUEUE` → `S9(9)` | `O(1)` | Extrae `front`; `FREE` libera el nodo; `-1` si vacía |
| `QUEUE-PEEK` | `DS-QUEUE` → `S9(9)` | `O(1)` | No muta; `-1` si vacía |
| `QUEUE-IS-EMPTY` | `DS-QUEUE` → `PIC 9` | `O(1)` | `1` vacía; `0` no vacía |
| `QUEUE-SIZE` | `DS-QUEUE` → `9(9)` | `O(1)` | Contador `DS-QUEUE-COUNT` |

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Un subprograma por operación del contrato (`PROGRAM-ID`) | Un programa único con secciones `SECTION` para cada operación | Cada subprograma tiene su propio `LINKAGE SECTION`, evitando conflictos de nombres entre los parámetros de distintas operaciones; además permite llamadas externas reales (`CALL "NODE-INIT" USING …`) exactamente como el contrato declara |
| `LOCAL-STORAGE SECTION` para punteros auxiliares en `INSERT-TAIL` y `ENQUEUE` | Variables en `WORKING-STORAGE` o `LINKAGE` | `LOCAL-STORAGE` garantiza que el puntero auxiliar al nuevo nodo (`LS-NEW-NODE`) no se comparte entre llamadas; con `WORKING-STORAGE` en un subprograma estático el valor persistiría entre llamadas y podría contaminar invocaciones concurrentes |
| Copybook `DATA-STRUCTURES-PARAMS.cpy` con `DS-NODE BASED` | Estructura fija en `WORKING-STORAGE` | `BASED` permite superponer la vista `DS-NODE` a cualquier dirección de memoria dinámica sin coste de copia; es la única forma idiomática de COBOL para acceder a memoria asignada con `ALLOCATE` |
| `FREE DS-NODE` inmediatamente tras extraer el valor en `POP` y `DEQUEUE` | Dejar la liberación al llamador | Garantiza que no haya fugas de memoria y que la responsabilidad de gestión sea interna al ADT, en línea con el encapsulamiento del contrato |

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `src/data_structures_basics.ext` y `test/run_tests.ext` | `src/lib/DATA-STRUCTURES.cbl`, `src/copybooks/DATA-STRUCTURES-PARAMS.cpy`, `test/RUN-TESTS.cbl` | COBOL usa MAYÚSCULAS y guiones en identificadores; el copybook de tipos compartidos es una convención idiomática del lenguaje para separar declaraciones de código ejecutable. La especificación declara que el layout puede seguir las convenciones del lenguaje |
| `Node.init(value)` como operación de un tipo | `CALL "NODE-INIT" USING nodo valor` | COBOL no tiene objetos ni métodos; el contrato se declara como subprogramas identificados por nombre de `PROGRAM-ID`, que es la notación natural del lenguaje (ver familia «C, Assembly, COBOL, Forth» en `AGENT_Template.md`) |
| `next = absent` (ausencia nativa del lenguaje) | `SET DS-NODE-NEXT TO NULL` | `NULL` es la representación nativa de puntero ausente en GnuCOBOL (`USAGE POINTER`); no se introduce ningún tipo opcional nuevo |
| `is_empty()` devuelve booleano | `LINKED-LIST-IS-EMPTY` devuelve `PIC 9` con `1` (vacía) o `0` (no vacía) | COBOL no tiene tipo booleano; `PIC 9` es el portador idiomático de un bit de estado. La semántica (`true` después de `init`, `false` tras la primera inserción) es idéntica al contrato |
| Capacidad fija o gestión de memoria declarada | Memoria dinámica sin límite fijo (`ALLOCATE`/`FREE`) | GnuCOBOL soporta `ALLOCATE`/`FREE` (ISO COBOL 2002+), lo que permite listas sin capacidad artificial. El overflow queda limitado únicamente por la RAM disponible; no se introduce un centinela de límite que la especificación no exige |

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `LINKED-LIST-GET-HEAD` | Lista vacía / Empty list | `-1` (`DS-FAILURE-VALUE`) | `CALL "LINKED-LIST-GET-HEAD" USING DS-LINKED-LIST WS-RESULT` → `WS-RESULT = -000000001` |
| `LINKED-LIST-DELETE` | Valor no encontrado / Value not found | `-1` (`DS-FAILURE-VALUE`) | `delete(99)` en lista sin ese valor → resultado `-1` |
| `LINKED-LIST-DELETE` | Eliminación exitosa / Successful deletion | `0` | `delete(10)` encontrado → resultado `0` |
| `STACK-POP` | Pila vacía / Empty stack | `-1` (`DS-FAILURE-VALUE`) | `pop` sobre pila inicializada → `-1` |
| `STACK-PEEK` | Pila vacía / Empty stack | `-1` (`DS-FAILURE-VALUE`) | `peek` sobre pila inicializada → `-1` |
| `QUEUE-DEQUEUE` | Cola vacía / Empty queue | `-1` (`DS-FAILURE-VALUE`) | `dequeue` sobre cola inicializada → `-1` |
| `QUEUE-PEEK` | Cola vacía / Empty queue | `-1` (`DS-FAILURE-VALUE`) | `peek` sobre cola inicializada → `-1` |
| `NODE-GET-NEXT` | Nodo sin enlace / Node without link | `NULL` (puntero nulo / null pointer) | Nodo recién inicializado → `DS-NODE-NEXT = NULL` |

**ES:** El indicador de fallo para operaciones numéricas es `-1` (`DS-FAILURE-VALUE`, declarado en el copybook como `78 DS-FAILURE-VALUE VALUE -1`). Los valores de prueba son enteros positivos (5, 10, 20, 30, 40), por lo que no colisionan con el indicador. Para punteros, la ausencia nativa es `NULL`.

**EN:** The failure indicator for numeric operations is `-1` (`DS-FAILURE-VALUE`, declared in the copybook as `78 DS-FAILURE-VALUE VALUE -1`). Test values are positive integers (5, 10, 20, 30, 40), so they do not collide with the indicator. For pointers, native absence is `NULL`.

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| **Node** — Inicializar y observar valor/enlace | Sí | `node initialize and observe value should return 10` / `node initialize and observe link should be absent` | |
| **Node** — Inicializar otro nodo, enlazar y recorrer | Sí | `node link and traverse should return 20` / `linked node next should be absent` | |
| **LinkedList** — Estado vacío (`is_empty`, `size`, `get_head`) | Sí | `linked list empty state should report empty/size 0/head should fail` | |
| **LinkedList** — Insertar por ambos extremos (`size`, recorrido desde `get_head`) | Sí | `linked list insert both ends should have size 4/head 5` | El recorrido se verifica implícitamente mediante las operaciones de delete sucesivas |
| **LinkedList** — Eliminar primera aparición | Sí | `linked list delete first occurrence should succeed` + `ASSERT-LIST-STATE` | Estado retenido: cabeza 5, tamaño 3 |
| **LinkedList** — Valor ausente (`delete(99)`) | Sí | `linked list delete absent value should fail` + `ASSERT-LIST-STATE` | Estado no cambia |
| **LinkedList** — Vaciar la lista (tres `delete` + `is_empty`, `size`, `get_head`) | Sí | `linked list empty should delete head/middle/tail` + `empty should report empty/size 0/head fail` | |
| **Stack** — Estado vacío y extracción fallida (`is_empty`, `size`, `peek`, `pop`) | Sí | `stack empty state should report empty/size 0` + `stack empty peek/pop should fail` | |
| **Stack** — LIFO y `peek` no mutante | Sí | `stack LIFO peek should return 30` / `stack non-mutating peek should retain size 3` | |
| **Stack** — Extracción y reutilización (`pop`, `push(40)`, tres `pop`) | Sí | `stack removal should pop 30/20/10` / `stack reuse should pop 40` | |
| **Stack** — Vacío tras extracción (`pop` fallo) | Sí | `stack empty after removal pop should fail` / `stack empty after removal should remain empty` | |
| **Queue** — Estado vacío y extracción fallida (`is_empty`, `size`, `peek`, `dequeue`) | Sí | `queue empty state should report empty/size 0` + `queue empty peek/dequeue should fail` | |
| **Queue** — FIFO y `peek` no mutante | Sí | `queue FIFO peek should return 10` / `queue non-mutating peek should retain size 3` | |
| **Queue** — Extracción y reutilización (`dequeue`, `enqueue(40)`, tres `dequeue`) | Sí | `queue removal should dequeue 10/20/30/40` / `queue reuse should dequeue 20` | |
| **Queue** — Vacío tras extracción (`dequeue` fallo) | Sí | `queue empty after removal dequeue should fail` / `queue empty after removal should remain empty` | |

Total de aserciones: **49** (4 Node + 17 LinkedList + 14 Stack + 14 Queue).

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| El tamaño máximo de `DS-LIST-COUNT`, `DS-STACK-COUNT` y `DS-QUEUE-COUNT` es `PIC 9(9)` (999 999 999 elementos) | Para estructuras mayores el contador desbordará en silencio | Ampliar a `PIC 9(18)` o usar `COMP-5`; no es relevante para el propósito educativo de la fase |
| El campo `DS-NODE-VALUE` es `PIC S9(9)` (enteros de −999 999 999 a 999 999 999) | No soporta valores fuera de ese rango ni tipos no enteros | Adaptación documentada del dominio; la especificación no requiere otro tipo |

## 📝 Notas de implementación / Implementation Notes

**ES:** COBOL es un lenguaje orientado a procedimientos sin objetos ni métodos. El contrato del módulo se declara como un conjunto de subprogramas identificados por `PROGRAM-ID` compilados en el mismo archivo fuente y enlazados en un ejecutable único. Este patrón es la notación natural del lenguaje para separar «qué hace» cada operación de «cómo está representado» el tipo de dato, según la tabla de familias de `AGENT_Template.md` (familia «C, Assembly, COBOL, Forth»).

Los nodos se gestionan con memoria dinámica (`ALLOCATE`/`FREE`), disponible desde ISO COBOL 2002 y soportada por GnuCOBOL. El acceso a los campos del nodo se realiza superponiendo la vista `BASED` (`DS-NODE`) a la dirección del nodo con `SET ADDRESS OF DS-NODE TO <puntero>`. Esta técnica es el equivalente idiomático del puntero desreferenciado de C: el compilador no reserva almacenamiento para `DS-NODE` y usa su tamaño solo para el `ALLOCATE`.

La suite de pruebas es artesanal: `RUN-TESTS.cbl` mantiene contadores `WS-ASSERT-TOTAL`, `WS-ASSERT-PASSED` y `WS-ASSERT-FAILED`, y el párrafo `ASSERT-EQUAL` compara `WS-ASSERT-ACTUAL` con `WS-ASSERT-EXPECTED` e imprime `[OK]` o `[FAIL]`. No existe un framework de pruebas externo para COBOL en GnuCOBOL equivalente a los de otros lenguajes; el patrón de copybook de aserciones reutilizable ya se estableció en `naive_sort`.

No se usa recursión: COBOL tiene soporte limitado para recursión estática y ninguno para recursión por defecto en subprogramas estáticos. Todos los recorridos de lista se implementan con `PERFORM UNTIL`.

**EN:** COBOL is a procedural language without objects or methods. The module's contract is declared as a set of subprograms identified by `PROGRAM-ID`, compiled in the same source file and linked into a single executable. This pattern is the language's natural notation for separating "what each operation does" from "how the data type is represented", per the family table in `AGENT_Template.md` (family «C, Assembly, COBOL, Forth»).

Nodes are managed with dynamic memory (`ALLOCATE`/`FREE`), available since ISO COBOL 2002 and supported by GnuCOBOL. Node field access is done by overlaying the `BASED` view (`DS-NODE`) onto the node's address with `SET ADDRESS OF DS-NODE TO <pointer>`. This technique is the idiomatic equivalent of C's pointer dereference: the compiler allocates no storage for `DS-NODE` and uses its size only for the `ALLOCATE`.

The test suite is hand-rolled: `RUN-TESTS.cbl` maintains counters `WS-ASSERT-TOTAL`, `WS-ASSERT-PASSED` and `WS-ASSERT-FAILED`, and the `ASSERT-EQUAL` paragraph compares `WS-ASSERT-ACTUAL` with `WS-ASSERT-EXPECTED` and prints `[OK]` or `[FAIL]`. No external test framework equivalent to those of other languages exists for GnuCOBOL; the reusable assertion copybook pattern was already established in `naive_sort`.

No recursion is used: COBOL has limited support for static recursion and none by default in static subprograms. All list traversals are implemented with `PERFORM UNTIL`.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`06_Data_Structures_Basics.md`](../../../../docs/core/algorithms/06_Data_Structures_Basics.md) |
| Módulo homologado del lenguaje / Homologated module | [`cobol/core/algorithms/naive_sort/`](../naive_sort/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [GnuCOBOL Programmer's Guide](https://gnucobol.sourceforge.io/guides.html) |

---

*[← Volver a Algorithms](../README.md) | [↑ Core COBOL](../../README.md) | [↑ Inicio / Home](../../../../docs/index.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
