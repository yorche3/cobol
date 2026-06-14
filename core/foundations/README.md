# 🚀 Foundations — COBOL

Implementaciones de la [Fase 0 — Fundamentos](https://yorche3.github.io/programming_languages/ROADMAP/#fase-0--fundamentos--foundations--completada) en **COBOL (GnuCOBOL)**: `helloworld`, `hellouser`, `unit_test/calculator` y `numbers`.

---

## 📖 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`helloworld/`](helloworld/) | [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | `cobc -x` (archivo único) | — | ✅ |
| [`hellouser/`](hellouser/) | [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | `cobc -x` (archivo único) | — | ✅ |
| [`unit_test/calculator/`](unit_test/calculator/) | [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | `make test` + aserciones artesanales (`COPY`) | 5 | ✅ |
| [`numbers/`](numbers/) | [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | `make test` + aserciones artesanales (`COPY`) | 22 | ✅ |

---

## 📁 Estructura / Structure

```text
foundations/
├── helloworld/                   # 01_Hello_World
│   ├── hello.cbl                 # DISPLAY "Hello, World!"
│   └── README.md
│
├── hellouser/                    # 02_Hello_User
│   ├── hello_user.cbl            # Acepta nombre y saluda
│   └── README.md
│
├── unit_test/
│   └── calculator/               # 03_Unit_Test_Calculator
│       ├── Makefile
│       ├── src/
│       │   ├── copybooks/CALC-OPERATIONS.cpy
│       │   └── lib/CALC.cbl      # 5 operaciones aritméticas
│       └── test/
│           ├── ASSERTS.cpy       # Aserciones reutilizables
│           ├── CALC-TESTS.cbl    # 5 tests
│           └── RUN-TESTS.cbl     # Orquestador
│       └── README.md
│
└── numbers/                      # 04_Numbers
    ├── Makefile
    ├── src/
    │   ├── copybooks/NUMBERS-PARAMS.cpy
    │   └── lib/NUMBERS.cbl       # 15 subprogramas (3 enfoques × 5 algoritmos)
    └── test/
        ├── ASSERTS.cpy           # Aserciones reutilizables
        ├── RECURSIVE-TESTS.cbl   # 11 tests recursivos
        ├── ITERATIVE-TESTS.cbl   # 11 tests iterativos
        └── RUN-TESTS.cbl         # Orquestador
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Compilador** | GnuCOBOL (`cobc`) versión 3.2+ |
| **Formato** | Libre (`-free`) — sin columnas fijas |
| **Archivos únicos** | `cobc -x <archivo>.cbl` para programas simples (`helloworld`, `hellouser`) |
| **Proyectos con tests** | `make test` compila y ejecuta todas las suites |
| **Framework de tests** | Artesanal — `COPY ASSERTS.cpy` provee `ASSERT-EQUAL` y `ASSERT-REPORT` |
| **Aserciones** | `ASSERT-EQUAL`: compara `WS-ASSERT-ACTUAL` vs `WS-ASSERT-EXPECTED` |
| **Reporte** | `ASSERT-REPORT`: muestra total, pasadas, falladas y setea `RETURN-CODE` |
| **Copybooks** | `src/copybooks/` y `test/` incluidos via `-I` en `cobc` |
| **Recursión** | `IS RECURSIVE` + `LOCAL-STORAGE SECTION` (por instancia, no estática) |
| **Paso de parámetros** | Por referencia (default en COBOL). Copias locales para no corromper llamador |

---

## 🚀 Compilación rápida / Quick Build

### Requisito: Tener GnuCOBOL instalado

```bash
# Ubuntu / Debian
sudo apt install gnucobol

# macOS (con Homebrew)
brew install gnucobol

# Windows (con MSYS2 o WSL)
# Ver: https://gnucobol.sourceforge.io/faq/index.html
```

### Ejecutar cada módulo

```bash
# Hello, World!
cd helloworld
cobc -x -free -o hello hello.cbl && ./hello

# Hello, User!
cd hellouser
cobc -x -free -o hello_user hello_user.cbl && ./hello_user

# Calculator Tests
cd unit_test/calculator
make test

# Numbers Tests
cd numbers
make test
```

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

## ▶️ Siguiente / Next

👉 Después de fundamentos, continúa con [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-).  
👉 After foundations, continue with [Phase 1 — Algorithms Pure](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-).

---

*[← Volver a COBOL](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
