# Makefile for data_structures_basics — COBOL
# Compiler: GnuCOBOL (cobc)
# Format: free format
# Copybooks: src/copybooks/ and test/

COBC      = cobc
CFLAGS    = -x -free -Isrc/copybooks -Itest
SRC_DIR   = src/lib
TEST_DIR  = test
TARGET    = run_tests

.PHONY: all build test clean

all: build

build: $(TARGET)

$(TARGET): $(TEST_DIR)/RUN-TESTS.cbl \
           $(SRC_DIR)/DATA-STRUCTURES.cbl
	$(COBC) $(CFLAGS) -o $@ $^

test: build
	./$(TARGET)

clean:
	rm -f $(TARGET)
	rm -f *.so *.dll *.o
	rm -rf target/ build/ dist/
