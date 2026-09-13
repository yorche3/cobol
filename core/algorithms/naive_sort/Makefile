# Makefile para NAIVE_SORT — COBOL
# Compilador: GnuCOBOL (cobc)
# Formato: libre (free format)
# Copybooks: src/copybooks/ y test/

COBC      = cobc
CFLAGS    = -x -free -Isrc -Itest
SRC_DIR   = src
TEST_DIR  = test
TARGET    = run_tests

.PHONY: all build test clean

all: build

# Compila el ejecutable de pruebas con todos los fuentes
build: $(TARGET)

$(TARGET): $(TEST_DIR)/RUN-TESTS.cbl \
           $(TEST_DIR)/NAIVE-SORT-TESTS.cbl \
           $(SRC_DIR)/SELECTION-SORT.cbl \
           $(SRC_DIR)/BUBBLE-SORT.cbl \
           $(SRC_DIR)/INSERTION-SORT.cbl
	$(COBC) $(CFLAGS) -o $@ $^

# Ejecuta las pruebas
test: build
	./$(TARGET)

# Limpia archivos generados
clean:
	rm -f $(TARGET)
	rm -f *.so *.dll *.o
	rm -rf target/
