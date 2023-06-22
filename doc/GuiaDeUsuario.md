# Modelo de Nervio

Simulador de la actividad electrofisiológica en un haz de fibras nerviosas mielinizadas.

## Para empezar

### Sobre el modelo

Este es un modelo de un haz de fibras mielínicas por las cuales viaja un potencial de acción, y electrodos que captan los Potencial de Acción Compuesto (CAP) a partir de los Potenciales de Acción de Fibra Única (SFAP) de cada fibra. 

### Prerrequisitos

Para utilizar este código, necesitarás tener instalado Python en tu computadora. Si aún no lo tienes, puedes descargarlo desde el sitio web oficial de Python (**[https://www.python.org/downloads/](https://www.python.org/downloads/)**). La versión utilizada en el código es Python 3.9.1.

Los módulos que se necesitan para poder usar este código se encuentran en el archivo requirements.txt. Para instalarlos se ejecuta la siguiente línea:

```python
pip install requirements.txt
```

## Guía de usuario

Para poder realizar las simulaciones, se tiene que crear un Entorno, el cual será el entorno de trabajo. El mismo contará de un nervio que contiene fibras mielínicas, electrodos con los cuales se harán los registros y un estimulador con el cual obtendremos la señal de entrada al nervio. Manejaremos todos los elementos necesarios para realizar el experimento desde el Entorno.

Lo primero es importar el módulo:

```python
import simulacion
```

Para comenzar a simular, lo primero es crear un objeto de la clase Entorno.

```python
mi_experimento = simulacion.Entorno(nombre = 'Nervio ciático del sapo')
```

Lo siguiente es crear el objeto Nervio, el cual será el nervio de nuestro experimento. Al crear el nervio también se lo puebla con las fibras mielínicas y se agregan los nodos de Ranvier a dichas fibras. El siguiente ejemplo es con los datos del nervio ciático del sapo:

```python
mi_experimento.crear_nervio(diametro = 1500,
				                    longitud = 50000,
				                    num_fibras = 4000,
				                    diametro_fibra = 4.5,
				                    var_diametro = 1.5,
				                    distancia_nodos = 2000,
														conductividad_transversal=None,
				                    porcentaje_cobertura=100,
				                    metodo_poblacion='uniforme_con_superposicion',
					                  semilla=None,
				                    alfa=7.6,
				                    velocidad=None,
				                    variacion_nodos=0,
				                    distribucion_variacion='uniforme',
				                    desplazamiento=0)
```

Luego se crean los electrodos con los cuales realizaremos la medición de la actividad electrofisiológica del haz de fibras nerviosas mielínicas. Se necesita tener por lo menos 2 electrodos creados para poder calcular más adelante el Potencial de Acción Compuesto Diferencial. Al crear los electrodos estamos también calculando los pesos que cada nodo de Ranvier tiene al momento de la medición. A continuación se muestra la creación de dos electrodos:

```python
# Primer electrodo
mi_experimento.crear_electrodo(tipo = 'punto',
															 pos_x = 0,
															 pos_y = -750,
															 pos_z = 10000,
															 zona_influencia = 10000,
															 grosor=0,
															 funcion=simulacion.funcion_trapecio)
```

```python
# Segundo electrodo
mi_experimento.crear_electrodo(tipo = 'punto',
															 pos_x = 0,
															 pos_y = -750,
															 pos_z = 20000,
															 zona_influencia = 10000,
															 grosor=0,
															 funcion=simulacion.funcion_trapecio)
```

Por último, se crea el estímulo, el cual será la señal de entrada con la cual se estimularán todas fibras:

```python
mi_experimento.crear_estimulo(tipo_estimulo = 'potencial_de_accion',
															frec_muestreo = 100000,
															tiempo_estimulo = 0.003,
															tiempo_inicio = 0.001,
															frec_corte = 2000,
															orden_filtro = 2)
```

Con todos los elementos necesarios para realizar la medición creados ahora se puede calcular el Potencial de Acción Compuesto (CAP) para cada electrodo. El entorno tiene una lista con los electrodos creados, y los CAPs son guardados como atributo en cada objeto electrodo.

Para calcular los CAPs por cada electrodo se ejecuta la siguiente línea:

```python
mi_experimento.cap()
```

Por último, para calcular el Potencial de Acción Compuesto Diferencial entre dos electrodos se debe elegir entre qué electrodos se calculará, siendo el de la posicion_1 el positivo y el de la posicion_2 el negativo. En este ejemplo, se hará el CAP Diferencial entre los electrodos en la posición 0 y 1 de la lista de electrodos guardados en el objeto **mi_experimento** de la clase Entorno. Se ejecuta la siguiente línea:

```python
mi_experimento.cap_diferencial(posicion_1 = 0, posicion_2 = 1)
```

Para obtener las gráficas del estímulo, los CAPs y el CAP diferencial se ejecuta la siguiente línea:

```python
mi_experimento.graficas()
```

El código incluye métodos de visualización gráfica de la posición de las fibras en el nervio y de los electrodos respecto al nervio, como así también métodos para la obtención de archivos JSON, MAT y TXT con distinta información sobre el experimento. Los mismos se encuentran más detallados en la sección de Documentación de la API.

### Ejemplos

Ejemplo con el nervio infraorbitario de la rata:

```python
import simulacion

# Entorno
experimento_02 = simulacion.Entorno(nombre = 'Nervio infraorbitario de la rata')

# Nervio
experimento_02.crear_nervio(diametro = 1265,
				                    longitud = 50000,
				                    num_fibras = 5207,
				                    diametro_fibra = 4.5,
				                    var_diametro = 1.5,
				                    distancia_nodos = 2000,
														conductividad_transversal=None,
				                    porcentaje_cobertura=100,
				                    metodo_poblacion='uniforme_con_superposicion',
					                  semilla=None,
				                    alfa=7.6,
				                    velocidad=None,
				                    variacion_nodos=500,
				                    distribucion_variacion='uniforme',
				                    desplazamiento=500)
# Primer electrodo
experimento_02.crear_electrodo(tipo = 'circulo',
															 pos_x = 0,
															 pos_y = -800,
															 pos_z = 10000,
															 radio = 50,
															 zona_influencia = 10000,
															 grosor=1000,
															 funcion=simulacion.funcion_trapecio)
# Segundo electrodo
experimento_02.crear_electrodo(tipo = 'poligono',
															 pos_z = 20000,
															 lista_coordenadas = [(-100,-800),(-100,-750),(100,-750),(100,-800)],
														   zona_influencia = 10000,
													     grosor=1000,
														   funcion=simulacion.funcion_trapecio)

# Estimulo
experimento_02.crear_estimulo(tipo_estimulo = 'potencial_de_accion',
															frec_muestreo = 100000,
															tiempo_estimulo = 0.003,
															tiempo_inicio = 0.001,
															frec_corte = 2000,
															orden_filtro = 2)
# CAPs y CAP diferencial
experimento_02.cap()
experimento_02.cap_diferencial(posicion_1 = 0, posicion_2 = 1)
experimento_02.graficas()
```

Ejemplo con el nervio ciático de la rana comestible:

```python
import simulacion

# Entorno
experimento_03 = simulacion.Entorno(nombre = 'Nervio ciático de la rana comestible')

# Nervio
experimento_03.crear_nervio(diametro = 1300,
				                    longitud = 75000,
				                    num_fibras = 2700,
				                    diametro_fibra = 16,
				                    var_diametro = 6,
				                    distancia_nodos = 2000,
														conductividad_transversal=None,
				                    porcentaje_cobertura=100,
				                    metodo_poblacion='uniforme_con_superposicion',
					                  semilla=None,
				                    alfa=7.6,
				                    velocidad=None,
				                    variacion_nodos=0,
				                    distribucion_variacion='uniforme',
				                    desplazamiento=0)
# Primer electrodo
experimento_03.crear_electrodo(tipo = 'punto',
															 pos_x = 0,
															 pos_y = -650,
															 pos_z = 20000,										
															 zona_influencia = 4000,
															 grosor=1000,
															 funcion=simulacion.funcion_trapecio)
# Segundo electrodo
experimento_03.crear_electrodo(tipo = 'punto',
															 pos_x = 0,
															 pos_y = -650,
															 pos_z = 40000,										
															 zona_influencia = 4000,
															 grosor=1000,
															 funcion=simulacion.funcion_trapecio)

# Estimulo
experimento_03.crear_estimulo(tipo_estimulo = 'potencial_de_accion',
															frec_muestreo = 100000,
															tiempo_estimulo = 0.003,
															tiempo_inicio = 0.001,
															frec_corte = 2000,
															orden_filtro = 2)
# CAPs y CAP diferencial
experimento_03.cap()
experimento_03.cap_diferencial(posicion_1 = 0, posicion_2 = 1)
experimento_03.graficas()
```

## Documentación de la API

Ver archivo html/simulacion.html