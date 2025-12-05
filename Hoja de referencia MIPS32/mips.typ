#import "@preview/numbly:0.1.0": numbly

#set par(justify: true)
#set text(
  font: "Times New Roman",
  size: 9pt,
)
#show math.equation: set text(font: "TeX Gyre Termes Math")
#show raw: set text(font: "TeX Gyre Cursor")
#show raw.where(block: true): it => align(center)[#block(
  fill: luma(230),
  radius: 3pt,
  inset: 4pt,
  stroke: black,
)[#it]]
#set page(
  height: 27.94cm,
  width: 21.59cm,
  columns: 2,
  margin: (top: 1.9cm, bottom: 2.54cm, left: 1.6cm, right: 1.6cm),
)
#show title: set text(size: 24pt)
#set heading(
  numbering: numbly(
    "{1:I}. ",
    "{2:A}. ",
    "\u{20}\u{20}\u{20}{3}) "
  ),
)
#show heading: set text(size: 10pt)
#show heading.where(depth: 1): set align(center)
#show heading.where(depth: 1): upper
#show heading.where(depth: 2): set text(style: "italic")
#show heading.where(depth: 3): set text(style: "italic")
#show heading.where(depth: 3): it => box[#counter(heading).display(it.numbering)#it.body: ]

#place(
  top + center,
  float: true,
  scope: "parent",
  clearance: 1.5cm,
)[
  #title[Hoja de Referencia MIPS32]
  #text(size: 11pt)[3 de Diciembre de 2025]
  #linebreak()
]

= Operandos
== Registros

#align(center)[
  #table(
    columns: (auto, auto, auto),
    align: center,
    inset: 5pt,
    table.header([*Registro*], [*Numero*], [*Descripción*]),
    text("$z0"), text("0"), text("Valor constante 0"),
    text("$at"), text("1"), text("Ensamblador Temporal"),
    text("$v0 - $v1"), text("2 - 3"), text("Valores de resultado de funciones y evaluación de expresiones"),
    text("$a0 - $a3"), text("4 - 7"), text("Argumentos"),
    text("$t0 - $t7"), text("8 - 15"), text("Temporales (no se guarda el valor entre llamadas)"),
    text("$s0 - $s7"), text("16 - 23"), text("Temporales almacenados (no se guarda el valor entre llamadas)"),
    text("$t8 - $t9"), text("24 - 25"), text("Temporales (no se guarda el valor entre llamadas)"),
    text("$k0 - $k1"), text("26 - 27"), text("Reservados para el núcleo del Sistema Operativo"),
    text("$gp"), text("28"), text("Puntero al área global"),
    text("$sp"), text("29"), text("Puntero de pila"),
    text("$fp"), text("30"), text("Puntero de marco de pila"),
    text("$ra"), text("31"), text("Dirección de retorno, usada por llamadas a función")
  )
]

== Palabras

El tamaño de un registro en _MIPS_ es de 32 _bits_, dada la
frecuencia de grupos de este tamaño, se les ha dado un nombre,  "*Palabra*".

*Palabra* (_word_ en ingles): Unidad natural de acceso en un computador,
normalmente un grupo de 32 _bits_ (4 _bytes_), corresponde al tamaño de
un registro en la arquitectura _MIPS_.

//#colbreak()

= Instrucciones
== Formatos básicos de instrucción

- Formato Tipo R: En este formato las instrucciones sólo utilizan registos. Los campos que componen a este formato son:

-- *co*: Código de operación

-- *rs*: Primera referencia a un registro fuente

-- *rt*: Segunda referencia a un registro fuente

-- *rd*: Referencia a un registro destino

-- *desp*: Valor numérico utilizado en las instrucciones de desplazamiento

-- *func*: Campo de función utilizado para seleccionar una variante del código de operación

#align(center)[
  #table(
    columns: (1.5cm, 1.25cm, 1.25cm, 1.25cm, 1.25cm, 1.5cm),
    align: center,
    inset: 5pt,
    table.cell(stroke: none)[31 - 26],
    table.cell(stroke: none)[25 - 21],
    table.cell(stroke: none)[20 - 16],
    table.cell(stroke: none)[15 - 11],
    table.cell(stroke: none)[10 - 6],
    table.cell(stroke: none)[5 - 0],
    [*co*], [*rs*], [*rt*], [*rd*], [*desp*], [*func*],
    table.cell(stroke: none)[6 bits],
    table.cell(stroke: none)[5 bits],
    table.cell(stroke: none)[5 bits],
    table.cell(stroke: none)[5 bits],
    table.cell(stroke: none)[5 bits],
    table.cell(stroke: none)[6 bits],
  )
]

- Formato Tipo I: En este formato las instrucciones utilizan dos registos y un valor inmediato de 16 bits. Los campos que componen a este formato son:

-- *co*: Código de operación

-- *rs*: Primera referencia a un registro fuente

-- *rd*: Referencia a un registro destino

-- *num*: Valor inmediato

#align(center)[
  #table(
    columns: (1.5cm, 1.25cm, 1.25cm, 4cm),
    align: center,
    inset: 5pt,
    table.cell(stroke: none)[31 - 26],
    table.cell(stroke: none)[25 - 21],
    table.cell(stroke: none)[20 - 16],
    table.cell(stroke: none)[15 - 0],
    [*co*], [*rs*], [*rd*], [*num*],
    table.cell(stroke: none)[6 bits],
    table.cell(stroke: none)[5 bits],
    table.cell(stroke: none)[5 bits],
    table.cell(stroke: none)[16 bits],
  )
]

- Formato Tipo J: Este formato solo se utiliza con instrucciones de salto incondicional. Los campos que componen a este formato son:

-- *co*: Código de operación

-- *num*: Valor inmediato utilizado para el cálculo de la dirección de salto

#align(center)[
  #table(
    columns: (1.5cm, 6.5cm),
    align: center,
    inset: 5pt,
    table.cell(stroke: none)[31 - 26],
    table.cell(stroke: none)[25 - 0],
    [*co*], [*num*],
    table.cell(stroke: none)[6 bits],
    table.cell(stroke: none)[26 bits],
  )
]

- Pseudoinstrucciones: Variación común de las instrucciones del lenguaje ensamblador, generalmente tratadas como si fueran instrucciones de pleno derecho. No estan implementadas en hardware pero su aparición en el ensamblador simplifica la traducción y programación.

#pagebreak()
== Repertorio de instrucciones

=== Instrucciones de aritmética

- De Suma:

-- Suma (#raw("add", lang: "yasm")): Instrucción de tipo R, suma dos operandos, #raw("$s2", lang: "yasm") y #raw("$s2", lang: "yasm"), almacenando
el resultado en #raw("$s3", lang: "yasm"). Tiene la siguiente estructura:

```yasm
add $s1, $s2, $s3 # $s1 ← $s2 + $s3
```

-- Suma inmediata (#raw("addi", lang: "yasm")): Instrucción de tipo I, suma dos operandos, un registro (#raw("$s2", lang: "yasm")), 
y una constante entera $k$, tiene la siguiente estructura (ejemplo usando $k = 100$):

```yasm
addi $s1, $s2, 100 # $s1 ← $s2 + 100
```

-- Suma sin signo (#raw("addu", lang: "yasm")): Instrucción de tipo R, suma dos operandos, #raw("$s2", lang: "yasm") y #raw("$s2", lang: "yasm"), almacenando
el resultado en #raw("$s3", lang: "yasm"). Tiene la siguiente estructura:

```yasm
addu $s1, $s2, $s3 # $s1 ← $s2 + $s3
```

-- Suma inmediata sin signo (#raw("addiu", lang: "yasm")): Instrucción de tipo I, suma dos operandos, un registro (#raw("$s2", lang: "yasm")), 
y una constante entera $k$, tiene la siguiente estructura (ejemplo usando $k = 100$):

```yasm
addiu $s1, $s2, 100 # $s1 ← $s2 + 100
```

- De resta

-- Resta (#raw("sub", lang: "yasm")): Instrucción de tipo R, resta dos operandos, #raw("$s2", lang: "yasm") y #raw("$s2", lang: "yasm"), almacenando
el resultado en #raw("$s3", lang: "yasm"). Tiene la siguiente estructura:

```yasm
sub $s1, $s2, $s3 # $s1 ← $s2 - $s3
```

-- Resta sin signo (#raw("subu", lang: "yasm")): Instrucción de tipo R, resta dos operandos, #raw("$s2", lang: "yasm") y #raw("$s2", lang: "yasm"), almacenando
el resultado en #raw("$s3", lang: "yasm"). Tiene la siguiente estructura:

```yasm
subu $s1, $s2, $s3 # $s1 ← $s2 - $s3
```

- De multiplicación y división

-- Multiplicación (#raw("mult", lang: "yasm")): Instrucción de tipo R, multiplica dos operandos, la parte baja del resultado se deja en el registro #raw("lo", lang: "yasm"),
y la parte alta en el registro #raw("hi", lang: "yasm")

```yasm
mult $s1, $s2 # {Hi, Lo} ← $s1 * $s2
```

-- Multiplicación sin signo (#raw("multu", lang: "yasm")): Instrucción de tipo R, multiplica dos operandos, la parte baja del resultado se deja en el registro #raw("lo", lang: "yasm"),
y la parte alta en el registro #raw("hi", lang: "yasm")

```yasm
multu $s1, $s2 # {Hi, Lo} ← $s1 * $s2
```

-- División (#raw("div", lang: "yasm")): Instrucción de tipo R, divide dos operandos,
deja a el cociente en el registro #raw("lo", lang: "yasm") y el resto en el registro
#raw("hi", lang: "yasm")

```yasm
div $s1, $s2 # Lo ← $s1 / $s2, Hi ← $s1 % $s2
```

-- División sin signo (#raw("divu", lang: "yasm")): Instrucción de tipo R, divide dos operandos,
deja a el cociente en el registro #raw("lo", lang: "yasm") y el resto en el registro
#raw("hi", lang: "yasm")

```yasm
divu $s1, $s2 # Lo ← $s1 / $s2, Hi ← $s1 % $s2
```

-- Mover de parte alta (#raw("mfhi", lang: "yasm")): Instrucción de tipo R, copia el contenido
del registro #raw("hi", lang: "yasm"), hasta uno dado

```yasm
mfhi $s0 # $s0 ← Hi
```

-- Mover de parte baja (#raw("mflo", lang: "yasm")): Instrucción de tipo R, copia el contenido
del registro #raw("lo", lang: "yasm"), hasta uno dado

```yasm
mflo $s0 # $s0 ← Lo
```

=== Instrucciones de acceso a memoria

- De carga

-- Carga de un byte (#raw("lb", lang: "yasm")): Instrucción de tipo I. Carga un 
_Byte_ de memoria a un registro, extiende el signo

```yasm
lb $s1,k($s2) # $s1 ← Memory[$s2 + k]
```

-- Carga de un byte sin signo (#raw("lbu", lang: "yasm")): Instrucción de tipo I. Carga un 
_Byte_ de memoria a un registro, no extiende el signo

```yasm
lbu $s1,k($s2) # $s1 ← Memory[$s2 + k]
```

-- Carga de una palabra (#raw("lw", lang: "yasm")): Instrucción de tipo I. Carga una palabra
de memoria a un registro, extiende el signo

```yasm
lw $s1,k($s2) # $s1 ← Memory[$s2 + k]
```

-- Carga de media palabra (#raw("lh", lang: "yasm")): Instrucción de tipo I. Carga una media palabra (2 _bytes_)
de memoria a un registro, extiende el signo

```yasm
lh $s1,k($s2) # $s1 ← Memory[$s2 + k]
```

-- Carga de media palabra sin signo (#raw("lhu", lang: "yasm")): Instrucción de tipo I. Carga una media palabra (2 _bytes_)
de memoria a un registro, no extiende el signo

```yasm
lhu $s1,k($s2) # $s1 ← Memory[$s2 + k]
```

- De almacenado

-- Guarda un byte (#raw("sb", lang: "yasm")): Instrucción de tipo I. Carga en memoria
un byte de un registro

```yasm
sb $s1,k($s2) # Memory[$s2 + k] ← $s1
```

-- Guarda una palabra (#raw("sw", lang: "yasm")): Instrucción de tipo I. Carga en memoria
una palabra de un registro

```yasm
sw $s1,k($s2) # Memory[$s2 + k] ← $s1
```

-- Guarda una media palabra (#raw("sh", lang: "yasm")): Instrucción de tipo I. Carga en memoria
una media palabra de un registro

```yasm
sh $s1,k($s2) # Memory[$s2 + k] ← $s1
```
#pagebreak()
=== Instrucciones de lógica

-- And (#raw("and", lang: "yasm")): Instrucción de tipo R, guarda en #raw("$s0", lang: "yasm") el resultado de efectuar la operación lógica $#raw("$s1", lang: "yasm") and #raw("$s2", lang: "yasm")$, tiene la siguiente estructura:

```yasm
and $s0, $s1, $s2 # $s0 ← $s1 ∧ $s2
```

-- And inmediato (#raw("andi", lang: "yasm")): Instrucción de tipo I, guarda en #raw("$s0", lang: "yasm") el resultado de efectuar la operación lógica $#raw("$s1", lang: "yasm") and k$, donde $k$ es una constante dada, tiene la siguiente estructura:

```yasm
andi $s0, $s1, k # $s0 ← $s1 ∧ k
```

-- Or (#raw("or", lang: "yasm")): Instrucción de tipo R, guarda en #raw("$s0", lang: "yasm") el resultado de efectuar la operación lógica $#raw("$s1", lang: "yasm") or #raw("$s2", lang: "yasm")$, tiene la siguiente estructura:

```yasm
or $s0, $s1, $s2 # $s0 ← $s1 ∨ $s2
```

-- Or inmediato (#raw("ori", lang: "yasm")): Instrucción de tipo I, guarda en #raw("$s0", lang: "yasm") el resultado de efectuar la operación lógica $#raw("$s1", lang: "yasm") or k$, donde $k$ es una constante dada, tiene la siguiente estructura:

```yasm
ori $s0, $s1, k # $s0 ← $s1 ∧ k
```

-- Or exclusivo (#raw("xor", lang: "yasm")): Instrucción de tipo R, guarda en #raw("$s0", lang: "yasm") el resultado de efectuar la operación lógica $#raw("$s1", lang: "yasm") \u{22BB} #raw("$s2", lang: "yasm")$, tiene la siguiente estructura:

```yasm
xor $s0, $s1, $s2 # $s0 ← $s1 ⊻ $s2
```

-- Or inmediato exclusivo (#raw("xori", lang: "yasm")): Instrucción de tipo I, guarda en #raw("$s0", lang: "yasm") el resultado de efectuar la operación lógica $#raw("$s1", lang: "yasm") \u{22BB} k$, donde $k$ es una constante dada, tiene la siguiente estructura:

```yasm
xori $s0, $s1, k # $s0 ← $s1 ⊻ k
```

-- Nor (#raw("nor", lang: "yasm")): Instrucción de tipo R, guarda en #raw("$s0", lang: "yasm") el resultado de efectuar la operación lógica $not(#raw("$s1", lang: "yasm") or #raw("$s2", lang: "yasm"))$, tiene la siguiente estructura:

```yasm
nor $s0, $s1, $s2 # $s0 ← ¬($s1 ∨ $s2)
```

-- Desplazamiento lógico a la izquierda (#raw("sll", lang: "yasm")): Instrucción de tipo R, mueve los _bits_ del registro dado $k$ posiciones a la izquierda, aquellas posiciones que son anuladas se rellenan con ceros, tiene la siguiente estructura:

```yasm
sll $s1, $s2, k # $s1 ← $s2 << k
```

-- Desplazamiento lógico a la derecha (#raw("srl", lang: "yasm")): Instrucción de tipo R, mueve los _bits_ del registro dado $k$ posiciones a la derecha.
En los numeros sin signo, las posiciones de bits que la operación de desplazamiento ha anulado son de relleno cero. En el caso de los números con signo, el bit de signo se usa para rellenar las posiciones de bits vacías, tiene la siguiente estructura:

```yasm
srl $s1, $s2, k # $s1 ← $s2 >> k
```

#colbreak()
=== Condicionales

-- Salto si igual (#raw("beq", lang: "yasm")): Instrucción de tipo I, comprueba si dos registros son iguales, en cuyo caso, salta a otra parte del programa (puede ser o una etiqueta, o una posicion relativa a la llamada), tiene la siguiente estructura:

```yasm
beq $s1, $s2, label # if ($s1 = $s2) go to label
```

-- Salto si distinto (#raw("bnq", lang: "yasm")): Instrucción de tipo I, comprueba si dos registros son distintos, en cuyo caso, salta a otra parte del programa (puede ser o una etiqueta, o una posicion relativa a la llamada), tiene la siguiente estructura:

```yasm
beq $s1, $s2, label # if ($s1 ≠ $s2) go to label
```

-- Salto si menor que (#raw("blt", lang: "yasm")): Pseudoinstrucción, compara dos registros y si el primero es menor que el segundo, salta a la etiqueta

```yasm
blt $s1, $s2, label # if ($s1 < $s2) go to label
```

-- Salto si mayor que (#raw("bgt", lang: "yasm")): Pseudoinstrucción, compara dos registros y si el primero es mayor que el segundo, salta a la etiqueta

```yasm
bgt $s1, $s2, label # if ($s1 > $s2) go to label
```

-- Salto si menor que o igual (#raw("ble", lang: "yasm")): Pseudoinstrucción, compara dos registros y si el primero es menor o igual que el segundo, salta a la etiqueta

```yasm
ble $s1, $s2, label # if ($s1 ≤ $s2) go to label
```

-- Salto si mayor que o igual (#raw("bge", lang: "yasm")): Pseudoinstrucción, compara dos registros y si el primero es mayor o igual que el segundo, salta a la etiqueta

```yasm
bge $s1, $s2, label # if ($s1 ≥ $s2) go to label
```

-- Fijar si menor que (#raw("slt", lang: "yasm")): Instrucción de tipo R, compara dos registros #raw("$s2", lang: "yasm") y #raw("$s3", lang: "yasm"), si $\$"s2" < \$"s3"$, a #raw("$s1", lang: "yasm") le asigna 1, si no, le asigna 0, tiene la siguiente estructura:

```yasm
slt $s1, $s2, $s3 # if ($s2 < $s3) $s1 ← 1 else $s2 ← 0
```

-- Fijar si menor que inmediato (#raw("slti", lang: "yasm")): Instrucción de tipo I, compara un registro #raw("$s2", lang: "yasm") y una constante $k$, si $\$"s2" < k$, a #raw("$s1", lang: "yasm") le asigna 1, si no, le asigna 0, tiene la siguiente estructura:

```yasm
slti $s1, $s2, k # if ($s2 < k) $s1 ← 1 else $s2 ← 0
```

-- Fijar si menor que sin signo (#raw("sltu", lang: "yasm")): Instrucción de tipo R, compara dos registros #raw("$s2", lang: "yasm") y #raw("$s3", lang: "yasm"), si $#raw("$s2", lang: "yasm") < #raw("$s3", lang: "yasm")$, a #raw("$s1", lang: "yasm") descartando los signos, le asigna 1, si no, le asigna 0, tiene la siguiente estructura:

```yasm
sltu $s1, $s2, $s3 # if ($s2 < $s3) $s1 ← 1 else $s2 ← 0
```

-- Fijar si menor que sin signo inmediato (#raw("sltui", lang: "yasm")): Instrucción de tipo I, compara un registro #raw("$s2", lang: "yasm") y una constante $k$, si $#raw("$s2", lang: "yasm") < k$, a #raw("$s1", lang: "yasm") descartando los signos, le asigna 1, si no, le asigna 0, tiene la siguiente estructura:

```yasm
sltui $s1,$s2,$s3 # if ($s2 < $s3) $s1 ← 1 else $s1 ← 0
```

=== Saltos incondicionales

-- Salto incondicional (#raw("j", lang: "yasm")): Instrucción de tipo J, salta a la dirección destino, tiene la siguiente estructura:

```yasm
j label # go to label
```

-- Saltar y enlanzar (#raw("jal", lang: "yasm")): Instrucción de tipo J, se usa para llamar a subrutinas/funciones, hace el salto a la etiqueta guarda la posicion de la llamada en #raw("$ra"), tiene la siguiente estructura:
#footnote("PC significa \"Program Counter\" y es un registro que contiene la dirección de la instrucción que está siendo ejecutada en el programa")

```yasm
jal label # $ra ← PC + 4; go to label
```

-- Salto con registro (#raw("jr", lang: "yasm")): Instrucción de tipo J, se usa para volver de una llamada a una función/subrutina, tiene la siguiente estructura:

```yasm
jr $ra # go to $ra
```