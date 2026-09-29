*> ====================================================================
*> DATA-STRUCTURES.cbl — Node, LinkedList, Stack y Queue en COBOL
*> Contrato ejecutable: un subprograma por operacion del contrato.
*>
*> Modelo de memoria. Cada nodo se reserva con ALLOCATE y las estructuras
*> guardan unicamente su direccion (USAGE POINTER). Los campos del nodo se
*> leen y se escriben superponiendo DS-NODE (BASED, definido en el copybook
*> de parametros) a esa direccion con SET ADDRESS OF; los nodos que dejan de
*> pertenecer a la estructura se liberan con FREE. Ninguna operacion comparte
*> nodos temporales entre llamadas: cada subprograma reserva su propio bloque.
*>
*> Indicador de fallo: DS-FAILURE-VALUE (-1) en los resultados numericos y
*> NULL en los punteros.
*>
*> Interfaz de llamada (parametros BY REFERENCE, en este orden). El area de
*> resultado debe tener el ancho declarado aqui: un booleano (PIC 9) escrito
*> sobre un area de nueve digitos solo cambiaria su primer caracter.
*>
*>   Node
*>     CALL "NODE-INIT"      USING nodo (POINTER) valor (S9(9))
*>     CALL "NODE-GET-VALUE" USING nodo (POINTER) resultado (S9(9))
*>     CALL "NODE-GET-NEXT"  USING nodo (POINTER) siguiente (POINTER)
*>     CALL "NODE-SET-NEXT"  USING nodo (POINTER) siguiente (POINTER)
*>
*>   LinkedList
*>     CALL "LINKED-LIST-INIT"        USING lista
*>     CALL "LINKED-LIST-GET-HEAD"    USING lista resultado (S9(9); -1 vacia)
*>     CALL "LINKED-LIST-INSERT-HEAD" USING lista valor (S9(9))
*>     CALL "LINKED-LIST-INSERT-TAIL" USING lista valor (S9(9))
*>     CALL "LINKED-LIST-DELETE"      USING lista valor (S9(9))
*>                                          resultado (S9(9); 0 exito, -1 fallo)
*>     CALL "LINKED-LIST-IS-EMPTY"    USING lista bandera (PIC 9; 1 vacia)
*>     CALL "LINKED-LIST-SIZE"        USING lista resultado (9(9))
*>
*>   Stack
*>     CALL "STACK-INIT"     USING pila
*>     CALL "STACK-PUSH"     USING pila valor (S9(9))
*>     CALL "STACK-POP"      USING pila resultado (S9(9); -1 vacia)
*>     CALL "STACK-PEEK"     USING pila resultado (S9(9); -1 vacia)
*>     CALL "STACK-IS-EMPTY" USING pila bandera (PIC 9; 1 vacia)
*>     CALL "STACK-SIZE"     USING pila resultado (9(9))
*>
*>   Queue
*>     CALL "QUEUE-INIT"     USING cola
*>     CALL "QUEUE-ENQUEUE"  USING cola valor (S9(9))
*>     CALL "QUEUE-DEQUEUE"  USING cola resultado (S9(9); -1 vacia)
*>     CALL "QUEUE-PEEK"     USING cola resultado (S9(9); -1 vacia)
*>     CALL "QUEUE-IS-EMPTY" USING cola bandera (PIC 9; 1 vacia)
*>     CALL "QUEUE-SIZE"     USING cola resultado (9(9))
*> ====================================================================

*> ====================================================================
*> Node — nodo compartido por las tres estructuras
*> ====================================================================

*> Node.init(value): reserva el nodo, asigna value y deja next ausente.
IDENTIFICATION DIVISION.
PROGRAM-ID. NODE-INIT.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-NODE            USAGE POINTER.
01 LN-VALUE           PIC S9(9).

PROCEDURE DIVISION USING LN-NODE LN-VALUE.
    ALLOCATE DS-NODE
    MOVE LN-VALUE TO DS-NODE-VALUE
    SET DS-NODE-NEXT TO NULL
    SET LN-NODE TO ADDRESS OF DS-NODE
    GOBACK.
END PROGRAM NODE-INIT.

*> Node.get-value(): valor del nodo.
IDENTIFICATION DIVISION.
PROGRAM-ID. NODE-GET-VALUE.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-NODE            USAGE POINTER.
01 LN-RESULT          PIC S9(9).

PROCEDURE DIVISION USING LN-NODE LN-RESULT.
    SET ADDRESS OF DS-NODE TO LN-NODE
    MOVE DS-NODE-VALUE TO LN-RESULT
    GOBACK.
END PROGRAM NODE-GET-VALUE.

*> Node.get-next(): direccion del nodo siguiente, que puede estar ausente.
IDENTIFICATION DIVISION.
PROGRAM-ID. NODE-GET-NEXT.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-NODE            USAGE POINTER.
01 LN-NEXT            USAGE POINTER.

PROCEDURE DIVISION USING LN-NODE LN-NEXT.
    SET ADDRESS OF DS-NODE TO LN-NODE
    SET LN-NEXT TO DS-NODE-NEXT
    GOBACK.
END PROGRAM NODE-GET-NEXT.

*> Node.set-next(next): enlaza otro nodo (o deja el enlace ausente con NULL).
IDENTIFICATION DIVISION.
PROGRAM-ID. NODE-SET-NEXT.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-NODE            USAGE POINTER.
01 LN-NEXT            USAGE POINTER.

PROCEDURE DIVISION USING LN-NODE LN-NEXT.
    SET ADDRESS OF DS-NODE TO LN-NODE
    SET DS-NODE-NEXT TO LN-NEXT
    GOBACK.
END PROGRAM NODE-SET-NEXT.

*> ====================================================================
*> LinkedList
*> ====================================================================

*> LinkedList.init(): cabeza y cola ausentes, tamano cero.
IDENTIFICATION DIVISION.
PROGRAM-ID. LINKED-LIST-INIT.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".

PROCEDURE DIVISION USING DS-LINKED-LIST.
    SET DS-LIST-HEAD TO NULL
    SET DS-LIST-TAIL TO NULL
    MOVE 0 TO DS-LIST-COUNT
    GOBACK.
END PROGRAM LINKED-LIST-INIT.

*> LinkedList.get-head(): valor de la cabeza, o fallo si la lista esta vacia.
IDENTIFICATION DIVISION.
PROGRAM-ID. LINKED-LIST-GET-HEAD.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-RESULT          PIC S9(9).

PROCEDURE DIVISION USING DS-LINKED-LIST LN-RESULT.
    IF DS-LIST-HEAD = NULL
        MOVE DS-FAILURE-VALUE TO LN-RESULT
    ELSE
        SET ADDRESS OF DS-NODE TO DS-LIST-HEAD
        MOVE DS-NODE-VALUE TO LN-RESULT
    END-IF
    GOBACK.
END PROGRAM LINKED-LIST-GET-HEAD.

*> LinkedList.insert-head(value): el nodo nuevo pasa a ser la cabeza.
IDENTIFICATION DIVISION.
PROGRAM-ID. LINKED-LIST-INSERT-HEAD.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-VALUE           PIC S9(9).

PROCEDURE DIVISION USING DS-LINKED-LIST LN-VALUE.
    ALLOCATE DS-NODE
    MOVE LN-VALUE TO DS-NODE-VALUE
    SET DS-NODE-NEXT TO DS-LIST-HEAD
    SET DS-LIST-HEAD TO ADDRESS OF DS-NODE
    IF DS-LIST-TAIL = NULL
        SET DS-LIST-TAIL TO ADDRESS OF DS-NODE
    END-IF
    ADD 1 TO DS-LIST-COUNT
    GOBACK.
END PROGRAM LINKED-LIST-INSERT-HEAD.

*> LinkedList.insert-tail(value): el nodo nuevo pasa a ser la cola.
IDENTIFICATION DIVISION.
PROGRAM-ID. LINKED-LIST-INSERT-TAIL.

DATA DIVISION.
LOCAL-STORAGE SECTION.
01 LS-NEW-NODE        USAGE POINTER.

LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-VALUE           PIC S9(9).

PROCEDURE DIVISION USING DS-LINKED-LIST LN-VALUE.
    ALLOCATE DS-NODE
    SET LS-NEW-NODE TO ADDRESS OF DS-NODE
    MOVE LN-VALUE TO DS-NODE-VALUE
    SET DS-NODE-NEXT TO NULL
    IF DS-LIST-TAIL = NULL
        SET DS-LIST-HEAD TO LS-NEW-NODE
        SET DS-LIST-TAIL TO LS-NEW-NODE
    ELSE
        *> La cola anterior se enlaza con el nodo nuevo: DS-LIST-TAIL es una
        *> copia del puntero, asi que reapuntar la vista DS-NODE no la altera.
        SET ADDRESS OF DS-NODE TO DS-LIST-TAIL
        SET DS-NODE-NEXT TO LS-NEW-NODE
        SET DS-LIST-TAIL TO LS-NEW-NODE
    END-IF
    ADD 1 TO DS-LIST-COUNT
    GOBACK.
END PROGRAM LINKED-LIST-INSERT-TAIL.

*> LinkedList.delete(value): elimina la primera aparicion y devuelve exito,
*> o el indicador de fallo si el valor no esta.
IDENTIFICATION DIVISION.
PROGRAM-ID. LINKED-LIST-DELETE.

DATA DIVISION.
LOCAL-STORAGE SECTION.
01 LS-CURRENT         USAGE POINTER.
01 LS-PREVIOUS        USAGE POINTER.
01 LS-NEXT-NODE       USAGE POINTER.
01 LS-FOUND           PIC 9 VALUE 0.

LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-VALUE           PIC S9(9).
01 LN-RESULT          PIC S9(9).

PROCEDURE DIVISION USING DS-LINKED-LIST LN-VALUE LN-RESULT.
    *> Busqueda de la primera aparicion conservando el nodo anterior.
    MOVE 0 TO LS-FOUND
    SET LS-PREVIOUS TO NULL
    SET LS-CURRENT TO DS-LIST-HEAD
    PERFORM UNTIL LS-CURRENT = NULL OR LS-FOUND = 1
        SET ADDRESS OF DS-NODE TO LS-CURRENT
        IF DS-NODE-VALUE = LN-VALUE
            MOVE 1 TO LS-FOUND
        ELSE
            SET LS-PREVIOUS TO LS-CURRENT
            SET LS-CURRENT TO DS-NODE-NEXT
        END-IF
    END-PERFORM
    IF LS-FOUND = 0
        MOVE DS-FAILURE-VALUE TO LN-RESULT
    ELSE
        *> Desenlace: el anterior apunta al siguiente del eliminado.
        SET ADDRESS OF DS-NODE TO LS-CURRENT
        SET LS-NEXT-NODE TO DS-NODE-NEXT
        IF DS-LIST-TAIL = LS-CURRENT
            SET DS-LIST-TAIL TO LS-PREVIOUS
        END-IF
        IF LS-PREVIOUS = NULL
            SET DS-LIST-HEAD TO LS-NEXT-NODE
        ELSE
            SET ADDRESS OF DS-NODE TO LS-PREVIOUS
            SET DS-NODE-NEXT TO LS-NEXT-NODE
        END-IF
        SET ADDRESS OF DS-NODE TO LS-CURRENT
        FREE DS-NODE
        SUBTRACT 1 FROM DS-LIST-COUNT
        MOVE 0 TO LN-RESULT
    END-IF
    GOBACK.
END PROGRAM LINKED-LIST-DELETE.

*> LinkedList.is-empty(): verdadero solo si no hay nodos.
IDENTIFICATION DIVISION.
PROGRAM-ID. LINKED-LIST-IS-EMPTY.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-RESULT          PIC 9.

PROCEDURE DIVISION USING DS-LINKED-LIST LN-RESULT.
    IF DS-LIST-HEAD = NULL
        MOVE 1 TO LN-RESULT
    ELSE
        MOVE 0 TO LN-RESULT
    END-IF
    GOBACK.
END PROGRAM LINKED-LIST-IS-EMPTY.

*> LinkedList.size(): numero de elementos desde init.
IDENTIFICATION DIVISION.
PROGRAM-ID. LINKED-LIST-SIZE.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-RESULT          PIC 9(9).

PROCEDURE DIVISION USING DS-LINKED-LIST LN-RESULT.
    MOVE DS-LIST-COUNT TO LN-RESULT
    GOBACK.
END PROGRAM LINKED-LIST-SIZE.

*> ====================================================================
*> Stack — ADT LIFO sobre el mismo Node
*> ====================================================================

*> Stack.init(): tope ausente, tamano cero.
IDENTIFICATION DIVISION.
PROGRAM-ID. STACK-INIT.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".

PROCEDURE DIVISION USING DS-STACK.
    SET DS-STACK-TOP TO NULL
    MOVE 0 TO DS-STACK-COUNT
    GOBACK.
END PROGRAM STACK-INIT.

*> Stack.push(value): el nodo nuevo pasa a ser el tope.
IDENTIFICATION DIVISION.
PROGRAM-ID. STACK-PUSH.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-VALUE           PIC S9(9).

PROCEDURE DIVISION USING DS-STACK LN-VALUE.
    ALLOCATE DS-NODE
    MOVE LN-VALUE TO DS-NODE-VALUE
    SET DS-NODE-NEXT TO DS-STACK-TOP
    SET DS-STACK-TOP TO ADDRESS OF DS-NODE
    ADD 1 TO DS-STACK-COUNT
    GOBACK.
END PROGRAM STACK-PUSH.

*> Stack.pop(): extrae el tope y devuelve su valor, o fallo si esta vacia.
IDENTIFICATION DIVISION.
PROGRAM-ID. STACK-POP.

DATA DIVISION.
LOCAL-STORAGE SECTION.
01 LS-POPPED-NODE     USAGE POINTER.

LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-RESULT          PIC S9(9).

PROCEDURE DIVISION USING DS-STACK LN-RESULT.
    IF DS-STACK-TOP = NULL
        MOVE DS-FAILURE-VALUE TO LN-RESULT
    ELSE
        SET LS-POPPED-NODE TO DS-STACK-TOP
        SET ADDRESS OF DS-NODE TO LS-POPPED-NODE
        MOVE DS-NODE-VALUE TO LN-RESULT
        SET DS-STACK-TOP TO DS-NODE-NEXT
        SUBTRACT 1 FROM DS-STACK-COUNT
        *> La vista sigue apuntando al nodo extraido: se libera aqui.
        FREE DS-NODE
    END-IF
    GOBACK.
END PROGRAM STACK-POP.

*> Stack.peek(): observa el tope sin extraerlo, o fallo si esta vacia.
IDENTIFICATION DIVISION.
PROGRAM-ID. STACK-PEEK.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-RESULT          PIC S9(9).

PROCEDURE DIVISION USING DS-STACK LN-RESULT.
    IF DS-STACK-TOP = NULL
        MOVE DS-FAILURE-VALUE TO LN-RESULT
    ELSE
        SET ADDRESS OF DS-NODE TO DS-STACK-TOP
        MOVE DS-NODE-VALUE TO LN-RESULT
    END-IF
    GOBACK.
END PROGRAM STACK-PEEK.

*> Stack.is-empty(): verdadero solo si no hay nodos.
IDENTIFICATION DIVISION.
PROGRAM-ID. STACK-IS-EMPTY.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-RESULT          PIC 9.

PROCEDURE DIVISION USING DS-STACK LN-RESULT.
    IF DS-STACK-TOP = NULL
        MOVE 1 TO LN-RESULT
    ELSE
        MOVE 0 TO LN-RESULT
    END-IF
    GOBACK.
END PROGRAM STACK-IS-EMPTY.

*> Stack.size(): numero de elementos desde init.
IDENTIFICATION DIVISION.
PROGRAM-ID. STACK-SIZE.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-RESULT          PIC 9(9).

PROCEDURE DIVISION USING DS-STACK LN-RESULT.
    MOVE DS-STACK-COUNT TO LN-RESULT
    GOBACK.
END PROGRAM STACK-SIZE.

*> ====================================================================
*> Queue — ADT FIFO sobre el mismo Node
*> ====================================================================

*> Queue.init(): frente y final ausentes, tamano cero.
IDENTIFICATION DIVISION.
PROGRAM-ID. QUEUE-INIT.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".

PROCEDURE DIVISION USING DS-QUEUE.
    SET DS-QUEUE-FRONT TO NULL
    SET DS-QUEUE-REAR TO NULL
    MOVE 0 TO DS-QUEUE-COUNT
    GOBACK.
END PROGRAM QUEUE-INIT.

*> Queue.enqueue(value): el nodo nuevo se anade tras el final.
IDENTIFICATION DIVISION.
PROGRAM-ID. QUEUE-ENQUEUE.

DATA DIVISION.
LOCAL-STORAGE SECTION.
01 LS-NEW-NODE        USAGE POINTER.

LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-VALUE           PIC S9(9).

PROCEDURE DIVISION USING DS-QUEUE LN-VALUE.
    ALLOCATE DS-NODE
    SET LS-NEW-NODE TO ADDRESS OF DS-NODE
    MOVE LN-VALUE TO DS-NODE-VALUE
    SET DS-NODE-NEXT TO NULL
    IF DS-QUEUE-REAR = NULL
        SET DS-QUEUE-FRONT TO LS-NEW-NODE
        SET DS-QUEUE-REAR TO LS-NEW-NODE
    ELSE
        *> El final anterior se enlaza con el nodo nuevo: DS-QUEUE-REAR es una
        *> copia del puntero, asi que reapuntar la vista DS-NODE no la altera.
        SET ADDRESS OF DS-NODE TO DS-QUEUE-REAR
        SET DS-NODE-NEXT TO LS-NEW-NODE
        SET DS-QUEUE-REAR TO LS-NEW-NODE
    END-IF
    ADD 1 TO DS-QUEUE-COUNT
    GOBACK.
END PROGRAM QUEUE-ENQUEUE.

*> Queue.dequeue(): extrae el frente y devuelve su valor, o fallo si esta vacia.
IDENTIFICATION DIVISION.
PROGRAM-ID. QUEUE-DEQUEUE.

DATA DIVISION.
LOCAL-STORAGE SECTION.
01 LS-FRONT-NODE      USAGE POINTER.

LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-RESULT          PIC S9(9).

PROCEDURE DIVISION USING DS-QUEUE LN-RESULT.
    IF DS-QUEUE-FRONT = NULL
        MOVE DS-FAILURE-VALUE TO LN-RESULT
    ELSE
        SET LS-FRONT-NODE TO DS-QUEUE-FRONT
        SET ADDRESS OF DS-NODE TO LS-FRONT-NODE
        MOVE DS-NODE-VALUE TO LN-RESULT
        SET DS-QUEUE-FRONT TO DS-NODE-NEXT
        SUBTRACT 1 FROM DS-QUEUE-COUNT
        IF DS-QUEUE-FRONT = NULL
            SET DS-QUEUE-REAR TO NULL
        END-IF
        *> La vista sigue apuntando al nodo extraido: se libera aqui.
        FREE DS-NODE
    END-IF
    GOBACK.
END PROGRAM QUEUE-DEQUEUE.

*> Queue.peek(): observa el frente sin extraerlo, o fallo si esta vacia.
IDENTIFICATION DIVISION.
PROGRAM-ID. QUEUE-PEEK.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-RESULT          PIC S9(9).

PROCEDURE DIVISION USING DS-QUEUE LN-RESULT.
    IF DS-QUEUE-FRONT = NULL
        MOVE DS-FAILURE-VALUE TO LN-RESULT
    ELSE
        SET ADDRESS OF DS-NODE TO DS-QUEUE-FRONT
        MOVE DS-NODE-VALUE TO LN-RESULT
    END-IF
    GOBACK.
END PROGRAM QUEUE-PEEK.

*> Queue.is-empty(): verdadero solo si no hay nodos.
IDENTIFICATION DIVISION.
PROGRAM-ID. QUEUE-IS-EMPTY.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-RESULT          PIC 9.

PROCEDURE DIVISION USING DS-QUEUE LN-RESULT.
    IF DS-QUEUE-FRONT = NULL
        MOVE 1 TO LN-RESULT
    ELSE
        MOVE 0 TO LN-RESULT
    END-IF
    GOBACK.
END PROGRAM QUEUE-IS-EMPTY.

*> Queue.size(): numero de elementos desde init.
IDENTIFICATION DIVISION.
PROGRAM-ID. QUEUE-SIZE.

DATA DIVISION.
LINKAGE SECTION.
COPY "DATA-STRUCTURES-PARAMS".
01 LN-RESULT          PIC 9(9).

PROCEDURE DIVISION USING DS-QUEUE LN-RESULT.
    MOVE DS-QUEUE-COUNT TO LN-RESULT
    GOBACK.
END PROGRAM QUEUE-SIZE.
