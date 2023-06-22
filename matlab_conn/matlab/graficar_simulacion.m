function [] = graficar_simulacion()
    %   GRAFICAR_SIMULACION Funcion que permite graficar las variables provenientes de archivo.mat, creado por la funcion NERVIO.
    %   Las variables son CAPdif (CAP diferencial, CAP1-CAP2), CAP1 (CAP del primer electrodo) y CAP2 (CAP del segundo electrodo)
    
    load ('archivo.mat')
    figure

    % Vm
    plot(t_vm,Vm,"black",'linewidth',0.5)

    hold on
    % CAP diferencial
    plot(t_cap,CAPdif,'Color','#0072BD','linewidth',1)

    % CAP del primer electrodo
    plot(t_cap,CAP1,'Color','#D95319','linewidth',1)

    % CAP del segundo electrodo
    plot(t_cap,CAP2,'Color','#77AC30','linewidth',1)

    title("Entorno")
    xlabel("x (micrómetros)")
    ylabel("y (micrómetros)")

    legend("Vm","CAPdif","CAP1","CAP2")
end