# Hello, User! — COBOL

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **COBOL**, compilado con **GnuCOBOL (cobc)**.

Lee un nombre desde la entrada estándar y saluda al usuario.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_user.cob`](hello_user.cob) | Código fuente: solicita un nombre al usuario y saluda. |

**Estructura de directorios esperada:**

```text
hellouser/
├── hello_user.cob       # Código fuente
├── hello_user           # Ejecutable (generado con cobc)
└── README.md            # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce tres conceptos nuevos respecto a `helloworld`:

1. **División de Datos (`DATA DIVISION`)** — declara variables con `PIC` (picture) para almacenar datos.
2. **Entrada de usuario** — `ACCEPT` lee una línea desde `stdin` y la almacena en una variable.
3. **Variables alfanuméricas** — `PIC X(n)` define un campo de caracteres de longitud fija.

**EN:** This program introduces three new concepts compared to `helloworld`:

1. **Data Division (`DATA DIVISION`)** — declares variables with `PIC` (picture) to store data.
2. **User input** — `ACCEPT` reads a line from `stdin` and stores it in a variable.
3. **Alphanumeric variables** — `PIC X(n)` defines a fixed-length character field.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `hello_user.cob`

**ES:** El flujo del programa es:

1. Declarar una variable `user-name` de tipo alfanumérico con `PIC X(100)`.
2. Imprimir `"Hello, what is your name?"` con `DISPLAY`.
3. Leer el nombre con `ACCEPT user-name`.
4. Imprimir el saludo con `DISPLAY`.
5. Terminar con `STOP RUN`.

**EN:** Program flow:

1. Declare a `user-name` alphanumeric variable with `PIC X(100)`.
2. Print `"Hello, what is your name?"` with `DISPLAY`.
3. Read the name with `ACCEPT user-name`.
4. Print the greeting with `DISPLAY`.
5. Terminate with `STOP RUN`.

```cobol
identification division.
program-id. hello-user.

environment division.
input-output section.

data division.
working-storage section.
01 user-name pic x(100).

procedure division.
    display "Hello, what is your name?".
    accept user-name.
    display "Hello, " user-name "!".
    stop run.
```

| Elemento | Propósito |
|----------|-----------|
| `IDENTIFICATION DIVISION.` | División de metadatos del programa |
| `PROGRAM-ID. hello-user.` | Nombre del programa |
| `ENVIRONMENT DIVISION.` | División que describe el entorno (archivos, dispositivos) |
| `INPUT-OUTPUT SECTION.` | Sección que declara los dispositivos de E/S |
| `DATA DIVISION.` | División donde se declaran las variables y estructuras de datos |
| `WORKING-STORAGE SECTION.` | Sección para variables locales (memoria de trabajo) |
| `01 user-name pic x(100).` | Variable alfanumérica de 100 caracteres de longitud |
| `PROCEDURE DIVISION.` | División con la lógica ejecutable |
| `DISPLAY "..."` | Imprime una cadena en la salida estándar |
| `ACCEPT user-name` | Lee una línea desde la entrada estándar y la almacena en la variable |
| `STOP RUN.` | Termina la ejecución del programa |

> **ES:** En COBOL, las variables se definen con niveles de jerarquía (`01`, `05`, `10`, etc.) y un `PIC` (picture) que describe el formato del dato. `PIC X(100)` significa 100 caracteres alfanuméricos.
> **EN:** In COBOL, variables are defined with hierarchy levels (`01`, `05`, `10`, etc.) and a `PIC` (picture) that describes the data format. `PIC X(100)` means 100 alphanumeric characters.

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
cobc -x -o hello_user hello_user.cob

# Ejecutar
./hello_user
```

**Salida esperada / Expected output:**

```text
Hello, what is your name?
Ada
Hello, Ada!
```

> **ES:** El programa espera a que el usuario escriba su nombre y presione Enter antes de mostrar el saludo.
> **EN:** The program waits for the user to type their name and press Enter before showing the greeting.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** A diferencia de lenguajes modernos, COBOL no tiene un tipo `string` dinámico. Las variables se definen con longitud fija mediante `PIC`. `PIC X(100)` define un campo que acepta hasta 100 caracteres; si se ingresan menos, se rellena con espacios a la derecha.
- **EN:** Unlike modern languages, COBOL does not have a dynamic `string` type. Variables are defined with fixed length using `PIC`. `PIC X(100)` defines a field that accepts up to 100 characters; if fewer are entered, it is padded with spaces on the right.
- **ES:** La sentencia `ACCEPT` en GnuCOBOL lee desde `stdin`. Es la forma estándar de obtener entrada del usuario en COBOL, equivalente a `read-line` en otros lenguajes.
- **EN:** The `ACCEPT` statement in GnuCOBOL reads from `stdin`. It is the standard way to get user input in COBOL, equivalent to `read-line` in other languages.
- **ES:** `ENVIRONMENT DIVISION` con `INPUT-OUTPUT SECTION` se incluye para declarar explícitamente los dispositivos de E/S del programa, aunque en este caso GnuCOBOL usa `stdin`/`stdout` por defecto.
- **EN:** `ENVIRONMENT DIVISION` with `INPUT-OUTPUT SECTION` is included to explicitly declare the program's I/O devices, although in this case GnuCOBOL uses `stdin`/`stdout` by default.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
