*> DATA-STRUCTURES-PARAMS.cpy
*> Tipos de dominio compartidos por los subprogramas de DATA-STRUCTURES.
*>
*> El nodo vive en memoria dinamica: las estructuras guardan solo su direccion
*> (USAGE POINTER) y cada subprograma que toca sus campos superpone DS-NODE a
*> esa direccion con SET ADDRESS OF. DS-NODE lleva BASED porque no ocupa
*> almacenamiento propio: su tamano lo usa ALLOCATE para reservar el bloque.

78 DS-FAILURE-VALUE      VALUE -1.

01 DS-NODE BASED.
   05 DS-NODE-VALUE      PIC S9(9).
   05 DS-NODE-NEXT       USAGE POINTER.

01 DS-LINKED-LIST.
   05 DS-LIST-HEAD       USAGE POINTER.
   05 DS-LIST-TAIL       USAGE POINTER.
   05 DS-LIST-COUNT      PIC 9(9).

01 DS-STACK.
   05 DS-STACK-TOP       USAGE POINTER.
   05 DS-STACK-COUNT     PIC 9(9).

01 DS-QUEUE.
   05 DS-QUEUE-FRONT     USAGE POINTER.
   05 DS-QUEUE-REAR      USAGE POINTER.
   05 DS-QUEUE-COUNT     PIC 9(9).
