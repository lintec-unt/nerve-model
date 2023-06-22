import argparse
import simulacion


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument('-a', '--diametro', type=float, help="Diametro del nervio")
    parser.add_argument('-b', '--longitud', type=float, help="Longitud del nervio")
    parser.add_argument('-c', '--num_fibras', type=int, help='Numero de fibras en el nervio')
    parser.add_argument('-d', '--diametro_fibra', type=float, help='Diametro de las fibras')
    parser.add_argument('-e', '--var_diametro', type=float, help='Variacion del diametro de las fibras')
    parser.add_argument('-f', '--distancia_nodos', type=float, help='Distancia promedio entre nodos')
    parser.add_argument('-g', '--conductividad_transversal', type=float, help='Conductividad transversal')
    parser.add_argument('-i', '--pos_z1', type=float, help='Posicion en el eje z del primer electrodo')
    parser.add_argument('-j',
                        '--zona_influencia_1',
                        type=float,
                        help='Zona de influencia en el eje z del primer electrodo')
    parser.add_argument('-k', '--pos_z2', type=float, help='Posicion en el eje z del segundo electrodo')
    parser.add_argument('-l',
                        '--zona_influencia_2',
                        type=float,
                        help='Zona de influencia en el eje z del segundo electrodo')
    parser.add_argument('-m', '--frec_muestreo', type=float, help='Frecuencia de muestreo')
    parser.add_argument('-n', '--tiempo_estimulo', type=float, help='Tiempo total de estimulo')
    parser.add_argument('-o', '--tiempo_inicio', type=float, help='Tiempo de inicio')
    parser.add_argument('-p', '--frec_corte', type=float, help='Frecuencia de corte del filtro')
    parser.add_argument('-q', '--orden_filtro', type=int, help='Orden del filtro')

    args = parser.parse_args()

    #Creacion del nervio
    entorno = simulacion.Entorno()

    entorno.crear_nervio(diametro=args.diametro,
                         longitud=args.longitud,
                         num_fibras=args.num_fibras,
                         diametro_fibra=args.diametro_fibra,
                         var_diametro=args.var_diametro,
                         distancia_nodos=args.distancia_nodos,
                         conductividad_transversal=args.conductividad_transversal,
                         porcentaje_cobertura=100,
                         metodo_poblacion='uniforme_con_superposicion',
                         semilla=None,
                         alfa=7.6,
                         velocidad=None,
                         variacion_nodos=0,
                         distribucion_variacion='uniforme',
                         desplazamiento=0)

    # Primer electrodo
    entorno.crear_electrodo(tipo='punto',
                            pos_x=0,
                            pos_y=-args.diametro / 2,
                            pos_z=args.pos_z1,
                            zona_influencia=args.zona_influencia_1,
                            grosor=0,
                            funcion=simulacion.funcion_trapecio)

    # Segundo electrodo
    entorno.crear_electrodo(tipo='punto',
                            pos_x=0,
                            pos_y=-args.diametro / 2,
                            pos_z=args.pos_z2,
                            zona_influencia=args.zona_influencia_2,
                            grosor=0,
                            funcion=simulacion.funcion_trapecio)

    entorno.crear_estimulo(tipo_estimulo='potencial_de_accion',
                           frec_muestreo=args.frec_muestreo,
                           tiempo_estimulo=args.tiempo_estimulo,
                           tiempo_inicio=args.tiempo_inicio,
                           frec_corte=args.frec_corte,
                           orden_filtro=args.orden_filtro)

    entorno.cap()
    entorno.cap_diferencial(posicion_1=0, posicion_2=1)
    entorno.archivo_matlab()


if __name__ == "__main__":
    main()