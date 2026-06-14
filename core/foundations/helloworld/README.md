# Hello, World! — COBOL

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **COBOL**, compilado con **GnuCOBOL (cobc)**.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_world.cob`](hello_world.cob) | Código fuente: imprime `"Hello World! from Cobol!"` en la consola. |

**Estructura de directorios esperada:**

```text
helloworld/
├── hello_world.cob      # Código fuente
├── hello_world          # Ejecutable (generado con cobc)
└── README.md            # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **COBOL** con **GnuCOBOL** y sigue un enfoque minimalista: un único archivo fuente, sin dependencias externas, compilado directamente con `cobc`.

Características:
- **Sin bibliotecas externas** — solo usa la sentencia `DISPLAY` del estándar COBOL.
- **Compilación directa** — un solo comando `cobc` genera el ejecutable.
- **Estructura clásica** — divisiones obligatorias del estándar COBOL: `IDENTIFICATION DIVISION`, `PROCEDURE DIVISION`.

**EN:** This project uses **COBOL** with **GnuCOBOL** and follows a minimalist approach: a single source file, no external dependencies, compiled directly with `cobc`.

Features:
- **No external libraries** — only uses the `DISPLAY` statement from COBOL standard.
- **Direct compilation** — a single `cobc` command generates the executable.
- **Classic structure** — mandatory COBOL standard divisions: `IDENTIFICATION DIVISION`, `PROCEDURE DIVISION`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `hello_world.cob`

**ES:** Punto de entrada. Define el programa `HelloWorld` con dos divisiones obligatorias:
1. `IDENTIFICATION DIVISION` — metadatos del programa (nombre, autor, etc.).
2. `PROCEDURE DIVISION` — contiene la lógica ejecutable.

**EN:** Entry point. Defines the `HelloWorld` program with two mandatory divisions:
1. `IDENTIFICATION DIVISION` — program metadata (name, author, etc.).
2. `PROCEDURE DIVISION` — contains the executable logic.

```cobol
IDENTIFICATION DIVISION.
PROGRAM-ID. HelloWorld.
PROCEDURE DIVISION.
    DISPLAY "Hello World! from Cobol!"
    STOP RUN.
```

| Elemento | Propósito |
|----------|-----------|
| `IDENTIFICATION DIVISION.` | División obligatoria que contiene metadatos del programa |
| `PROGRAM-ID. HelloWorld.` | Nombre del programa (identificador) |
| `PROCEDURE DIVISION.` | División que contiene el código ejecutable |
| `DISPLAY` | Sentencia que imprime una cadena en la salida estándar |
| `"Hello World! from Cobol!"` | Cadena literal a mostrar |
| `STOP RUN.` | Termina la ejecución del programa |

> **ES:** COBOL usa una sintaxis verbosa y estructurada por *divisiones* (DIVISION), *secciones* (SECTION) y *párrafos* (PARAGRAPH). Cada sentencia termina con un punto.
> **EN:** COBOL uses a verbose syntax structured by *divisions* (DIVISION), *sections* (SECTION) and *paragraphs* (PARAGRAPH). Each statement ends with a period.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener GnuCOBOL instalado

```bash
# Linux (Debian/Ubuntu)
sudo apt install gnucobol

# macOS (con Homebrew)
brew install gnucobol

# Windows (con chocolatey)
choco install gnucobol

# Verificar instalación
cobc --version
```

### Compilar y ejecutar

```bash
# Compilar
cobc -x -o hello_world hello_world.cob

# Ejecutar
./hello_world
```

> **ES:** La flag `-x` indica a `cobc` que genere un ejecutable (no una biblioteca). Sin ella, se genera un archivo `.so` o `.dll`.
> **EN:** The `-x` flag tells `cobc` to generate an executable (not a library). Without it, a `.so` or `.dll` file is generated.

**Salida esperada / Expected output:**

```text
Hello World! from Cobol!
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** El programa usa la sintaxis COBOL estándar (COBOL-85/2002). No requiere configuraciones especiales del compilador.
- **EN:** The program uses standard COBOL syntax (COBOL-85/2002). No special compiler configurations are required.
- **ES:** A diferencia de lenguajes modernos, COBOL no necesita un `main()` explícito; el punto de entrada es el primer párrafo de `PROCEDURE DIVISION` (o el programa completo).
- **EN:** Unlike modern languages, COBOL does not need an explicit `main()`; the entry point is the first paragraph in `PROCEDURE DIVISION` (or the entire program).
- **ES:** `STOP RUN.` es la forma estándar de finalizar un programa COBOL y retornar el control al sistema operativo.
- **EN:** `STOP RUN.` is the standard way to end a COBOL program and return control to the operating system.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
