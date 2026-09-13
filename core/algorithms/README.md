# Algorithms Pure — COBOL

Implementación de la especificación [Algorithms Pure](../../../../docs/core/algorithms/README.md) en **COBOL**, con un enfoque manual y minimalista.

---

## 📂 Módulos / Modules

| Módulo | Estado | Descripción |
|--------|--------|-------------|
| [`naive_sort/`](naive_sort/) | ✅ | **Ordenamiento elemental**: `selection_sort`, `bubble_sort`, `insertion_sort` ($O(n^2)$) |

---

## 🚀 Compilación y ejecución / Build & Run

Cada módulo contiene sus propios comandos de compilación y ejecución. Por ejemplo:

```bash
cd cobol/core/algorithms/naive_sort
make clean && make
./run_tests
```

---

## 📝 Notas de implementación / Implementation Notes

**ES:** COBOL es un lenguaje orientado a procedimientos que no soporta recursión de forma natural. Todos los algoritmos se implementaron de manera iterativa. El manejo de arrays se realiza mediante estructuras con cláusulas OCCURS. La implementación sigue el patrón de devolver un código de retorno (RETURN-CODE) para indicar éxito o fracaso.

**EN:** COBOL is a procedural language that does not naturally support recursion. All algorithms were implemented iteratively. Array handling is performed using structures with OCCURS clauses. The implementation follows the pattern of returning a return code (RETURN-CODE) to indicate success or failure.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.