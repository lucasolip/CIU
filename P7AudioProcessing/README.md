# Procesamiento de Audio
![Gif de la aplicación](https://user-images.githubusercontent.com/47455265/160112321-a4f660d2-8e3f-4f7b-9c41-c0e9037bb6b6.gif)

<br>*Lucas Olivares Pérez*
# Características
La aplicación dispone de dos paneles. El panel superior contiene el botón de control de reproducción (play/pausa), el botón de carga de ficheros y una visualización del audio que se reproduce actualmente que incluye un sprite que rota cuando el audio se está reproduciendo, cambia de tamaño y genera particulas según la intensidad de la pista. El panel inferior incluye una visualización de las frecuencias del audio actual y un círculo semitransparente que controla el ancho de banda y la frecuencia de un filtro de paso bajo.

# Implementación
Los botones son iconos delimitados por un rectángulo de su tamaño. Cuando ocurre un evento de ratón, la aplicación llama a unos métodos manejadores definidos en la clase Button (onMouseClick, onMouseRelease...) que se encargan de cambiar el estado de cada botón.<br>
El diagrama de frecuencias lo calcula la librería Minim utilizando una transformada de Fourier rápida (FFT) y se le aplica una ventana Gauss para suavizar los picos de la visualización. El filtro de paso bajo también es una función de Minim y sus parámetros se actualizan cada vez que el ratón se arrastra con el control de frecuencias en click.<br>
La visualización de partículas se implementa como un sistema de partículas con un pequeño motor de físicas que le aplica una velocidad inicial de dirección aleatoria y magnitud definida por la intensidad de la música a cada partícula

# Controles
En esta ocasión los controles se implementaron completamente como botones clickables
- Botón play/pausa: Reproduce o pausa el fichero de audio actual
- Botón de carga: Muestra una ventana de carga de ficheros que varía según el sistema operativo y solo permite elegir ficheros mp3
- Control de frecuencia: Se puede arrastrar y controla el filtro de paso bajo

# Referencias
