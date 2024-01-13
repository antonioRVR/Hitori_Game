;;; IC: Trabajo (2022/2023)
;;; Resolución deductiva del puzle Hitori
;;; Departamento de Ciencias de la Computación e Inteligencia Artificial 
;;; Universidad de Sevilla
;;;============================================================================
;[1-34] perfectos 

;fallos regla suprema en 
;35
;40
;41
;42
;45
;49
;50




;;;============================================================================
;;; Introducción
;;;============================================================================

;;;   Hitori es uno de los pasatiempos lógicos popularizados por la revista
;;; japonesa Nikoli. El objetivo del juego consiste en, dada una cuadrícula
;;; con cifras, determinar cuales hay que quitar para conseguir que no haya
;;; elementos repetidos ni en las filas ni en las columnas. También hay otras
;;; restricciones sobre la forma en que se puede eliminar estos elementos y las
;;; veremos un poco más adelante.
;;;
;;;   En concreto vamos a considerar cuadrículas de tamaño 9x9 con cifras del 1
;;; al 9 como la siguiente:
;;;
;;;                  ╔═══╤═══╤═══╤═══╤═══╤═══╤═══╤═══╤═══╗
;;;                  ║ 2 │ 9 │ 8 │ 7 │ 4 │ 6 │ 4 │ 7 │ 6 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 7 │ 4 │ 9 │ 2 │ 8 │ 3 │ 4 │ 3 │ 5 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 4 │ 7 │ 5 │ 3 │ 6 │ 5 │ 6 │ 6 │ 5 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 6 │ 1 │ 3 │ 7 │ 6 │ 9 │ 7 │ 2 │ 4 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 1 │ 3 │ 3 │ 7 │ 2 │ 8 │ 6 │ 5 │ 1 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 9 │ 8 │ 6 │ 2 │ 3 │ 8 │ 5 │ 5 │ 2 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 8 │ 4 │ 7 │ 9 │ 3 │ 3 │ 2 │ 1 │ 6 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 6 │ 2 │ 4 │ 1 │ 7 │ 4 │ 4 │ 9 │ 3 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 8 │ 4 │ 1 │ 3 │ 5 │ 1 │ 9 │ 8 │ 1 ║
;;;                  ╚═══╧═══╧═══╧═══╧═══╧═══╧═══╧═══╧═══╝
;;;
;;;   El puzle resuelto es el siguiente:
;;;
;;;                  ╔═══╤═══╤═══╤═══╤═══╤═══╤═══╤═══╤═══╗
;;;                  ║ 2 │ 9 │ 8 │▓▓▓│ 4 │ 6 │▓▓▓│ 7 │▓▓▓║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 7 │▓▓▓│ 9 │ 2 │ 8 │▓▓▓│ 4 │ 3 │ 5 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 4 │ 7 │▓▓▓│ 3 │▓▓▓│ 5 │▓▓▓│ 6 │▓▓▓║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║▓▓▓│ 1 │ 3 │▓▓▓│ 6 │ 9 │ 7 │ 2 │ 4 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 1 │ 3 │▓▓▓│ 7 │ 2 │ 8 │ 6 │ 5 │▓▓▓║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 9 │ 8 │ 6 │▓▓▓│ 3 │▓▓▓│ 5 │▓▓▓│ 2 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 8 │▓▓▓│ 7 │ 9 │▓▓▓│ 3 │ 2 │ 1 │ 6 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║ 6 │ 2 │▓▓▓│ 1 │ 7 │ 4 │▓▓▓│ 9 │ 3 ║
;;;                  ╟───┼───┼───┼───┼───┼───┼───┼───┼───╢
;;;                  ║▓▓▓│ 4 │ 1 │▓▓▓│ 5 │▓▓▓│ 9 │ 8 │▓▓▓║
;;;                  ╚═══╧═══╧═══╧═══╧═══╧═══╧═══╧═══╧═══╝
;;;
;;;   Se deben cumplir dos restricciones adicionales sobre los elementos
;;; eliminados:
;;; 1) No pueden eliminarse elementos en celdas colindantes horizontal o
;;;    verticalmente. 
;;; 2) Todas las celdas cuyo valor se mantiene deben formar una única
;;;    componente conectada horizontal o verticalmente
;;;
;;;   La primera restricción impide que se puedan hacer cosas como esta:
;;;
;;;                  ┼───┼───┼───┼───┼
;;;                  │ 3 │▓▓▓│▓▓▓│ 6 │
;;;                  ┼───┼───┼───┼───┼
;;;
;;;   La segunda restricción impide que se puedan hacer cosas como esta:
;;;
;;;                  ┼───┼───┼───┼
;;;                  │ 3 │▓▓▓│ 7 │
;;;                  ┼───┼───┼───┼
;;;                  │▓▓▓│ 3 │▓▓▓│
;;;                  ┼───┼───┼───┼
;;;                  │ 9 │▓▓▓│ 3 │
;;;                  ┼───┼───┼───┼
;;;
;;;   También es importante tener en cuenta que el puzle tiene solución única,
;;; algo que puede ayudar a obtener dicha solución.
;;;
;;;   Para ello se proporciona un fichero de ejemplos que contiene 50 puzles
;;; Hitori con solución única de tamaño 9x9 representados como una única línea
;;; en la que también se indica la solución. Si se transcribe esta línea 
;;; separando las 9 filas tendríamos lo siguiente:
;;;
;;;     w2 w9 w8 b7 w4 w6 b4 w7 b6 
;;;     w7 b4 w9 w2 w8 b3 w4 w3 w5 
;;;     w4 w7 b5 w3 b6 w5 b6 w6 b5 
;;;     b6 w1 w3 b7 w6 w9 w7 w2 w4 
;;;     w1 w3 b3 w7 w2 w8 w6 w5 b1 
;;;     w9 w8 w6 b2 w3 b8 w5 b5 w2 
;;;     w8 b4 w7 w9 b3 w3 w2 w1 w6 
;;;     w6 w2 b4 w1 w7 w4 b4 w9 w3 
;;;     b8 w4 w1 b3 w5 b1 w9 w8 b1 
;;;
;;; donde cada número se corresponde con la cifra que originalmente hay en cada
;;; celda y las letras w y b representan si en la solución dicho número se
;;; mantiene (w) o se elimina (b).

;;;============================================================================
;;; Representación del Hitori
;;;============================================================================

;;;   Utilizaremos la siguiente plantilla para representar las celdas del
;;; Hitori. Cada celda tiene los siguientes campos:
;;; - fila: Número de fila en la que se encuentra la celda
;;; - columna: Número de columna en la que se encuentra la celda
;;; - valor: Valor numérico de la celda
;;; - estado: Estado de la celda. Puede ser 'desconocido', que indica que
;;;   todavía no se ha tomado ninguna decisión sobre la celda; 'asignado', que
;;;   incida que el valor de la celda se mantiene en la solución; y
;;;   'eliminado', que indica que el valor de la celda es eliminado en la
;;;   solución. El valor por defecto es 'desconocido'.


(deftemplate celda
  (slot fila)
  (slot columna)
  (slot valor)
  (slot estado
	(allowed-values desconocido asignado eliminado)
	(default desconocido))
  (slot caracteristica
  (allowed-values isla continente capital agua candidata usada)
  (default isla))
  )


  
;;;============================================================================
;;; Funcionalidad para leer los puzles del fichero de ejemplos
;;;============================================================================

;;; Esta función construye los hechos que describen un puzle a partir de una
;;; línea leida del fichero de ejemplos.

(deffunction procesa-datos-ejemplo (?datos)
  (loop-for-count
   (?i 1 9)
   (loop-for-count
    (?j 1 9)
    (bind ?s1 (* 2 (+ ?j (* 9 (- ?i 1)))))
    (bind ?v (sub-string ?s1 ?s1 ?datos))
    (assert (celda (fila ?i) (columna ?j) (valor ?v))))))

;;;   Esta función localiza el puzle que se quiere resolver en el fichero de
;;; ejemplos. 

(deffunction lee-puzle (?n)
  (open "C:\\Users\\Anthony\\Desktop\\estudios\\MULCIA\\IngenieriaDelConocimiento\\Trabajo\\ejemplos.txt" data "r")
  (loop-for-count (?i 1 (- ?n 1))
                  (readline data))
  (bind ?datos (readline data))
  (reset)
  (procesa-datos-ejemplo ?datos)
  (run)
  (close data))

;;;   Esta función comprueba todos los puzles de un fichero que se pasa como
;;; argumento. Se usa:
;;; CLIPS> (procesa-ejemplos)

(deffunction procesa-ejemplos ()
  (open "C:\\Users\\Anthony\\Desktop\\estudios\\MULCIA\\IngenieriaDelConocimiento\\Trabajo\\ejemplos.txt" data "r")
  (bind ?datos (readline data))
  (bind ?i 1)
  (while (neq ?datos EOF)
   (reset)
   (procesa-datos-ejemplo ?datos)
   (printout t "C:\\Users\\Anthony\\Desktop\\estudios\\MULCIA\\IngenieriaDelConocimiento\\Trabajo\\ejemplos.txt :" ?i crlf)
   (run)
   (bind ?datos (readline data))
   (bind ?i (+ ?i 1)))
  (close data))

;;;============================================================================


;;;============================================================================
;;; Estrategias de resolución
;;;============================================================================

;;;   El objetivo de este trabajo es implementar un programa CLIPS que resuelva
;;; un Hitori de forma deductiva, es decir, deduciendo si el número de una
;;; celda debe eliminarse o debe mantenerse a partir de reglas que analicen los
;;; valores y situaciones de las celdas relacionadas.

;Parte 0. Estrategia de fijación de valores, estrategia del primo y del hermano y 
;estrategia del

(deffacts fase-inicial
  (fase basica))


;;;----------------------------------------------------------------------------
;;; 1) Estrategia de fijación de valores (básica)
;;;----------------------------------------------------------------------------
;si una casilla (i) no tiene su valor repetido ni en su fila ni en su columna
;pasa a tener estado "asignado". Es decir, no puede estar el mismo valor ni asignado o 
; desconocido

(defrule fijacion
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (valor ?v) (estado desconocido))
  (not(celda (fila ?f2&~?f1) (columna ?c1) (valor ?v) (estado desconocido)))
  (not (celda (fila ?f1) (columna ?c2&~?c1) (valor ?v) (estado desconocido)))
  (not(celda (fila ?f2&~?f1) (columna ?c1) (valor ?v) (estado asignado)))
  (not (celda (fila ?f1) (columna ?c2&~?c1) (valor ?v) (estado asignado)))  
  =>
  (modify ?h1 (estado asignado)))



;;;----------------------------------------------------------------------------
;;; 2) Estrategia del hermano y el primo (fase basica)
;;;----------------------------------------------------------------------------

;si en una unidad (fila o columna) hay 3 valores repetidos, y dos de ellos,
;estan en celdas colindantes y el tercero está separado de los otros 2, este
;ultimo que está separado pasa a tener estado eliminado y los otros 2 se
;mantienen en desconocido


(defrule hermano-primo-fila
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (valor ?v) (estado desconocido))
  ?h2 <- (celda (fila ?f1) (columna ?c2&~?c1) (valor ?v))
  (exists (celda (fila ?f1) (columna ?c3&:(!= ?c3 ?c2)&:(!= ?c3 ?c1)) (valor ?v))
          (test(or (= ?c3 (+ ?c2 1)) (= ?c3 (- ?c2 1)) )))
  =>
  (modify ?h1 (estado eliminado)))

(defrule hermano-primo-columna
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (valor ?v) (estado desconocido))
  ?h2 <- (celda (fila ?f2&~?f1) (columna ?c1) (valor ?v))
  (exists (celda (fila ?f3&:(!= ?f3 ?f2)&:(!= ?f3 ?f1)) (columna ?c1) (valor ?v))
          (test(or (= ?f3 (+ ?f2 1)) (= ?f3 (- ?f2 1)) )))
  =>
  (modify ?h1 (estado eliminado)))
;Antes funcionaba mal. En la nueva version fuerzo que la tercera columna no pueda ser tampoco C1
; porque entonces te obliga a coger una columna ?c2 que no sea ?c1 (puede estar a su lado) y luego
; te dice que si existe una al lado de esta se elimina ?c1
; FUnciona por primera vez en puzle 3

;;;----------------------------------------------------------------------------
;;; 3) Estrategia de separación (fase basica)
;;;----------------------------------------------------------------------------

; si la casilla (i) tiene una casilla (j) eliminada justo a su lado, (i) pasa
; a estar asignada


(defrule separacion-fila
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (valor ?v) (estado desconocido))
  (exists (celda (fila ?f1) (columna ?c2) (estado eliminado)) 
          (test (or (= ?c2 (+ ?c1 1)) (= ?c2 (- ?c1 1)) )))
  =>
  (modify ?h1 (estado asignado)))

(defrule separacion-columna
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (valor ?v) (estado desconocido))
  (exists (celda (fila ?f2) (columna ?c1) (estado eliminado)) 
          (test (or (= ?f2 (+ ?f1 1)) (= ?f2 (- ?f1 1)) )))
  =>
  (modify ?h1 (estado asignado)))

;;;----------------------------------------------------------------------------
;;; 4) Estrategia de eliminacion por plaza ocupada(fase basica)
;;;----------------------------------------------------------------------------

;Si una celda (i) con valor (u)(desconocido) tiene el mismo valor en su misma 
;unidad con estado (asignado). la celda (i) se elimina
;repetir para filas y columnas

(defrule plaza-ocupada-fila
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (valor ?v) (estado desconocido))
  ?h2 <- (celda (fila ?f1) (columna ?c2&~?c1) (valor ?v) (estado asignado))
  =>
  (modify ?h1 (estado eliminado)))

(defrule plaza-ocupada-columna
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (valor ?v) (estado desconocido))
  ?h2 <- (celda (fila ?f2&~?f1) (columna ?c1) (valor ?v) (estado asignado))
  =>
  (modify ?h1 (estado eliminado)))


;;;----------------------------------------------------------------------------
;;; 5) Estrategia anti-rombos
;;;----------------------------------------------------------------------------

;si hay 4 casillas tal que 3 están eliminadas, y la 4 está desconocida
;si al elimianr la celda 4 se forma un rombo de eliminados, la celda 4 pasa 
; a tener estado asignado para evitar la segunda restricción explicada en 
; el enunciado del trabajo

(defrule anti-rombos-fila
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (valor ?v) (estado desconocido))
  (exists (celda (fila ?f1) (columna ?c2) (estado eliminado)) 
          (celda (fila ?f2) (columna ?c3) (estado eliminado))
          (celda (fila ?f3) (columna ?c3) (estado eliminado))
          (test (or 
                (and(= ?c2 (+ ?c1 2)) (= ?f2 (+ ?f1 1))(= ?f3 (- ?f1 1)) (= ?c3 (+ ?c1 1))) 
                (and(= ?c2 (- ?c1 2)) (= ?f2 (+ ?f1 1))(= ?f3 (- ?f1 1)) (= ?c3 (- ?c1 1))))))
  =>
  (modify ?h1 (estado asignado)))
;hasta aquí sigue funcionando

(defrule anti-rombos-columna
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (valor ?v) (estado desconocido))
  (exists (celda (fila ?f2) (columna ?c1) (estado eliminado)) 
          (celda (fila ?f3) (columna ?c2) (estado eliminado))
          (celda (fila ?f3) (columna ?c3) (estado eliminado))
          (test (or 
                (and(= ?f2 (+ ?f1 2)) (= ?c2 (+ ?c1 1))(= ?c3 (- ?c1 1)) (= ?f3 (+ ?f1 1))) 
                (and(= ?f2 (- ?f1 2)) (= ?c2 (+ ?c1 1))(= ?c3 (- ?c1 1)) (= ?f3 (- ?f1 1))))))
  =>
  (modify ?h1 (estado asignado)))

;;;----------------------------------------------------------------------------
;;; 6) Estrategia anti-rombos-bordes
;;;----------------------------------------------------------------------------
;similar a estrategia anti-rombos pero actuando en las paredes del puzle

(defrule anti-rombos-techo-generica
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (valor ?v) (estado desconocido))
  (exists (celda (fila ?f2) (columna ?c2) (estado eliminado)) 
          (celda (fila ?f3) (columna ?c3) (estado eliminado))
          (test 
                ;techo
                (or 
                (and (= ?f1 1) (= ?f2 (+ ?f1 1)) (= ?f3 ?f1) (= ?c2 (+ ?c1 1)) (= ?c3 (+ ?c1 2)))
                (and (= ?f1 1) (= ?f2 (+ ?f1 1)) (= ?f3 ?f1) (= ?c2 (- ?c1 1)) (= ?c3 (- ?c1 2)))
                (and (= ?f1 2) (= ?f2 (- ?f1 1)) (= ?f3 ?f2)(= ?c2 (- ?c1 1)) (= ?c3 (+ ?c1 1))) 
                ;suelo
                (and (= ?f1 9) (= ?f2 (- ?f1 1)) (= ?f3 ?f1) (= ?c2 (+ ?c1 1)) (= ?c3 (+ ?c1 2)))
                (and (= ?f1 9) (= ?f2 (- ?f1 1)) (= ?f3 ?f1) (= ?c2 (- ?c1 1)) (= ?c3 (- ?c1 2)))
                (and (= ?f1 8) (= ?f2 (+ ?f1 1)) (= ?f3 ?f2)(= ?c2 (- ?c1 1)) (= ?c3 (+ ?c1 1))) 
                ;pared izquierda
                (and (= ?c1 1) (= ?c2 (+ ?c1 1)) (= ?c3 ?c1) (= ?f2 (+ ?f1 1)) (= ?f3 (+ ?f1 2)))
                (and (= ?c1 1) (= ?c2 (+ ?c1 1)) (= ?c3 ?c1) (= ?f2 (- ?f1 1)) (= ?f3 (- ?f1 2)))
                (and (= ?c1 2) (= ?c2 (- ?c1 1)) (= ?c3 ?c2)(= ?f2 (- ?f1 1)) (= ?f3 (+ ?f1 1))) 
                ;pared derecha
                (and (= ?c1 9) (= ?c2 (- ?c1 1)) (= ?c3 ?c1) (= ?f2 (+ ?f1 1)) (= ?f3 (+ ?f1 2)))
                (and (= ?c1 9) (= ?c2 (- ?c1 1)) (= ?c3 ?c1) (= ?f2 (- ?f1 1)) (= ?f3 (- ?f1 2)))
                (and (= ?c1 8) (= ?c2 (+ ?c1 1)) (= ?c3 ?c2)(= ?f2 (- ?f1 1)) (= ?f3 (+ ?f1 1))))))
  =>
  (modify ?h1 (estado asignado)))

;;;----------------------------------------------------------------------------
;;; 7) Estrategia del medio
;;;----------------------------------------------------------------------------

;si una casilla tiene a sus dos lados el mismo valor (a). Esta casilla pasa a 
;tener estado "asignado"

(defrule el-del-medio-fila
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (estado desconocido))
  (exists (celda (fila ?f1)  (columna ?c2) (valor ?v))
          (celda (fila ?f1)  (columna ?c3) (valor ?v))
          (test (and (= ?c2 (+ ?c1 1) ) (= ?c3 (- ?c1 1)))))
 =>
 (modify ?h1 (estado asignado)))

(defrule el-del-medio-columna
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (estado desconocido))
  (exists (celda (fila ?f2)  (columna ?c1) (valor ?v))
          (celda (fila ?f3)  (columna ?c1) (valor ?v))
          (test (and (= ?f2 (+ ?f1 1) ) (= ?f3 (- ?f1 1)))))
 =>
 (modify ?h1 (estado asignado)))

;;;----------------------------------------------------------------------------
;;; 8) Estrategia primo-anti-rombos
;;;----------------------------------------------------------------------------

;Si hay un par de valores (u) en casillas (i) (j) separados por una casilla (k)
;y esta casilla (k) tiene una eliminada arriba y abajo o a la izquierda y derecha.
;segun nos fijemos en columnas o filas. Las demas casillas de la fila o columna de 
;(i) y (j) con el mismo valor (u) deben ser eliminadas.
;esto asegura que al menos una de las casillas (i) (j) permanezca y no se creen
;rombos 

(defrule primo-anti-rombos-fila
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1))
  (celda (fila ?f1)  (columna ?c2&:(= ?c2 (+ ?c1 1))) (valor ?v))
  (celda (fila ?f1)  (columna ?c3&:(= ?c3 (- ?c1 1))) (valor ?v))
  ?h2 <- (celda (fila ?f1) (columna ?cx&~?c1&~?c2&~?c3) (valor ?v) (estado desconocido))
  (exists (celda (fila ?f2&=(+ 1 ?f1)) (columna ?c1) (estado eliminado))
          (celda (fila ?f3&=(- 1 ?f1)) (columna ?c1) (estado eliminado)))
  =>
  (modify ?h2 (estado eliminado)))

(defrule primo-anti-rombos-columna
(fase basica)
  ?h1 <- (celda (fila ?f1) (columna ?c1))
  (celda (fila ?f2&:(= ?f2 (+ ?f1 1))) (columna ?c1) (valor ?v))
  (celda  (fila ?f3&:(= ?f3 (- ?f1 1))) (columna ?c1)  (valor ?v))
  ?h2 <- (celda  (fila ?fx&~?f1&~?f2&~?f3) (columna ?c1)(valor ?v) (estado desconocido))
  (exists (celda (fila ?f1)(columna ?c2&=(+ 1 ?c1))  (estado eliminado))
          (celda (fila ?f1) (columna ?c3&=(- 1 ?c1)) (estado eliminado)))
  =>
  (modify ?h2 (estado eliminado)))

;;;----------------------------------------------------------------------------
;;; 9) Estrategia anti triangulos en esquinas
;;;----------------------------------------------------------------------------

;si una esquina tiene valor asignado y a su lado tiene valor eliminado, el otro
;de sus lados debe ser valor asignado para evitar que se forme un triangulo aislado
;comprobar en puzzle 13 arriba a la derecha y en puzle 25 en las dos esquinas inferiores

(defrule anti-triangulos-esquinas
(fase basica)
?h1 <- (celda (fila ?f1) (columna ?c1) (estado desconocido))
(exists(celda (fila ?f2) (columna ?c2) (estado asignado))
       (celda (fila ?f3&~?f1) (columna ?c3&~?c1) (estado eliminado))
  (test (or 
        ;cada esquina tiene dos situaciones en funcion de si la casilla eliminada está 
        ;en la fila o en la columna
          ;primera esquina
          (and (= ?f2 1) (= ?c2 1);(= ?c1 1) 
               (or(and(= ?c1 (+ ?c2 1))(= ?f1 ?f2)(= ?f3 (+ ?f2 1))(= ?c3 ?c2))
                  (and(= ?c3 (+ ?c2 1))(= ?f3 ?f2)(= ?f1 (+ ?f2 1))(= ?c1 ?c2))))
          ;segunda esquina
          (and (= ?f2 1) (= ?c2 9);(= ?c1 9) 
               (or(and(= ?c1 (- ?c2 1))(= ?f1 ?f2)(= ?f3 (+ ?f2 1))(= ?c3 ?c2))
                  (and(= ?c3 (- ?c2 1))(= ?f3 ?f2)(= ?f1 (+ ?f2 1))(= ?c1 ?c2))))
          ;tercera esquina
          (and (= ?f2 9) (= ?c2 1);(= ?c1 9) 
               (or(and(= ?c1 (+ ?c2 1))(= ?f1 ?f2)(= ?f3 (- ?f2 1))(= ?c3 ?c2))
                  (and(= ?c3 (+ ?c2 1))(= ?f3 ?f2)(= ?f1 (- ?f2 1))(= ?c1 ?c2))))
          ;cuarta esquina
          (and (= ?f2 9) (= ?c2 9);(= ?c1 9) 
               (or(and(= ?c1 (- ?c2 1))(= ?f1 ?f2)(= ?f3 (- ?f2 1))(= ?c3 ?c2))
                  (and(= ?c3 (- ?c2 1))(= ?f3 ?f2)(= ?f1 (- ?f2 1))(= ?c1 ?c2)))))))
=>
(modify ?h1 (estado asignado)))

;;;----------------------------------------------------------------------------
;;; 10) esquinas de numeros
;;;----------------------------------------------------------------------------
;si en una esquina del tablero se forma otra esquina con 3 numeros iguales, 
;la casilla que hace esquina se elimna, para todas las esquinas.
;cada esquina tiene dos situaciones. por ejemplo en la superior izquierda
; si los numeros repetidos estan en (1 2) (2 1) y (2 2), se tiene que eliminar
;la casilla (2,2) ya que si se eliminara cualquier otra la (2 2) deberia fijarse
;obligando a las otras a eliminarse y formar un recinto aislado en esa esquina
;comprobar en esquina inferior derecha del puzle 49, para numero 9


(defrule anti-esquinas-de-numeros-en-esquinas
(fase basica)
?h1 <- (celda (fila ?f1) (columna ?c1) (valor ?v) (estado desconocido))
  (celda (fila ?f2) (columna ?c2) (valor ?v) (estado desconocido))
  (celda (fila ?f3) (columna ?c3) (valor ?v) (estado desconocido))
  (test (or 
          ;primera esquina
          (and (= ?f1 1) (= ?c1 1) (= ?f2 2) (= ?c2 1)(= ?f3 1 )(= ?c3 2))
          (and (= ?f1 2) (= ?c1 2) (= ?f2 2) (= ?c2 1)(= ?f3 1 )(= ?c3 2))
          ;segunda esquina
          (and (= ?f1 1) (= ?c1 9) (= ?f2 1) (= ?c2 8)(= ?f3 2 )(= ?c3 9))
          (and (= ?f1 2) (= ?c1 8) (= ?f2 1) (= ?c2 8)(= ?f3 2 )(= ?c3 9))
          ;tercera esquina
          (and (= ?f1 9) (= ?c1 1) (= ?f2 8) (= ?c2 1)(= ?f3 9 )(= ?c3 2))
          (and (= ?f1 8) (= ?c1 2) (= ?f2 8) (= ?c2 1)(= ?f3 9 )(= ?c3 2))
          ;cuarta esquina
          (and (= ?f1 9) (= ?c1 9) (= ?f2 9) (= ?c2 8)(= ?f3 8 )(= ?c3 9))
          (and (= ?f1 8) (= ?c1 8) (= ?f2 9) (= ?c2 8)(= ?f3 8 )(= ?c3 9))))
=>
(modify ?h1 (estado eliminado)))

;;;----------------------------------------------------------------------------
;;; 11) esquinas de numeros parte 2
;;;----------------------------------------------------------------------------
;lo mismo que la regla 10, pero si uno de los numeros es distinto, este se debe
;de asignar ya que sino produciria o bien dos eliminados juntos o bien un recinto
;sin embargo esto no pasaria, siguiendo el ejemplo anterior, si el numero
;diferente estuviera en la casilla (2 2) o (1 1)
;comprobar en puzle 39 esquina superior derecha los numeros 2 y 4
; puzle 39 esquina inferior izquierda numeros 3 y 1

(defrule anti-esquinas-de-numeros-en-esquinas-parte-2
(fase basica)
    (celda (fila ?f1) (columna ?c1) (valor ?u) (estado desconocido))
    (celda (fila ?f2) (columna ?c2) (valor ?u) (estado desconocido))
?h2 <- (celda (fila ?f3) (columna ?c3) (valor ?v&~?u) (estado desconocido))
  (test (or 
          ;primera esquina
          (and (= ?f1 1) (= ?c1 1) (= ?f2 2) (= ?c2 1)(= ?f3 1 )(= ?c3 2))
          (and (= ?f1 2) (= ?c1 2) (= ?f2 2) (= ?c2 1)(= ?f3 1 )(= ?c3 2))
          (and (= ?f1 1) (= ?c1 1) (= ?f2 2) (= ?c2 2)(= ?f3 2 )(= ?c3 1))
          (and (= ?f1 2) (= ?c1 2) (= ?f2 1) (= ?c2 2)(= ?f3 2 )(= ?c3 1))
          ;segunda esquina
          (and (= ?f1 1) (= ?c1 9) (= ?f2 1) (= ?c2 8)(= ?f3 2 )(= ?c3 9))
          (and (= ?f1 2) (= ?c1 8) (= ?f2 1) (= ?c2 8)(= ?f3 2 )(= ?c3 9))
          (and (= ?f1 1) (= ?c1 9) (= ?f2 2) (= ?c2 9)(= ?f3 1 )(= ?c3 8))
          (and (= ?f1 2) (= ?c1 8) (= ?f2 2) (= ?c2 9)(= ?f3 1 )(= ?c3 8))
          ;tercera esquina
          (and (= ?f1 9) (= ?c1 1) (= ?f2 8) (= ?c2 1)(= ?f3 9 )(= ?c3 2))
          (and (= ?f1 8) (= ?c1 2) (= ?f2 8) (= ?c2 1)(= ?f3 9 )(= ?c3 2))
          (and (= ?f1 9) (= ?c1 1) (= ?f2 9) (= ?c2 2)(= ?f3 8 )(= ?c3 1))
          (and (= ?f1 8) (= ?c1 2) (= ?f2 9) (= ?c2 2)(= ?f3 8 )(= ?c3 1))
          ;cuarta esquina
          (and (= ?f1 9) (= ?c1 9) (= ?f2 9) (= ?c2 8)(= ?f3 8 )(= ?c3 9))
          (and (= ?f1 8) (= ?c1 8) (= ?f2 9) (= ?c2 8)(= ?f3 8 )(= ?c3 9))
          (and (= ?f1 9) (= ?c1 9) (= ?f2 8) (= ?c2 9)(= ?f3 9 )(= ?c3 8))
          (and (= ?f1 8) (= ?c1 8) (= ?f2 8) (= ?c2 9)(= ?f3 9 )(= ?c3 8))))
=>
(modify ?h2 (estado asignado)))


;;;----------------------------------------------------------------------------
;;; 12) Par imposible 
;;;----------------------------------------------------------------------------
;si hay 4 casillas con dos valores a y b tal que
; a para (x,y) (x+n,y)
; b para (x,y+1) (x+n+1,y+1)
;entonces se asignan las casillas (x+n+1,y) y (x+n,y+1)
;8 posibilidades, 2 para cada orientacion del tablero

(defrule Par-imposible-vertical-1
(fase basica)
(celda (fila ?f1) (columna ?c1) (valor ?u) )
(celda (fila ?f1) (columna ?c2&:(= ?c2 (+ ?c1 1))) (valor ?v&~?u))
(celda (fila ?f2&~?f1) (columna ?c1) (valor ?u))
(celda (fila ?f3&:(= ?f3 (+ ?f2 1))&~?f1) (columna ?c2) (valor ?v) ) 
?h <- (celda (fila ?f4) (columna ?c4) (estado desconocido))
(test (or (and (= ?f4 ?f3 ) (= ?c4 ?c1 ))
          (and (= ?f4 ?f2 ) (= ?c4 ?c2))))
=>
(modify ?h (estado asignado)))


(defrule Par-imposible-vertical-2
(fase basica)
(celda (fila ?f1) (columna ?c1) (valor ?u) )
(celda (fila ?f1) (columna ?c2&:(= ?c2 (+ ?c1 1))) (valor ?v&~?u))
(celda (fila ?f2&~?f1) (columna ?c1) (valor ?u))
(celda (fila ?f3&:(= ?f3 (- ?f2 1))&~?f1) (columna ?c2) (valor ?v) ) 
?h <- (celda (fila ?f4) (columna ?c4) (estado desconocido))
(test (or (and (= ?f4 ?f3 ) (= ?c4 ?c1 ) )
          (and (= ?f4 ?f2 ) (= ?c4 ?c2) )))
=>
(modify ?h (estado asignado))) 

(defrule Par-imposible-horizontal-1
(fase basica)
(celda (columna ?f1) (fila ?c1) (valor ?u) )
(celda (columna ?f1) (fila ?c2&:(= ?c2 (+ ?c1 1))) (valor ?v&~?u))
(celda (columna ?f2&~?f1) (fila ?c1) (valor ?u))
(celda (columna ?f3&:(= ?f3 (+ ?f2 1))&~?f1) (fila ?c2) (valor ?v) ) 
?h <- (celda (columna ?f4) (fila ?c4) (estado desconocido))
(test (or (and (= ?f4 ?f3 ) (= ?c4 ?c1 ) )
          (and (= ?f4 ?f2 ) (= ?c4 ?c2) )))
=>
(modify ?h (estado asignado)))

(defrule Par-imposible-horizontal-2
(fase basica)
(celda (columna ?f1) (fila ?c1) (valor ?u) )
(celda (columna ?f1) (fila ?c2&:(= ?c2 (+ ?c1 1))) (valor ?v&~?u))
(celda (columna ?f2&~?f1) (fila ?c1) (valor ?u))
(celda (columna ?f3&:(= ?f3 (- ?f2 1))&~?f1) (fila ?c2) (valor ?v) ) 
?h <- (celda (columna ?f4) (fila ?c4) (estado desconocido))
(test (or (and (= ?f4 ?f3 ) (= ?c4 ?c1 ) )
          (and (= ?f4 ?f2 ) (= ?c4 ?c2) )))
=>
(modify ?h (estado asignado)))



;;;----------------------------------------------------------------------------
;;; ###) FINAL FASE BASICA
;;;----------------------------------------------------------------------------

(defrule final-fase-basica
(declare (salience -5))
  ?fase <- (fase basica)
  =>
  (retract ?fase)
  (assert (fase avanzada_1)))


;;;----------------------------------------------------------------------------
;;; ###) AVANZADO (REGLA ANTI RECINTOS) Todavia con fallos
;;;----------------------------------------------------------------------------

;;;----------------------------------------------------------------------------
;;; 1) Estrategia anti recintos (Fase avanzada)
;;;----------------------------------------------------------------------------

;si hay un valor repetido de estado desconocido tal que al eliminarse se formaria
;un recinto, su estado pasa a ser asignado. Para hacer esto debemos tener en cuenta
;que las reglas del Hitori no permiten la formación de recintos aislados, es decir,
;para que nuestra resolución sea correcta, todas las casillas deben estar conectadas
;formando un único recinto

;Se implementaran estrategias que eliminaran temporalmente un valor.
;Inicialmente todas las celdas tendrán la caracteristica isla. Se cogerá una casilla
;que será el inicio de nuestro "continente" con la caracteristica del mismo nombre
;Esta caracteristica se irá propagando por celdas de estado asignado o desconocido
;formando un continente. Si en algun momento no se puede propagar más porque hay 
;una casilla eliminada que no se puede sortear, se parará la propagación
;Si todo el puzle forma un solo continente, la casilla eliminada incialmente 
;vuelve a tener estado desconocido. Si se detecta que hay una isla, significa que esa
;casilla no puede eliminarse para permitir la propagación de nuestro continente
;y que no haya recintos cerrados/islas por lo que la casilla pasa a tener estado asignado

;Para que esta regla empieze a aplicarse, tiene que haber al menos una casilla con 
;estado eliminado en una de las esquinas de la celda candidata. Ya que si no hay ninguna
;eliminada haciendo esquina, no se va a formar un recinto. 
;añadiendo esta condición vamos a ahorrar mucho tiempo de cálculo. Evitando que se elimine y se
;apliquen las siguientes reglas a otras muchas celdas que es imposible que nos den una isla

;resume de caracteristicas
; candidata: celda propuesta a eliminación que es posible que cree recintos cerrados
; agua: celdas eliminadas
; continente: todas las celdas nos eliminadas que forman el recinto principal
; capital: celda desde donde comienza a analizarse el continente
; Isla: celdas que forman un recinto separado del principal




;;;----------------------------------------------------------------------------
;;; 2) Definición de agua y eliminación inicial
;;;----------------------------------------------------------------------------



(defrule eliminacion-candidata-inicial
  (fase avanzada_1)
  ?fase <- (fase avanzada_1)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (estado desconocido) (caracteristica isla))
  (exists(celda (fila ?f2) (columna ?c2) (estado eliminado))
          (test (or
                (and (= ?f2 (+ ?f1 1)) (= ?c2 (+ ?c1 1) ))
                (and (= ?f2 (+ ?f1 1)) (= ?c2 (- ?c1 1) ))
                (and (= ?f2 (- ?f1 1)) (= ?c2 (+ ?c1 1) ))
                (and (= ?f2 (- ?f1 1)) (= ?c2 (- ?c1 1) )))))
  (not (celda (fila ?f3) (columna ?c3) (caracteristica candidata)))
  ;Hasta aqui las candidatas las elige bien, el problema es que a veces elige candidatas con casillas eliminadas
  ;inmediatamente al lado, creando dos elimiandas juntas y esto hay que evitarlo
  (not (celda (fila ?f4&:(= ?f4 (+ ?f1 1))) (columna ?c1) (estado eliminado)))
  (not (celda (fila ?f5&:(= ?f5 (- ?f1 1))) (columna ?c1) (estado eliminado)))
  (not (celda (fila ?f1) (columna ?c4&:(= ?c4 (+ ?c1 1))) (estado eliminado)))
  (not (celda (fila ?f1) (columna ?c5&:(= ?c5 (- ?c1 1))) (estado eliminado)))
  ;la asignación inicial solo puede ser cuando los valores
  ; inmediatamente colindantes son conocidos, ya que si hay 2 desconocidos juntos puede ocasionar
  ; fallos cumplirse la regla para ambos y para el incorrecto, ocasionando que posteriormente se
  ; elimine una casilla que no deberia, ya que si la regla se activa para uno de los dos
  ; y es válida puede pasar que se elimine el otro aunque no deba creando dos casillas eliminadas
  ; juntas. 
  =>
  (modify ?h1(estado eliminado)(caracteristica candidata))
  (retract ?fase)
  (assert (fase avanzada_1_1)))



(defrule busqueda-de-agua
  (fase avanzada_1_1)
  ?fase <- (fase avanzada_1_1)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (estado eliminado) (caracteristica isla))
  ;ya que la celda candidata tambien va a ser eliminada, debemos asegurarnos de que esta regla no
  ;la coja y cambie su estado a agua, ya que posteriormente en función de si esta regla es satisfactoria
  ;o no se cambiará la celda candidata y debemos ser capaces de volver a referirnos a ella
  =>
  (modify ?h1 (caracteristica agua))
  (retract ?fase)
  (assert (fase avanzada_2)))


;;;----------------------------------------------------------------------------
;;; 3) Fundación de la capital
;;;----------------------------------------------------------------------------
;se incluye la condicion de capital para que no se creen más continentes llevando
;al engaño de que no hay islas cuando se están creando más continentes y solo puede
;haber un continente

;asi que la expansion solo puede comenzar desde la capital, Y no se fundarán más capitales
;si ya existe una

(defrule fundacion-capital
  (fase avanzada_2)
  ?fase <- (fase avanzada_2)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (estado asignado))
  (not (celda (fila ?f2) (columna ?c2) (caracteristica capital)))
  =>
  (modify ?h1 (caracteristica capital))
  (retract ?fase)
  (assert (fase avanzada_3)))

;;;----------------------------------------------------------------------------
;;; 4) Propagación
;;;----------------------------------------------------------------------------

;la capital se intenta expandir creando un continente. La expansión puede continuar
;desde la propia capital o desde celdas que se hayan integrado al continente

(defrule propagacion-capital
  (fase avanzada_3)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (estado asignado) (caracteristica isla))
  (exists(celda (fila ?f2) (columna ?c2)  (caracteristica capital))
         (test
         (or
         (and (= ?f1 (+ ?f2 1)) (= ?c2 ?c1))  
         (and (= ?f1 (- ?f2 1)) (= ?c2 ?c1))
         (and (= ?c1 (+ ?c2 1)) (= ?f2 ?f1)) 
         (and (= ?c1 (- ?c2 1)) (= ?f2 ?f1)))))       
  
  =>
  (modify ?h1 (caracteristica continente)))

(defrule propagacion-capital-desconocidos
  (fase avanzada_3)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (estado desconocido) (caracteristica isla))
  (exists(celda (fila ?f2) (columna ?c2) (caracteristica capital))
        (test
         (or
         (and (= ?f1 (+ ?f2 1)) (= ?c2 ?c1))  
         (and (= ?f1 (- ?f2 1)) (= ?c2 ?c1))
         (and (= ?c1 (+ ?c2 1)) (= ?f2 ?f1)) 
         (and (= ?c1 (- ?c2 1)) (= ?f2 ?f1)))))       
  
  =>
  (modify ?h1 (caracteristica continente)))


(defrule propagacion-continente
  (fase avanzada_3)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (estado asignado) (caracteristica isla))
  (exists(celda (fila ?f2) (columna ?c2)  (caracteristica continente))
          (test
          (or
           (and (= ?f1 (+ ?f2 1)) (= ?c2 ?c1))  
           (and (= ?f1 (- ?f2 1)) (= ?c2 ?c1))
           (and (= ?c1 (+ ?c2 1)) (= ?f2 ?f1)) 
           (and (= ?c1 (- ?c2 1)) (= ?f2 ?f1)))))       
  
  =>
  (modify ?h1 (caracteristica continente)))


(defrule propagacion-continente-desconocidos
  (fase avanzada_3)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (estado desconocido) (caracteristica isla))
  (exists(celda (fila ?f2) (columna ?c2)  (caracteristica continente))
          (test 
            (or
             (and (= ?f1 (+ ?f2 1)) (= ?c2 ?c1))  
             (and (= ?f1 (- ?f2 1)) (= ?c2 ?c1))
             (and (= ?c1 (+ ?c2 1)) (= ?f2 ?f1)) 
             (and (= ?c1 (- ?c2 1)) (= ?f2 ?f1)))))       
  =>
  (modify ?h1 (caracteristica continente)))


(defrule final-fase-avanzada
(declare (salience -6))
?fase <- (fase avanzada_3)
=>
(retract ?fase)
(assert (fase revision)))

;;;----------------------------------------------------------------------------
;;; 5) Revisión Islas continente (segunfa fase del modulo)
;;;----------------------------------------------------------------------------

(defrule revision-territorial
  (fase revision)
  ?fase <- (fase revision)
  ?h1 <- (celda (fila ?f1) (columna ?c1) (caracteristica candidata))
  (exists (celda (fila ?f2) (columna ?c2)(caracteristica isla)))
  =>
  (retract ?fase)
  (assert (fase limpieza))
  (modify ?h1 (caracteristica continente)(estado asignado)))


(defrule Inundacion
(fase limpieza)
?h1 <-(celda (fila ?f1) (columna ?c1) (caracteristica continente))
=>
(modify ?h1 (caracteristica isla)))

(defrule Inundacion-2
(fase limpieza)
?h1 <-(celda (fila ?f1) (columna ?c1) (caracteristica candidata))
=>
(modify ?h1 (caracteristica isla)))

(defrule vuelta-basico
(fase limpieza)
?fase <- (fase limpieza)
(not (celda (fila ?f1)  (columna ?c1) (caracteristica continente)))
(not (celda (fila ?f1)  (columna ?c1) (caracteristica candidata)))
=>
(retract ?fase)
(assert (fase basica)))


;;;----------------------------------------------------------------------------
;;; COMPROBACIÓN DEL PUZLE
;;;----------------------------------------------------------------------------
;regla que se ejecuta tras el dibujo del resultado, donde si detecta que en
;una fila o columna hay dos valores repetidos, el resultado obtenido es incorrecto

(defrule comprobacion-final-repetidos
  (declare (salience -12))
  ?h1 <- (celda (fila ?f1) (columna ?c1) (valor ?v) (estado asignado))
  ?h2 <- (celda (fila ?f2) (columna ?c2) (valor ?v) (estado asignado))
  (test (or (and(!= ?f2 ?f1)(= ?c2 ?c1) ) (and(!= ?c2 ?c1)(= ?f2 ?f1))))
  =>
  (printout t "Resultado Incorrecto" crlf)
  (printout t "fila: " ?f1 " columna: " ?c1 " valor: " ?v crlf )
  (printout t "fila: " ?f2 " columna: " ?c2 " valor: " ?v crlf ))

(defrule comprobacion-final-hermanos-eliminados
  (declare (salience -12))
  ?h1 <- (celda (fila ?f1) (columna ?c1) (estado eliminado))
  ?h2 <- (celda (fila ?f2) (columna ?c2) (estado eliminado))
  (test (or (and (= ?f2 (- ?f1 1))(= ?c1 ?c2)) (and(= ?f2 (+ ?f1 1))(= ?c1 ?c2))
            (and (= ?c2 (- ?c1 1))(= ?f1 ?f2)) (and(= ?c2 (+ ?c1 1))(= ?f1 ?f2))))
   =>
  (printout t "Resultado Incorrecto" crlf)
  (printout t "fila: " ?f1 " columna: " ?c1 crlf )
  (printout t "fila: " ?f2 " columna: " ?c2 crlf )
  (printout t "eliminados en casillas continuas" crlf))

(defrule comprobacion-final-incognito
  (declare (salience -12))
  ?h1 <- (celda (fila ?f1) (columna ?c1) (estado desconocido))
   =>
  (printout t "Resultado Incompleto" crlf)
  (printout t "Desconocido en:  " "fila: " ?f1 " columna: " ?c1  crlf ))
;;;============================================================================
;;; Reglas para imprimir el resultado
;;;============================================================================

;;;   Las siguientes reglas permiten visualizar el estado del hitori, una vez
;;; aplicadas todas las reglas que implementan las estrategias de resolución.
;;; La prioridad de estas reglas es -10 para que sean las últimas en aplicarse.

;;;   Para cualquier puzle se muestra a la izquierda el estado inicial del
;;; tablero y a la derecha la situación a la que se llega tras aplicar todas
;;; las estrategias de resolución. En el tablero de la derecha, las celdas que
;;; tienen un estado 'asignado' contienen el valor numérico asociado, las
;;; celdas que tienen un estado 'eliminado' contienen un espacio en blanco y
;;; las celdas con el estado 'desconocido' contienen un símbolo '?'.




(defrule imprime-solucion
  (declare (salience -10))
  =>
  (printout t " Original           Solución " crlf)  
  (printout t "+---------+        +---------+" crlf)
  (assert (imprime 1)))

(defrule imprime-fila
  (declare (salience -10))
  ?h <- (imprime ?i&:(<= ?i 9))
  (celda (fila ?i) (columna 1) (valor ?v1) (estado ?s1))
  (celda (fila ?i) (columna 2) (valor ?v2) (estado ?s2))
  (celda (fila ?i) (columna 3) (valor ?v3) (estado ?s3))
  (celda (fila ?i) (columna 4) (valor ?v4) (estado ?s4))
  (celda (fila ?i) (columna 5) (valor ?v5) (estado ?s5))
  (celda (fila ?i) (columna 6) (valor ?v6) (estado ?s6))
  (celda (fila ?i) (columna 7) (valor ?v7) (estado ?s7))
  (celda (fila ?i) (columna 8) (valor ?v8) (estado ?s8))
  (celda (fila ?i) (columna 9) (valor ?v9) (estado ?s9))
  =>
  (retract ?h)
  (bind ?fila1 (sym-cat ?v1 ?v2 ?v3 ?v4 ?v5 ?v6 ?v7 ?v8 ?v9))
  (bind ?w1 (if (eq ?s1 asignado) then ?v1
	      else (if (eq ?s1 eliminado) then " " else "?")))
  (bind ?w2 (if (eq ?s2 asignado) then ?v2
	      else (if (eq ?s2 eliminado) then " " else "?")))
  (bind ?w3 (if (eq ?s3 asignado) then ?v3
	      else (if (eq ?s3 eliminado) then " " else "?")))
  (bind ?w4 (if (eq ?s4 asignado) then ?v4
	      else (if (eq ?s4 eliminado) then " " else "?")))
  (bind ?w5 (if (eq ?s5 asignado) then ?v5
	      else (if (eq ?s5 eliminado) then " " else "?")))
  (bind ?w6 (if (eq ?s6 asignado) then ?v6
	      else (if (eq ?s6 eliminado) then " " else "?")))
  (bind ?w7 (if (eq ?s7 asignado) then ?v7
	      else (if (eq ?s7 eliminado) then " " else "?")))
  (bind ?w8 (if (eq ?s8 asignado) then ?v8
	      else (if (eq ?s8 eliminado) then " " else "?")))
  (bind ?w9 (if (eq ?s9 asignado) then ?v9
	      else (if (eq ?s9 eliminado) then " " else "?")))
  (bind ?fila2 (sym-cat ?w1 ?w2 ?w3 ?w4 ?w5 ?w6 ?w7 ?w8 ?w9))
  (printout t "|" ?fila1 "|        |" ?fila2 "|" crlf)
  (if (= ?i 9)
      then (printout t "+---------+        +---------+" crlf)
    else (assert (imprime (+ ?i 1)))))


;revisar puzle 22
;arreglado

;version 3
    ;;esta version deja 
    ;sinresolver      :8
    ;equivocados      :9
    ;sin + equivocados: 3
;version 4
    ;;esta version deja 
    ;sinresolver      :18()
    ;equivocados      :
    ;sin + equivocados: 
;revisar puzle 41
