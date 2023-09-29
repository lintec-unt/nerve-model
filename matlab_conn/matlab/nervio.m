function nervio(diametro,longitud,num_fibras,diametro_fibra,var_diametro,distancia_nodos,conductividad_transversal,pos_z1,zona_influencia_1,pos_z2,zona_influencia_2,frec_muestreo,tiempo_impulso,tiempo_inicio,frec_corte,orden_filtro)    
    % NERVIO Simula un experimento donde se miden los Potenciales de Acción Compuesto (CAP) en un haz de fibras mielínicas. 
    % 
    %  nervio(diametro,longitud,num_fibras,diametro_fibra,var_diametro,distancia_nodos,conductividad_transversal,pos_z1,zona_influencia_1,pos_z2,zona_influencia_2,frec_muestreo,tiempo_impulso,tiempo_inicio,frec_corte,orden_filtro)
    % 
    %  Devuelve un archivo.mat con la información sobre el experimento:
    %    CAP1 (CAP del primer electrodo)
    %    CAP2 (CAP del segundo electrodo)
    %    CAPdif (CAP diferencial, CAP1-CAP2)
    %    t_cap (Vector tiempo necesario para representar los CAPs)
    %    t_vm (Vector tiempo necesario para representar el potencial de accion Vm)
    %
    %  Argumentos de entrada:
    %    diametro (float): Diámetro del nervio. En micrometros.
    %    longitud (float): Longitud del nervio. En micrometros.
    %    num_fibras (int): Numero de fibras mielinicas que se encuentran en el nervio. En micrometros.
    %    diametro_fibra (float): Diametro promedio de las fibras. En micrometros.
    %    var_diametro (float): Variacion del diametro de las fibras. En micrometros.
    %    distancia_nodos (float): Distancia promedio entre los nodos de las fibras.  En micrometros.  
    %    conductividad_transversal (float): Valor de la conductividad transversal. Entre 0 y 1.
    %    pos_z1 (float): Posición en el eje z del primer electrodo. En micrometros.
    %    zona_influencia_1 (float): Zona de influencia en el eje z del primer electrodo. En micrometros.
    %    pos_z2 (float): Posición en el eje z del segundo electrodo. En micrometros.
    %    zona_influencia_2 (float): Zona de influencia en el eje z del segundo electrodo. En micrometros.
    %    frec_muestreo (float): Frecuencia de muestreo. En Hz.
    %    tiempo_impulso (float): Tiempo de duracion del impulso. En segundos.
    %    tiempo_inicio (float): Inicio del impulso. En segundos.
    %    frec_corte (float): Frencuencia de corte del filtro Butterworth (para lograr el potencial de accion). En Hz.
    %    orden_filtro (int): Orden del filtro Butterworth.

    cmd = sprintf(".\\MATLAB_simulacion\\entorno_virtual\\Scripts\\python.exe .\\MATLAB_simulacion\\python\\p.py --diametro %d --longitud %d --num_fibras %d --diametro_fibra %d --var_diametro %d --distancia_nodos %d --conductividad_transversal %d --pos_z1 %d --zona_influencia_1 %d --pos_z2 %d --zona_influencia_2 %d --frec_muestreo %d --tiempo_impulso %d --tiempo_inicio %d --frec_corte %d --orden_filtro %d",diametro,longitud,num_fibras,diametro_fibra,var_diametro,distancia_nodos,conductividad_transversal,pos_z1,zona_influencia_1,pos_z2,zona_influencia_2,frec_muestreo,tiempo_impulso,tiempo_inicio,frec_corte,orden_filtro);
    system(cmd);

end

