#import "@preview/numbly:0.1.0": numbly

#set par(justify: true)
#set text(
  font: "Times New Roman",
  size: 9pt,
)
#show math.equation: set text(font: "TeX Gyre Termes Math")
#show raw: it => align(center)[#block(
  fill: luma(230),
  radius: 3pt,
  inset: 4pt,
  stroke: black,
)[#text(it, font: "TeX Gyre Cursor")]]
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
#show heading.where(depth: 3): it => box[#counter(heading).display(it.numbering)#it.body:]

#set table(
  fill: (_, y) => if (y > 0) {
    if y <= 6 {
      if (calc.odd(y)) {
        rgb("aae0f9")
      } else {
        rgb("#3acaff")
      }
    } else if (y <= 9) {
      if (calc.odd(y)) {
        rgb("#ff9aa7")
      } else {
        rgb("#ffc2c2")
      }
    } else {
      if (calc.odd(y)) {
        rgb("#fff9c2")
      } else {
        rgb("fff69a")
      }
    }
  }
)

#let color1(color) = if (color == 1) {
    rgb("#aae0f9")
} else if (color == 3) {
    rgb("#fff69a")
} else if (color == 2) {
    rgb("#ff9aa7")
}

#let color2(color) = if (color == 1) {
    rgb("#00adee")
} else if (color == 3) {
    rgb("#fff9c2")
} else if (color == 2) {
    rgb("#ffc2c2")
}

#let formula(titulo, color, cuerpo) = {
  block(
    fill: color1(color),
    stroke: black,
    radius: 12pt,
    inset: 8pt,
    width: 8.8cm,
  )[
    #box(
      fill: color2(color),
      width: 100%,
      radius: (top: 12pt),
      outset: 7pt
    )[#if (color == 1) {
      text(fill: white)[#titulo]
    } else {
      text()[#titulo]
    }]
    #line(length: 107%, start: (-8pt, -3pt))
    #cuerpo
    #v(8pt)
  ]
}

#place(
  top + center,
  float: true,
  scope: "parent",
  clearance: 1.5cm,
)[
  #title[Formulario del Capitulo I]
  #text(size: 11pt)[20 de Diciembre de 2025]
  #linebreak()
]


= Definiciones

#align(center)[
  #table(
    columns: (auto, auto),
    align: center,
    inset: 5pt,
    stroke: none,
    table.hline(),
    table.header(table.vline() ,[*Nombre*], table.vline(end: 1), [*Definición*], table.vline()),
    table.hline(),
    [Tiempo de Respuesta (Tiempo de ejecución)], [Tiempo total (desde el inicio hasta el final) requerido por un computador para completar una tarea, una forma para medir este tiempo, puede ser usando el comando _time_, presente en varios sistemas operativos basados en _Linux_.],
    [Productividad (Ancho de Banda)], [Número de tareas que se completan por unidad de tiempo.],
    [Ciclo de reloj], [Tiempo de un periodo de reloj, usualmente el periodo del reloj del procesador, avanza a un paso constante.],
    [Periodo de reloj], [Longitud de cada ciclo de reloj.],
    [Ciclos de reloj por instrucción (CPI)], [Número medio de ciclos de reloj por instrucción para un programa o fragmento de programa.],
    [Mezcla de instrucciones], [Medida de la frecuencia dinámica de las instrucciones a lo largo de uno o varios programas.],
    table.hline(),
    [Oblea], [Rebanada de un lingote de silicio, de grosor no mayor que 0.25cm, que se usa para fabricar _chips_.],
    [Dado], [Sección rectangular individual que se corta de una oblea.],
    [Factor de producción], [Porcentaje de dados correctos del total de dados de oblea.],
    table.hline(),
    [Ley de _Amdahl_], [Establece que el aumento posible de las prestaciones con una mejora determinada está limitado por la cantidad en que se usa la mejora.],
    [MIPS (Millones de instrucciones por segundo)], [Medida de la velocidad de ejecución de un programa basada en el número de instrucciones],
    table.hline()
  )
]

= Formulas

== Prestaciones

#formula(
  "A.1) Prestaciones", 1
)[
  Se definen las prestaciones de $X$ en relación a su tiempo de respuesta con respecto a una tarea como:

    $ #text("Prestaciones")_X = 1/#text(("Tiempo de ejecución"))_X $

    Así, podemos comparar dos computadoras a traves de su tiempo de respuesta:

    $ #text("Prestaciones")_X > #text("Prestaciones")_Y \ #text("Si y solo si") \ 1/#text(("Tiempo de ejecución"))_X > 1/#text(("Tiempo de ejecución"))_Y \ #text("Lo que es equivalente a que:") \ #text(("Tiempo de ejecución"))_Y > #text(("Tiempo de ejecución"))_X $

    Lo que quiere decir, que $X$ tiene mejores prestaciones que $Y$,
    si su tiempo de ejecución dada una tarea es menor que el de $Y$.
]

#formula(
  "A.2) Prestaciones Cuantitativas", 1
)[
  Se dice que "$X$ es $n$ veces mas rapida que $Y$", para indicar que:

    $ #text("Prestaciones")_X / #text("Prestaciones")_Y  = n $

  Y si esto se cumple, entonces el tiempo de ejecución de $Y$ es $n$ veces mas rapido que el de $X$:

    $ #text("Prestaciones")_X / #text("Prestaciones")_Y  = #text(("Tiempo de ejecución"))_Y / #text(("Tiempo de ejecución"))_X = n $
]

#formula(
  "A.3) Relaciones de reloj y ciclos de reloj", 1
)[
  Restringiendonos a las prestaciones del _CPU_, una formula sencilla que relaciona al reloj con el tiempo, seria:

    $ #text("Tiempo de ejecución de \nCPU para un programa") = #text("Ciclos de reloj de la\nCPU para el programa") times #text("Tiempo del\nciclo del reloj") $
  
  Lo que, teniendo en cuenta que la frecuencia de reloj es la inversa del tiempo del ciclo, seria igual a:

    $ #text("Tiempo de ejecución de \nCPU para un programa", size: 8pt) = #text("Ciclos de reloj de la CPU para el programa", size: 8pt) / #text("Frecuencia de reloj", size: 8pt) $
]

#formula(
  "A.4) Prestaciones de las instrucciones", 1
)[
  Considerando que el tiempo de ejecución de un programa puede ser igual a su número de instrucciones, multiplicado por el tiempo medio de ejecución de cada instrucción, se puede evaluar el número de ciclos de reloj requerido por un programa como:

    $ #text("Ciclos de reloj de CPU") = #text("Instrucciones de\nun programa") times #text("Media de ciclos\npor instrucción") $
]

#formula(
  "A.5) Ecuación Basica de las prestaciones de la CPU", 1
)[
  Escribiendo las prestaciones en terminos del número de instrucciones, CPI, y tiempo de ejecución, nos queda:

    $ #text("Tiempo de ejecución", size: 8pt) = #text("Número de instrucciones", size: 8pt) times
    #text("CPI", size: 8pt) times #text("Tiempo de ciclo", size: 8pt) $
  
  Lo que, sabiendo que la frecuencia es el inverso al tiempo del ciclo:

    $ #text("Tiempo de ejecución") = (#text("Número de instrucciones") times #text("CPI")) / #text("Frecuencia de reloj") $
]

== Circuitos Integrados

#formula(
  "B.1) Coste de un circuito integrado", 2
)[
  El coste de un circuito integrado se puede expresar con tres ecuaciones simples:
    $ #text("coste por dado") = #text("coste por oblea") / (#text("dado por oblea") times #text("factor de producción")) $
    $ #text("dados por oblea") = #text("área de la oblea") / #text("àrea del dado") $
    $ #text("factor de producción") =  1 / (1 + (#text("defectos por àrea")times#text("àrea del dado")) / 2)^2 $
]

#formula(
  "B.2) Media Geométrica", 2
)[
  Cuando se comparan dos computadores utilizando razones _SPEC_ (System Performance Evaluation Cooperative), conviene usar la media
  geométrica porque da la misma respuesta relativa sin importar que computador se utiliza como referencia para normalizar los
  tiempos:
  $ n sqrt(product_(i=1)^(n)text("Relaciones de tiempos de ejecución")_i) $
]

#formula(
  "B.3) Prestaciones en función del ancho de banda", 2
)[
  Siendo la medida de las prestaciones, la productividad (ancho de banda), y las unidades
  operaciones de negocio por segundo, _SPEC_ reduce esta medida a un único número, llamado
  _ssj_ops global por vatio_, donde esta metrica de resumen se define como:
  $ #text("ssj_ops global por vatio", style: "italic") = (sum_(i=0)^(10)text("ssj_ops")_i)(sum_(i=0)^(10)text("potencia")_i) $
  Donde $#text("ssj_ops")_i$ son las prestaciones en el i-esimo incremento de carga del 10%, y
  $#text("potencia")_i$ es el consumo de potencia en el nivel $i$
]

== Falacias y errores habituales

#formula(
  "C.1) Ley de Amdahl", 3
)[
  El tiempo de ejecución de un programa después de hacer una mejora
  viene dado por la siguiente ecuación:
  $ #text("tiempo de ejecución despues de las mejoras", size: 8pt) =\ #text("tiempo de ejecución por la mejora", size: 8pt) 
  / #text("cantidad de mejora", size: 8pt) + #text("tiempo de ejecución no afectado", size: 8pt) $
]

#formula(
  "C.2) MIPS (Millones de instrucciones por segundo)", 3
)[
  Para un programa dado, una altenativa al tiempo de ejecución son los MIPS, que
  se define como:
  $ #text("MIPS") = #text("número de instrucciones")/(#text("tiempo de ejecución")times 10^6) $
  MIPS es una especificación de las prestaciones inversamente proporcional al tiempo de ejecución.
  Sin embargo, tiene varios problemas, el MIPS de un ordenador no es constante, varia en función
  del numero de instrucciones de un programa, igualmente, varia en la arquitectura del computador
  debido a tener diferentes conjuntos de instrucciones, y por ultimo, sus variaciones son independientes
  de las prestaciones

  Si sustituimos el tiempo de ejecución, obtenemos la relación entre MIPS,
  frecuencia de reloj, y CPI:
  $ #text("MIPS") = #text("número de instrucciones")/((#text("Número de instrucciones") times #text("CPI"))
  / #text("Frecuencia de reloj") times 10^6 ) = #text("frecuencia de reloj")/(#text("CPI") times 10^6) $
]