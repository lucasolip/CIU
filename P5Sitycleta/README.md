# Visualización Sitycleta
![Gif de la Visualización de Las Palmas de Gran Canaria](https://user-images.githubusercontent.com/47455265/158084070-21670f71-162c-49d7-86d1-c901621632ec.gif)
<br>*Lucas Olivares Pérez*

## Controles
- Flecha arriba/abajo: Avanzar o retroceder minutos
- Flecha derecha/izquierda: Avanzar o retroceder días
- Click izquierdo y arrastrar: Rotar la cámara
- Click central y arrastrar: Desplazar la cámara
- Rueda del ratón: Acercar o alejar la cámara

## Características
- Mapa de Las Palmas de Gran Canaria con relieve tridimensional
- Visualización de los trayectos de bicicletas alquiladas en ventanas de tiempo definidas por el usuario. La velocidad a la que se avanza o retrocede por el tiempo se incrementa si el usuario mantiene pulsada la flecha correspondiente
- Indicador de cuántas bicicletas se usan a la vez en un mismo instante
- Estaciones representadas con modelos de bicicletas que rotan

## Implementación
- Rejilla generada por código. La altura de cada vértice viene dada por un mapa de altura extraído de un mapa de la Tierra disponible en una web de la NASA e interpolado, dado que la imagen original medía apenas 50x50
- Los trayectos se pintan sobre un PGraphics, directamente sobre la textura
- Dado un objeto Date de Java, se calcula qué trayectos estaban activos en ese instante concreto. Se da formato al Date actual usando la clase SimpleDateFormat de Java

## Herramientas
- GIMP
- Audacity
- Blender
- [ezgif](https://ezgif.com)

## Referencias
- [Referencia de Processing](https://processing.org/reference/)
- [OpenStreetMap](https://www.openstreetmap.org/)
- [Sagulpa](https://www.sagulpa.com/)
- Recursos
  - [Mapa de altura](https://visibleearth.nasa.gov/images/73934/topography)
  - [Mapa artístico de Gran Canaria](https://www3.gobiernodecanarias.org/medusa/mediateca/ecoescuela/wp-content/uploads/sites/2/2013/11/21-Gran-Canaria.png)
  - [Bicicleta](https://sketchfab.com/3d-models/low-poly-bicycle-1a1751bdef69489b84fbf581c6b1a8d4)
