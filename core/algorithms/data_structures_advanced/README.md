# Data Structures Advanced — COBOL

Implementación de la especificación [07 — Data Structures Advanced](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) en **COBOL**, con un enfoque manual y minimalista.

**ES:** El módulo implementa `TreeNode`, `BinaryTree` y `Graph` sobre memoria dinámica (`ALLOCATE`/`FREE`) en GnuCOBOL formato libre. Cada operación del contrato es un subprograma independiente con convención de llamada por referencia. La base `Node` se expresa mediante valor embebido (`COMP-5`). La suite de pruebas unitarias ejecuta un runner de pasos guiado por cadenas de entrada y salida con aserciones artesanales.

**EN:** The module implements `TreeNode`, `BinaryTree` and `Graph` over dynamic memory (`ALLOCATE`/`FREE`) in GnuCOBOL free format. Each contract operation is an independent subprogram with by-reference calling conventions. The `Node` base is expressed via embedded values (`COMP-5`). The unit test suite executes a step runner guided by input/output strings with hand-rolled assertions.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| `src/lib/DATA-STRUCTURES-ADVANCED.cbl` | Subprogramas de `TreeNode`, `BinaryTree`, `GraphNode` y `Graph` / Subprograms for `TreeNode`, `BinaryTree`, `GraphNode` and `Graph` |
| `src/copybooks/DATA-STRUCTURES-ADVANCED-PARAMS.cpy` | Tipos de dominio compartidos: `DSA-TREE-NODE` (BASED), `DSA-BINARY-TREE`, `DSA-GRAPH-NODE` (BASED), `DSA-NEIGHBOR-NODE` (BASED), `DSA-GRAPH` y `DSA-FAILURE-VALUE` / Shared domain types |
| `test/RUN-TESTS.cbl` | Runner de pruebas paso a paso con aserciones artesanales / Step-by-step test runner with hand-rolled assertions |
| `Makefile` | Reglas de compilación y ejecución de pruebas / Build and test execution rules |
| `.gitignore` | Excluye el ejecutable `run_tests` y artefactos generados / Excludes the `run_tests` executable and generated artifacts |

**Nota de desviación / Deviation note:** La especificación propone `src/data_structures_advanced.ext` y `test/run_tests.ext`. En COBOL el nombrado en mayúsculas y guiones (`DATA-STRUCTURES-ADVANCED.cbl`, `RUN-TESTS.cbl`) es la convención idiomática del lenguaje; el copybook de parámetros vive en `src/copybooks/` y la biblioteca en `src/lib/` (siguiendo el patrón de `data_structures_basics`). La especificación permite explícitamente declarar esta desviación en el README.

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se construyó manualmente sin generadores externos. Cada operación del contrato es un subprograma COBOL identificado con `PROGRAM-ID`; el copybook `DATA-STRUCTURES-ADVANCED-PARAMS.cpy` declara los tipos de dominio compartidos (`DSA-TREE-NODE BASED`, `DSA-BINARY-TREE`, `DSA-GRAPH-NODE BASED`, `DSA-NEIGHBOR-NODE BASED`, `DSA-GRAPH`). Los nodos se reservan con `ALLOCATE` y se liberan con `FREE`; el acceso a campos se hace superponiendo la vista `BASED` con `SET ADDRESS OF ... TO <puntero>`.

**EN:** The project was built manually without external generators. Each contract operation is a COBOL subprogram identified by `PROGRAM-ID`; the `DATA-STRUCTURES-ADVANCED-PARAMS.cpy` copybook declares the shared domain types (`DSA-TREE-NODE BASED`, `DSA-BINARY-TREE`, `DSA-GRAPH-NODE BASED`, `DSA-NEIGHBOR-NODE BASED`, `DSA-GRAPH`). Nodes are allocated with `ALLOCATE` and freed with `FREE`; field access is achieved by overlaying the `BASED` view with `SET ADDRESS OF ... TO <pointer>`.

## 📄 Configuración clave / Key Configuration

El `Makefile` compila `test/RUN-TESTS.cbl` y `src/lib/DATA-STRUCTURES-ADVANCED.cbl` con:

```makefile
cobc -x -free -Isrc/copybooks -Itest -o run_tests test/RUN-TESTS.cbl src/lib/DATA-STRUCTURES-ADVANCED.cbl
```

Las banderas `-Isrc/copybooks` e `-Itest` permiten que las directivas `COPY` resuelvan `DATA-STRUCTURES-ADVANCED-PARAMS` desde cualquiera de los dos archivos fuente. El compilador es GnuCOBOL (`cobc`); el formato libre (`-free`) suprime la restricción de columnas del formato fijo tradicional.

## 🚀 Compilación y ejecución / Build & Run

```bash
cd cobol/core/algorithms/data_structures_advanced
make clean && make
./run_tests
# o bien / or
make test
```

**Salida real / Actual output:**

```text
cobc -x -free -Isrc/copybooks -Itest -o run_tests test/RUN-TESTS.cbl src/lib/DATA-STRUCTURES-ADVANCED.cbl
./run_tests
DATA STRUCTURES ADVANCED - Unit tests
[CASE OK] tree node create
[CASE OK] tree node absent initial links
[CASE OK] tree node link two children
[CASE OK] tree node traverse each link
[CASE OK] tree node unlink children
[CASE OK] binary tree create empty
[CASE OK] binary tree insert root
[CASE OK] binary tree insert lower and higher
[CASE OK] binary tree multilevel branches
[CASE OK] binary tree missing value in nonempty tree
[CASE OK] binary tree idempotent duplicate
[CASE OK] binary tree ordered insertions
[CASE OK] graph create empty
[CASE OK] graph isolated vertex
[CASE OK] graph nonconsecutive labels and directed edge
[CASE OK] graph duplicate vertex preserves adjacency
[CASE OK] graph duplicate edge
[CASE OK] graph missing endpoint without mutation
[CASE OK] graph sorted neighbours and counts
[CASE OK] graph missing edge query
[CASE OK] graph neighbours of missing vertex
[CASE OK] graph self loop and duplicate
[CASE OK] graph neighbour result isolation
CASES: 23 PASSED: 23 FAILED: 00
SUMMARY:
  Total:    208
  Passed:   208
  Failed:   000
  >>> ALL TESTS PASSED <<<
```

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `TREE-NODE-INIT` | `POINTER, S9(9)` → puntero reservado / allocated pointer | `O(1)` | `ALLOCATE DSA-TREE-NODE`; enlaces inicializados a `NULL` |
| `TREE-NODE-GET-VALUE` | `POINTER` → `S9(9)` | `O(1)` | Superposición de vista `BASED` |
| `TREE-NODE-GET-LEFT` | `POINTER` → `POINTER` | `O(1)` | Devuelve `NULL` si el enlace es ausente |
| `TREE-NODE-GET-RIGHT` | `POINTER` → `POINTER` | `O(1)` | Devuelve `NULL` si el enlace es ausente |
| `TREE-NODE-SET-LEFT` | `POINTER, POINTER` → (efecto / side-effect) | `O(1)` | Actualiza `DSA-TREE-NODE-LEFT` in-place |
| `TREE-NODE-SET-RIGHT` | `POINTER, POINTER` → (efecto / side-effect) | `O(1)` | Actualiza `DSA-TREE-NODE-RIGHT` in-place |
| `TREE-NODE-FREE` | `POINTER` → (efecto) | `O(n)` | Subárbol liberado en post-orden recursivo (`IS RECURSIVE`) |
| `BINARY-TREE-INIT` | `DSA-BINARY-TREE` → (efecto) | `O(1)` | Raíz a `NULL`; contador a 0 |
| `BINARY-TREE-INSERT` | `DSA-BINARY-TREE, S9(9)` → `S9(9)` | `O(h)` | Inserción iterativa en BST; 0 éxito, no duplica tamaño en repetidos |
| `BINARY-TREE-CONTAINS` | `DSA-BINARY-TREE, S9(9)` → `S9(9)` | `O(h)` | Búsqueda por ramas del BST; 0 encontrado, -1 ausente |
| `BINARY-TREE-IS-EMPTY` | `DSA-BINARY-TREE` → `PIC 9` | `O(1)` | `1` vacía; `0` no vacía |
| `BINARY-TREE-SIZE` | `DSA-BINARY-TREE` → `9(9)` | `O(1)` | Retorna `DSA-TREE-COUNT` |
| `BINARY-TREE-FREE` | `DSA-BINARY-TREE` → (efecto) | `O(n)` | Delega en `TREE-NODE-FREE` y restablece la estructura |
| `GRAPH-NODE-INIT` | `POINTER, S9(9)` → puntero reservado | `O(1)` | Interno a `Graph`; reserva nodo de vértice sin adyacencias |
| `GRAPH-FIND-NODE` | `DSA-GRAPH, S9(9)` → `POINTER` | `O(V)` | Búsqueda lineal en el registro manual de vértices; `NULL` si ausente |
| `GRAPH-INIT` | `DSA-GRAPH` → (efecto) | `O(1)` | Registro de vértices a `NULL`; contadores a 0 |
| `GRAPH-ADD-VERTEX` | `DSA-GRAPH, S9(9)` → `S9(9)` | `O(V)` | Verifica unicidad en `O(V)`; inserta en cabeza de registro en `O(1)` |
| `GRAPH-ADD-EDGE` | `DSA-GRAPH, S9(9), S9(9)` → `S9(9)` | `O(V + d(u))` | Requiere extremos existentes; adyacencia ordenada ascendente sin duplicados |
| `GRAPH-HAS-EDGE` | `DSA-GRAPH, S9(9), S9(9)` → `S9(9)` | `O(V + d(u))` | Búsqueda ordenada en lista de adyacencia; 0 existe, -1 ausente |
| `GRAPH-GET-NEIGHBORS` | `DSA-GRAPH, S9(9)` → `POINTER, S9(9)` | `O(V + d(u))` | Genera copia independiente encadenando por la cola en `O(d(u))` |
| `GRAPH-IS-EMPTY` | `DSA-GRAPH` → `PIC 9` | `O(1)` | `1` si registro de vértices es `NULL`, `0` en otro caso |
| `GRAPH-VERTEX-COUNT` | `DSA-GRAPH` → `9(9)` | `O(1)` | Retorna `DSA-VERTEX-COUNT` |
| `GRAPH-EDGE-COUNT` | `DSA-GRAPH` → `9(9)` | `O(1)` | Retorna `DSA-EDGE-COUNT` |
| `GRAPH-FREE` | `DSA-GRAPH` → (efecto) | `O(V + E)` | Libera adyacencias y vértices iterativamente; reinicializa registro |
| `FREE-NEIGHBORS` | `POINTER, S9(9)` → (efecto) | `O(d(u))` | Libera la lista copia entregada por `GRAPH-GET-NEIGHBORS` |

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Base `Node` expresada como valor embebido (`DSA-TREE-NODE-VALUE` y `DSA-GRAPH-NODE-VALUE`) | Simulación de herencia con estructuras anidadas o puntero genérico a estructura base | COBOL procedimental estándar no ofrece herencia tipada ni polimorfismo dinámico; el valor embebido en el registro `BASED` es la forma idiomática y de coste cero de cumplir el contrato sin añadir indirecciones innecesarias |
| Registro de vértices en lista simplemente enlazada con inserción en cabeza y búsqueda secuencial | Array estático de tamaño fijo o tablas de hash externas | Cumple con la exigencia estricta del contrato de implementar manualmente el registro `O(V)` sin delegar en estructuras indexadas de biblioteca ni imponer una capacidad máxima prefijada |
| `GRAPH-GET-NEIGHBORS` genera copia enlazada con acumulador de cola (`WS-TAIL`) | Entregar puntero a la adyacencia interna o construir insertando en cabeza invirtiendo la lista | Garantiza aislamiento total frente a mutaciones del consumidor manteniendo la complejidad `O(d(u))` en lugar de `O(d(u)^2)` |
| Liberación recursiva en post-orden para `TREE-NODE-FREE` mediante `IS RECURSIVE` y `LOCAL-STORAGE` | Recorrido iterativo con pila explícita en memoria dinámica | Post-orden natural para árboles; GnuCOBOL soporta `IS RECURSIVE` cuando las variables de estado se aíslan en la `LOCAL-STORAGE SECTION` |
| Runner de pruebas interpretado paso a paso con aserciones acumulativas | Pruebas codificadas con bloques `PERFORM` repetitivos | Permite reproducir exactamente las secuencias de operaciones y aserciones de cada escenario de la especificación mediante cadenas descriptivas, reportando tanto casos como aserciones individuales |

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `src/data_structures_advanced.ext` y `test/run_tests.ext` | `src/lib/DATA-STRUCTURES-ADVANCED.cbl`, `src/copybooks/DATA-STRUCTURES-ADVANCED-PARAMS.cpy`, `test/RUN-TESTS.cbl` | Convención idiomática de COBOL en mayúsculas y guiones, separando tipos compartidos en copybooks. La especificación permite adaptar el layout a las convenciones del lenguaje |
| Base `Node` con valor | Valor embebido `PIC S9(9) COMP-5` en cada nodo derivado | COBOL carece de herencia orientada a objetos en su estilo procedural estándar; la especificación permite expresamente la opción de valor embebido |
| Enlace ausente (`absent` / `null`) | `NULL` nativo (`USAGE POINTER`) | GnuCOBOL representa punteros ausentes o nulos de forma nativa con la constante figurativa `NULL` |
| Funciones booleanas (`is_empty`) | Parámetro `PIC 9` con valor `1` (verdadero) o `0` (falso) | COBOL no posee un tipo booleano primitivo independiente; un dígito numérico `PIC 9` es el formato idiomático estándar |
| Almacenamiento de vecinos en `GraphNode` | Lista simplemente enlazada propia (`DSA-NEIGHBOR-NODE`) | Aunque la especificación permite `LinkedList<T>` de la biblioteca estándar, COBOL no incluye colecciones genéricas en su biblioteca base, por lo que se implementa manualmente con memoria dinámica |
| Caso inmutable de `TreeNode` (si aplica) | Omitido (`No aplica`) | La implementación en COBOL es imperativa y mutable; la especificación declara este caso como condicional «si aplica» para adaptaciones inmutables |

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `TREE-NODE-GET-LEFT` | Enlace izquierdo ausente / Left link absent | `NULL` | Nodo sin hijo izquierdo → puntero `NULL` |
| `TREE-NODE-GET-RIGHT` | Enlace derecho ausente / Right link absent | `NULL` | Nodo sin hijo derecho → puntero `NULL` |
| `BINARY-TREE-INSERT` | Fallo de memoria / Out of memory (`ALLOCATE`) | `-1` (`DSA-FAILURE-VALUE`) | Inserción sin memoria disponible → `-1` |
| `BINARY-TREE-CONTAINS` | Valor no presente / Value not found | `-1` (`DSA-FAILURE-VALUE`) | `contains(99)` en árbol sin ese valor → `-1` |
| `GRAPH-ADD-EDGE` | Extremo origen o destino no registrado | `-1` (`DSA-FAILURE-VALUE`) | `add_edge(10, 99)` con 99 ausente → `-1` |
| `GRAPH-HAS-EDGE` | Arista inexistente o extremo ausente | `-1` (`DSA-FAILURE-VALUE`) | `has_edge(10, 30)` sin arista → `-1` |
| `GRAPH-GET-NEIGHBORS` | Vértice de origen no registrado | `-1` (`DSA-FAILURE-VALUE`) en contador y `NULL` en lista | `get_neighbors(99)` con 99 ausente → contador `-1`, puntero `NULL` |

**ES:** El indicador numérico de fallo es `-1` (`DSA-FAILURE-VALUE = -1`). Se distingue claramente el fallo de `GRAPH-GET-NEIGHBORS` (contador `-1`) de un vértice aislado sin vecinos (contador `0` y lista `NULL`). Para punteros, la ausencia se representa mediante `NULL`. Los valores de dominio de prueba son enteros positivos, evitando colisiones con el indicador.

**EN:** The numeric failure indicator is `-1` (`DSA-FAILURE-VALUE = -1`). Failure in `GRAPH-GET-NEIGHBORS` (count `-1`) is clearly distinguished from an isolated vertex with no neighbours (count `0` and `NULL` pointer). For pointers, absence is represented by `NULL`. Test domain values are positive integers, avoiding collisions with the indicator.

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| **TreeNode** — Crear un nodo de árbol | Sí | `tree node create` (`RUN-TESTS.cbl#L284-L287`) | Verifica valor inicial 10 |
| **TreeNode** — Enlaces iniciales ausentes | Sí | `tree node absent initial links` (`RUN-TESTS.cbl#L288-L291`) | Ambos enlaces verificados como `NULL` |
| **TreeNode** — Enlazar dos hijos | Sí | `tree node link two children` (`RUN-TESTS.cbl#L292-L295`) | Verifica hijos izquierdo (20) y derecho (30) |
| **TreeNode** — Recorrer cada enlace | Sí | `tree node traverse each link` (`RUN-TESTS.cbl#L296-L299`) | Verifica hijos y ausencia de enlaces en nietos |
| **TreeNode** — Desenlazar hijos | Sí | `tree node unlink children` (`RUN-TESTS.cbl#L300-L303`) | Desenlace secuencial manteniendo invariantes |
| **TreeNode** — Adaptación inmutable | Omitido | No aplica / Not applicable | COBOL es imperativo y mutable; caso reservado para variantes inmutables |
| **BinaryTree** — Crear vacío | Sí | `binary tree create empty` (`RUN-TESTS.cbl#L306-L309`) | `is_empty` = 1, `size` = 0, `contains` = -1 |
| **BinaryTree** — Insertar la raíz | Sí | `binary tree insert root` (`RUN-TESTS.cbl#L310-L313`) | Éxito en inserción, tamaño 1, `is_empty` = 0 |
| **BinaryTree** — Insertar menor y mayor | Sí | `binary tree insert lower and higher` (`RUN-TESTS.cbl#L314-L317`) | Inserción de 50, 30, 70; tamaño 3 |
| **BinaryTree** — Ramas de varios niveles | Sí | `binary tree multilevel branches` (`RUN-TESTS.cbl#L318-L321`) | Inserción de 50, 30, 70, 20, 40; tamaño 5 |
| **BinaryTree** — Valor ausente en árbol no vacío | Sí | `binary tree missing value in nonempty tree` (`RUN-TESTS.cbl#L322-L325`) | `contains(99)` falla; tamaño y raíz retenidos |
| **BinaryTree** — Duplicado idempotente | Sí | `binary tree idempotent duplicate` (`RUN-TESTS.cbl#L326-L329`) | Inserción duplicada de 30 no altera tamaño (3) |
| **BinaryTree** — Inserciones ordenadas | Sí | `binary tree ordered insertions` (`RUN-TESTS.cbl#L330-L333`) | Inserción de 20, 30, 40, 50, 70; 99 ausente |
| **Graph** — Crear vacío | Sí | `graph create empty` (`RUN-TESTS.cbl#L336-L339`) | Vértices 0, aristas 0; consultas fallan |
| **Graph** — Vértice aislado | Sí | `graph isolated vertex` (`RUN-TESTS.cbl#L340-L343`) | 1 vértice, 0 aristas; vecinos vacíos (0) |
| **Graph** — Etiquetas no consecutivas y arista dirigida | Sí | `graph nonconsecutive labels and directed edge` (`RUN-TESTS.cbl#L344-L347`) | Arista (10,70); (70,10) ausente |
| **Graph** — Vértice duplicado conserva adyacencia | Sí | `graph duplicate vertex preserves adjacency` (`RUN-TESTS.cbl#L348-L351`) | Re-registro de 10 conserva vecinos `[30]` |
| **Graph** — Arista duplicada | Sí | `graph duplicate edge` (`RUN-TESTS.cbl#L352-L355`) | Re-inserción de (10,30) no duplica aristas |
| **Graph** — Extremo inexistente sin mutación | Sí | `graph missing endpoint without mutation` (`RUN-TESTS.cbl#L356-L359`) | 4 intentos con extremos inválidos fallan sin mutar |
| **Graph** — Vecinos ordenados y contadores | Sí | `graph sorted neighbours and counts` (`RUN-TESTS.cbl#L360-L363`) | Vecinos de 10 ordenados `[30, 50, 70]` |
| **Graph** — Consulta de arista ausente | Sí | `graph missing edge query` (`RUN-TESTS.cbl#L364-L367`) | `has_edge(10,30)` falla en grafo sin aristas |
| **Graph** — Vecinos de vértice inexistente | Sí | `graph neighbours of missing vertex` (`RUN-TESTS.cbl#L368-L371`) | `get_neighbors(99)` = -1 (distinto de 0) |
| **Graph** — Bucle y duplicado | Sí | `graph self loop and duplicate` (`RUN-TESTS.cbl#L372-L375`) | Arista (10,10) duplicada; 1 arista, vecinos `[10]` |
| **Graph** — Aislamiento del resultado de vecinos | Sí | `graph neighbour result isolation` (`RUN-TESTS.cbl#L376-L379`) | Copia aislada; mutaciones posteriores no la afectan |

Total de casos de prueba: **23** (5 TreeNode + 7 BinaryTree + 11 Graph). Total de aserciones individuales: **208**.

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Valores numéricos y etiquetas definidos como `PIC S9(9) COMP-5` | Rango restringido a enteros de 32 bits con signo (−2 147 483 648 a 2 147 483 647) | Suficiente para el contrato de la fase y los propósitos del monorepo; tipos mayores requerirían `COMP-5` de 8 bytes |
| Búsqueda secuencial en el registro de vértices | Coste `O(V)` al buscar o verificar vértices en el grafo | Requisito intencionado de la especificación para forzar el aprendizaje de estructuras enlazadas manuales |

## 📝 Notas de implementación / Implementation Notes

**ES:** COBOL es un lenguaje procedimental sin clases ni herencia nativa de tipos. El contrato se implementa como subprogramas independientes identificados por `PROGRAM-ID`, donde los datos se transfieren por referencia mediante `LINKAGE SECTION`.

La base conceptual `Node` se implementa como valor embebido en los tipos `DSA-TREE-NODE` y `DSA-GRAPH-NODE`, cumpliendo con la decisión de contrato que permite embeber el valor sin declarar un tipo base ficticio. La memoria dinámica se gestiona mediante las sentencias estándar `ALLOCATE` y `FREE`, accediendo a las estructuras mediante cláusulas `BASED` y la instrucción `SET ADDRESS OF ... TO <puntero>`.

Para el árbol binario, las inserciones y búsquedas son iterativas para garantizar eficiencia y evitar problemas de límite de recursión de pila en llamadas anidadas. La liberación del árbol (`TREE-NODE-FREE`) utiliza `IS RECURSIVE` y `LOCAL-STORAGE SECTION` para recorrer y liberar la estructura en post-orden.

El grafo implementa un registro enlazado manual de vértices sin recurrir a diccionarios o tablas hash. La inserción de aristas mantiene la lista de adyacencia ordenada ascendentemente en todo momento. La función `GRAPH-GET-NEIGHBORS` construye una copia enlazada totalmente independiente usando un puntero de cola (`WS-TAIL`), asegurando tanto la inmutabilidad de la estructura ante el llamador como una cota temporal de construcción de `O(d(u))`.

**EN:** COBOL is a procedural language without classes or native type inheritance. The contract is implemented as independent subprograms identified by `PROGRAM-ID`, where parameters are passed by reference via the `LINKAGE SECTION`.

The conceptual `Node` base is implemented as an embedded value within the `DSA-TREE-NODE` and `DSA-GRAPH-NODE` types, adhering to the contract decision allowing embedded values without declaring a dummy base type. Dynamic memory is managed via standard `ALLOCATE` and `FREE` statements, accessing records through `BASED` clauses and `SET ADDRESS OF ... TO <pointer>`.

For the binary tree, insertions and searches are implemented iteratively to guarantee efficiency and avoid stack recursion depth issues. Tree deallocation (`TREE-NODE-FREE`) uses `IS RECURSIVE` and `LOCAL-STORAGE SECTION` to traverse and free nodes in post-order.

The graph implements a manual linked vertex registry without relying on dictionaries or hash tables. Edge insertion maintains the adjacency list in ascending sorted order at all times. The `GRAPH-GET-NEIGHBORS` operation constructs a completely independent linked copy using a tail pointer (`WS-TAIL`), ensuring caller isolation as well as an `O(d(u))` construction time bound.

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
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`cobol/core/algorithms/data_structures_basics/`](../data_structures_basics/) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`cobol/core/foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [GnuCOBOL Programmer's Guide](https://gnucobol.sourceforge.io/guides.html) |

---

*[← Volver a Algorithms](../README.md) | [↑ Core COBOL](../../README.md) | [↑ Inicio / Home](../../../../docs/index.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
