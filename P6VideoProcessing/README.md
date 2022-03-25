# Procesamiento de Vídeo
![Gif](p6.gif)
<br>*Lucas Olivares Pérez*

## Características
La aplicación consiste en tres filtros que utilizan la información de los píxeles de una videocámara para mostrar composiciones. <br>Las dos primeras reconstruyen la imagen utilizando su brillo en escala de grises como grosor de una rejilla de líneas (primer filtro) o círculos concéntricos (segundo filtro). El tercer y último filtro consiste en un mosaico de círculos que tratan de evitar estar cerca del ratón al mismo tiempo que intentan mantener su color y posición donde les corresponde en la imagen.

## Implementación
El grosor de las líneas de los dos primeros filtros resulta de dibujar puntos con el *strokeWeight* modificado basándose en cómo varía el tono de la imagen original en escala de grises. El rango de valores en que puede variar el *strokeWeight* y la separación de las líneas en la rejilla se pueden configurar por parámetro.
<br>
El segundo filtro es similar al primero, solo que en lugar de una rejilla de cuadrados se dibujan círculos concéntricos en el centro de la imagen. Utilizando coordenadas polares, recorriendo todos los ángulos entre 0 y 2π y variando el radio para cada círculo se consigue este efecto. El radio inicial y la separación entre ellos también son configurables por parámetro.
<br>
El último filtro se implementa como un pequeño motor de físicas en que cada partícula responde a varios steering behaviors, como los denominó Craig Reynolds en su [artículo original](https://www.red3d.com/cwr/steer/gdc99/). La idea es que cada partícula desea quedarse en su posición original, pero también desea alejarse del ratón, así que su movimiento será una combinación de ambos comportamientos. Para que el movimiento sea más natural, como el de una criatura navegando por el mundo, no se modifica directamente la velocidad de la partícula sino que se le aplica una fuerza *steer* que se calcula como la resta entre su dirección actual y la dirección en la que desearía ir.
<br>El texto de ayuda que se muestra depende de en qué filtro nos encontramos e incluye un panel oscuro debajo para mejorar el contraste y la legibilidad.

## Controles
- Click: Cambiar de filtro
- H: Mostrar/Ocultar ayuda
- Filtro de partículas
  - Espacio: Desordenar las partículas

## Herramientas
- [ezgif](https://ezgif.com)

## Referencias
- [Referencia de Processing](https://processing.org/reference/)
- [Inspiración: Moiré](https://www.reddit.com/r/Amoledbackgrounds/comments/pmpm73/moir%C3%A9_1146x1518/)
- [Inspiración: Steering Behaviors](https://www.youtube.com/watch?v=mhjuuHl6qHM)
