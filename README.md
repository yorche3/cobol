# COBOL

Proyectos en **COBOL (GnuCOBOL)**, compilados con **cobc** en formato libre (`-free`).

Usa `make` como build system y aserciones artesanales via `COPY` para pruebas unitarias.

---

## 📂 Módulos / Modules

| Módulo | Descripción |
|--------|-------------|
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `calculator`, `numbers` |

---

### ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
cobc -x -free -o hello hello.cbl && ./hello

# Hello, User!
cd core/foundations/hellouser
cobc -x -free -o hello_user hello_user.cbl && ./hello_user

# Calculator Tests
cd core/foundations/unit_test/calculator
make test

# Numbers Tests
cd core/foundations/numbers
make test
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
|-------------|-------------|
| [GnuCOBOL](https://gnucobol.sourceforge.io/) (cobc) 3.2+ | `sudo apt install gnucobol` (Linux) / `brew install gnucobol` (macOS) |
| [Make](https://www.gnu.org/software/make/) | `sudo apt install make` (Linux, incluido en macOS) |

```bash
# Verificar instalación
cobc --version && make --version
```

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Programa simple (archivo único)

**ES:** Un único archivo fuente `.cbl` con `PROCEDURE DIVISION`, compilado directamente con `cobc -x`. Ideal para `helloworld` y `hellouser`.

**EN:** A single `.cbl` source file with `PROCEDURE DIVISION`, compiled directly with `cobc -x`. Ideal for `helloworld` and `hellouser`.

```bash
cobc -x -free -o <ejecutable> <archivo>.cbl
```

### 2. Proyecto multi-archivo con pruebas (make + COPY)

**ES:** Para proyectos que requieren pruebas unitarias, se organizan en `src/` (biblioteca con subprogramas) y `test/` (suites de pruebas). Las aserciones se definen en un copybook (`ASSERTS.cpy`) y se incluyen con `COPY`. Los copybooks se localizan con `-I`.

**EN:** For projects requiring unit tests, they are organized in `src/` (library with subprograms) and `test/` (test suites). Assertions are defined in a copybook (`ASSERTS.cpy`) and included via `COPY`. Copybooks are located with `-I`.

```bash
cobc -x -free -Isrc/copybooks -Itest -o run_tests src/*.cbl test/*.cbl
./run_tests
```

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---
*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*