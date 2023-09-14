/***************************INTELIGENCIA ARTIFICIAL***************/
/****************************EJEMPLO COVID19**********************/

:- dynamic  y/1.
:- dynamic n/1.

% DECLARACIÓN DE LOS OPERADORES

 :- op(1115, fx, si).
 :- op(1110, xfy, entonces).
 :- op(1100, xfy, o).
 :- op(1000, xfy, y).
 :- op(900, fx, no).

%R1: Si tiene fiebre entonces es covid
regla(si tiene_fiebre(Enfermedad) entonces covid(Enfermedad)).
%R2: Si tiene fiebre alta entonces es influenza
regla(si tiene_fiebre_alta(Enfermedad) entonces influenza(Enfermedad)).
%R3: Si tiene fiebre baja entonces es gripa
regla(si tiene_fiebre_baja(Enfermedad) entonces gripa(Enfermedad)).
%R4: Si tiene tos entonces es covid
regla(si tiene_tos(Enfermedad) entonces covid(Enfermedad)).
%R5: Si tiene tos seca entonces es influenza
regla(si tiene_tos_seca(Enfermedad) entonces influenza(Enfermedad)).
%R6: Si tiene tos humeda entonces es gripa
regla(si tiene_tos_humeda(Enfermedad) entonces gripa(Enfermedad)).
%R7: Si tiene dificultad para respirar entonces es covid
regla(si tiene_dificultad_respirar(Enfermedad) entonces covid(Enfermedad)).
%R8: Si tiene congestion nasal entonces es influenza
regla(si tiene_congestion_nasal(Enfermedad) entonces influenza(Enfermedad)).
%R9: Si tiene congestion nasal entonces es gripa
regla(si tiene_congestion_nasal(Enfermedad) entonces gripa(Enfermedad)).
%R10: Si tiene perdida del olfato entonces es covid
regla(si tiene_perdida_olfato(Enfermedad) entonces covid(Enfermedad)).
%R11: Si tiene dolor de cabeza entonces es influenza
regla(si tiene_dolor_cabeza(Enfermedad) entonces influenza(Enfermedad)).
%R12: Si tiene estornudos entonces es gripa
regla(si tiene_estornudos(Enfermedad) entonces gripa(Enfermedad)).
%R13: Si tiene fatiga entonces es covid
regla(si tiene_fatiga(Enfermedad) entonces covid(Enfermedad)).
%R14: Si tiene dolores musculares entonces es influenza
regla(si tiene_dolores_musculares(Enfermedad) entonces influenza(Enfermedad)).
%R15: Si tiene dolor de garganta entonces es covid
regla(si tiene_dolor_garganta(Enfermedad) entonces covid(Enfermedad)).
%R16: Si tiene dolor de garganta entonces es influenza
regla(si tiene_dolor_garganta(Enfermedad) entonces influenza(Enfermedad)).

identificar :- hipotesis(Enfermedad),
      write('Pienso que la enfermedad es: '),
      write(Enfermedad),
      nl,
      undo.

%HIPOTESIS
hipotesis(covid)     :- covid, !.
hipotesis(influenza)     :- influenza, !.
hipotesis(gripa)    :- gripa, !.
hipotesis(desconocido).     /* sin diagnostico */

%VERIFICAR REGLAS
covid :- verify(tiene_dolor_de_garganta), verify(tiene_fatiga),!.
influenza :- verify(tiene_dolores_musculares), !.
influenza :- verify(tiene_dolor_de_garganta).
gripa :- verify(tiene_estornudos), verify(tiene_congestion_nasal).

%SALIDA AL EDITOR
ask(Question) :-
    write('La persona tiene el siguiente síntoma : '),
    write(Question),
    write('? '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      ->
       assert(y(Question)) ;
       assert(n(Question)), fail).

verify(S) :-
   (y(S)
    ->
    true ;
    (n(S)
     ->
     fail ;
     ask(S))).


undo :- retract(y(_)),fail.
undo :- retract(n(_)),fail.
undo.
