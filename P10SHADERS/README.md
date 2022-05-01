# Shaders!
![Escena con shaders](https://user-images.githubusercontent.com/47455265/166155946-04cb6fec-7574-4706-a3ce-de8468e7aa57.gif)
<br>*Lucas Olivares Pérez*
## Características
En esta práctica se dibuja una escena sencilla utilizando:
- Un modelo cuyos vértices se desplazan proceduralmente para simular hierba mecida por el viento
- Materiales coloreados sin iluminación y con textura, para el color de la hierba
- Materiales con iluminación, textura y rugosidad. Colorean la Luna y el suelo
- Un filtro de distorsión para post-procesado de la imagen, que se puede activar o desactivar
## Implementación
El shader de distorsión desplaza los colores de la imagen final, que le viene como textura de entrada, según una función de ruido simplex que depende de la posición de cada píxel. La función de ruido se acumula sobre sí misma en "octavas" según unos parámetros de lacunaridad y persistencia, que le vienen dados desde el sketch de Processing y controlan la frecuencia y amplitud acumuladas.
<br>El vertex shader desplaza los vértices del modelo de hierba también según una función de ruido simplex, en esta ocasión sin acumularse, que además va variando con el tiempo. El desplazamiento depende también de la coordenada UV del modelo, de forma que los vértices más altos del modelo tienen la coordenada UV más alta (1) y se mueven más, mientras que los más bajos tienen la coordenada 0 y se mueven menos. El modelo 3D se realizó en Blender y su textura, un degradado sencillo, en GIMP. La textura se usa como mapa de color de un shader sin iluminación.
<br>Para el shader con iluminación se utilizó el modelo de Phong, que incluye iluminación ambiente, difusa y especular, y se aprovechó un ejemplo del guion de prácticas para perturbar las normales del objeto según un mapa de altura. Se intentó implementar el mismo efecto utilizando mapas de normales en RGB, pero había que calcular la matriz de conversión desde espacio tangente a espacio objeto y ya me estaba quedando sin tiempo para dedicar a otros proyectos.
<br>Se aprovecha también la información del buffer de profundidad para implementar un efecto de niebla que funda los objetos lejanos con el fondo, mezclando el color de cada material con un color de ambiente que coincide con el color de fondo en función de la distancia al observador.

## Controles
- D: Aplicar distorsión sobre la imagen final
- S: Cambiar modo de escalado del ruido
- H: Mostrar/Ocultar ayuda
- R: Reiniciar
## Herramientas
- Blender
- GIMP
## Referencias y créditos
- [Guion de prácticas de la asignatura](https://otsedom.github.io/CIU/)
- [Implementación del ruido simplex](https://gist.github.com/patriciogonzalezvivo/670c22f3966e662d2f83)
- [Textura de la Luna](https://richardandersson.net/?p=331)
- [Textura del suelo](https://3dtextures.me/2021/06/12/rock-moss-001/)
