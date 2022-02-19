# Superficies de Revolución
![ezgif-7-bf6a4bfe52](https://user-images.githubusercontent.com/47455265/154152690-dccf305f-5854-420a-bfeb-262e4f17fdcd.gif)<br>
*Lucas Olivares Pérez*

## Características
La aplicación se divide en dos vistas: Una que podríamos llamar de dibujo y otra que muestra el modelo 3D generado por revolución. La vista de dibujo permite añadir vértices al perfil de la figura ya sea haciendo click por cada vértice deseado o manteniendo el click mientras se arrastra el ratón por la pantalla. El perfil se dibuja solo por el lado derecho de la pantalla, sin embargo la aplicación acepta que se añadan vértices también por la mitad izquierda y los refleja internamente.
Mediante el botón espacio se puede cambiar de vista y generar un modelo a partir del perfil dibujado. El modelo se puede rotar y mostrar u ocultar su relleno, iluminación y mallado en perspectiva.

## Implementación
Las coordenadas de los vértices del perfil se guardan como PVector en un ArrayList y se muestran cada frame en pantalla. Además almacena el último vértice añadido para dibujar una línea entre el mismo y el ratón, tratando de dar una apariencia de continuidad al proceso de dibujo. El modelo se genera creando triángulos sucesivos en un PShape que forman tiras verticales a lo largo de un círculo.

## Controles
- **Vista de dibujo**
  - Click: Añadir vértice
  - Click y arrastrar: Dibujar, añadir vértices continuamente
  - Espacio: Cambiar a vista de modelo
  - H: Mostrar/Ocultar ayuda
- **Vista de modelo**
  - R: Rotar/Dejar de rotar
  - L: Activar/Desactivar iluminación
  - W: Mostrar/Ocultar mallado
  - F: Mostrar/Ocultar relleno de las caras
  - Espacio: Cambiar a vista de dibujo
  - H: Mostrar/Ocultar ayuda
