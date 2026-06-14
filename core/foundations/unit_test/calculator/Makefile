# Makefile para CALCULATOR — COBOL
# Compilador: GnuCOBOL (cobc)
# Formato: libre (free format)
# Copybooks: src/ y test/

COBC      = cobc
CFLAGS    = -x -free -I$(SRC_DIR) -I$(TEST_DIR)
SRC_DIR   = src
TEST_DIR  = test
TARGET    = run_tests

.SUFFIXES: .cbl .cob

.PHONY: all build test clean

all: build

# Compila el ejecutable de pruebas con todos los fuentes
build: $(TARGET)

$(TARGET): $(TEST_DIR)/RUN-TESTS.cbl $(SRC_DIR)/CALCULATOR.cbl
	$(COBC) $(CFLAGS) -o $@ $^

# Ejecuta las pruebas
test: build
	./$(TARGET)

# Limpia archivos generados
clean:
	rm -f $(TARGET)
	rm -f *.so *.dll *.o
	rm -rf target/
