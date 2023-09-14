% HOLA MISS, ESTE ES SU CÓDIGO PERO YA ME ANDO PONIENDO PILAS PARA EL SIGUIENTE
%Base de conocimientos.
%lugares.
lugar(zihuatanejo).
lugar(acapulco).
lugar(cancun).
lugar(rivera_maya).
lugar(rivera_nayarit).
lugar(mazatlan).
lugar(zacatecas).

%lugares y precio.
lugar_precio(zihuatanejo,2000).
lugar_precio(acapulco,1930).
lugar_precio(cancun,2340).
lugar_precio(rivera_maya,2890).
lugar_precio(rivera_nayarit,5010).
lugar_precio(mazatlan,3450).
lugar_precio(zacatecas,2200).

%costo hotel por noche.
lugar_hotel(zihuatanejo,1500).
lugar_hotel(acapulco,1500).
lugar_hotel(cancun,2900).
lugar_hotel(rivera_maya,4000).
lugar_hotel(rivera_nayarit,3000).
lugar_hotel(mazatlan,2150).
lugar_hotel(zacatecas,1050).

%All inclusive o no inclusive.
lugar_all_inclusive(zihuatanejo,1).
lugar_all_inclusive(acapulco,1).
lugar_all_inclusive(mazatlán,1).
lugar_all_inclusive(zacatecas,1).
lugar_all_inclusive(cancún,0).
lugar_all_inclusive(rivera_maya,0).
lugar_all_inclusive(rivera_nayarit,0).

%Costo de comidas.
costo_comida(zihuatanejo,0).
costo_comida(acapulco,0).
costo_comida(cancun,700).
costo_comida(rivera_maya,700).
costo_comida(rivera_nayarit,700).
costo_comida(mazatlan,0).
costo_comida(zacatecas,0).

%Base de conocimientos, Fin.

%Reglas AND.
precio_viaje(A,N):-lugar(A),lugar_precio(A,B),N is B.
precio_hotel(A,N):-lugar(A),lugar_hotel(A,B),N is B.
precio_viaje_hotel(A,N):-lugar(A),precio_viaje(A,B),precio_hotel(A,C),N is B+C.
all_inclusive(A,B):-lugar(A),lugar_all_inclusive(A,B),(B > 0 -> write(A),writeln(' Es All Inclusive'); write(A),writeln(' No Es All Inclusive')).
precio_comidas(A,D,P,N):-lugar(A),N is D*P*700.
edad_descuento(A):-(A < 11 -> writeln('Aplica Descuento Gratis.'); writeln('Aplica Descuento Del %30.')).
personas_habitación(A,N):-(A < 3,N < 2 -> writeln('No Aumenta El Precio'); writeln('Aumenta El Precio Un %10.')).

%Reglas OR.
%viaja_por_mexico(P,A,N,D,L):-(write('Tu presupuesto es de: '),write(P),write(' Con '),write(A),write(' Adultos Y '),write(N),write(' Niños, Vas A Pasar '),write(D),write(' Días En '),write(L),writeln('.')).

%La familia Ramirez esta por esposo, esposa, dos hijos(5 y 11 años respectivamente) y la madre de la esposa con 5 días de vacaciones
viaja_por_mexico(Lugar,Dias,Total):-
    lugar(Lugar),
    lugar_precio(Lugar,A),
    lugar_hotel(Lugar,B),
    costo_comida(Lugar,C),
    Dias>2,Dias<6, Total is (A*4) +
    ((B*1.1)*Dias) +
    ((C*2+(C *0.70))*Dias),
  Total < 40000.
  
%Si van el y la esposa solos, irian a Riviera maya
viaja_rivera_maya(Dias,Total):-
    lugar_precio(rivera_maya,A),
    lugar_hotel(rivera_maya,B),
    costo_comida(rivera_maya,C),
    Dias>2,Dias<6, Total is (A*2) +
    (B*Dias) + ((C*2)*Dias)
    ,Total < 40000.
  
%Si van los dos niños, va la abuela
viaja_con_mama(Lugar,Dias,Total):-
    lugar(Lugar),
    lugar_precio(Lugar,A),
    lugar_hotel(Lugar,B),
    costo_comida(Lugar,C),
    Dias>2,Dias<6, Total is (A*5) +
    ((B*1.1)*Dias) +
    (B*Dias) +
    ((C*3+(C *0.70))*Dias)
    ,Total < 40000.

%Si va la abuela, puede ir solo un niño, el de 5 años probablemente
viaja_con_solo_un_hijo(Lugar,Dias,Total):-
    lugar(Lugar),
    lugar_precio(Lugar,A),
    lugar_hotel(Lugar,B),
    costo_comida(Lugar,C),
    Dias>2,Dias<6, Total is (A*3) +
    ((B*Dias)*2) +
    ((C*2)*Dias)
    ,Total < 40000.