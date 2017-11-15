inicio:-
  consult('C:/SistemaExperto/adquisicion.pl'),
  main.
main:-
  new(Frame,dialog('Sistema Experto de limpieza de objetos')),
  send(Frame,size,size(650,350)),

  send(Frame,append,new(Menu,menu_bar)),
  mostrar('C:/SistemaExperto/recursos/sistemaexperto.jpg',Frame,Menu),

  new(BotonIniciar,button('Iniciar sistema',and(message(@prolog,iniciar),
    message(Frame,free),
    message(Frame,destroy)))),
  new(BotonAgregar,button('Experto',and(message(@prolog,adquirir),
    message(Frame,free),
    message(Frame,destroy)))),
  new(BotonSalir,button('Salir',and(message(@prolog,salir),
           message(Frame,free),
           message(Frame,destroy)))),
  send(Frame,append,BotonIniciar),
  send(Frame,append,BotonAgregar),
  send(Frame,append,BotonSalir),

  send(Frame,open,point(300,0)).

iniciar:-
     new(Frame,dialog('Formulario')),
    send(Frame,append,new(Menu,menu_bar)),
    mostrar('C:/SistemaExperto/recursos/productos-limpieza.jpg',Frame,Menu),

    send_list(Frame,append,[new(Pregunta1,menu('¿De que material esta hecho el articulo que quiere limpiar?',cycle)),
      new(Pregunta2,menu('¿Que quiere limpiar?',cycle)),
      new(Pregunta3,menu('¿Que suciedad presenta el objeto?',cycle)),
      new(Pregunta4,menu('¿Cuanto tiempo lleva sucio el articulo?', cycle)),
      new(Pregunta5,menu('¿Como es la composicion de la suciedad?',cycle))]),
    send_list(Pregunta1,append,['Madera','Metal','Plastico']),
    send_list(Pregunta2,append,['Muebles','Utencilios de cocina','Juguetes']),
    send_list(Pregunta3,append,['Pintura','Lodo','Comida']),
    send_list(Pregunta4,append,['Ahora','30 min','1 Hora']),
    send_list(Pregunta5,append,['Humedo','Seco']),
    send(Pregunta1,alignment,left),
    send(Pregunta2,alignment,left),
    send(Pregunta3,alignment,left),
    send(Pregunta4,alignment,left),
    send(Pregunta5,alignment,left),


    new(BotonRegresar,button('Regresar al menu principal',and(message(@prolog,main),
        message(Frame,free),
        message(Frame,destroy)))),
    new(BotonEnviar,button('Consultar',and(message(@prolog,respuesta,
          Pregunta1?selection,
          Pregunta2?selection,
          Pregunta3?selection,
          Pregunta4?selection,
          Pregunta5?selection),
        message(Frame,free),
        message(Frame,destroy)))),
     new(BotonSalir,button('Salir',and(message(@prolog,salir),
           message(Frame,free),
           message(Frame,destroy)))),
    send(Frame,append,BotonRegresar),
    send(Frame,append,BotonEnviar),
    send(Frame,append,BotonSalir),
    send(Frame,open,point(450,100)).

adquirir:-
  new(Frame,dialog('Formulario Experto')),
  send(Frame,append,new(Menu,menu_bar)),
  mostrar('C:/SistemaExperto/recursos/Cerebro.jpg',Frame,Menu),

 send_list(Frame,append,[new(Pregunta1,menu('¿De que material esta hecho?',cycle)),
                          new(Pregunta2,menu('¿Que quiere limpiar?',cycle)),
                          new(Pregunta3,menu('¿Que suciedad presenta el objeto?',cycle)),
                          new(Pregunta4,menu('¿Cunto tiempo lleva sucio?',cycle)),
                          new(Pregunta5,menu('¿Como es la composicion de la sucidedad?',cycle)),

new(Nombrenuevo,text_item('¿Escribe la respuesta?')),
                          new(Descripcion,text_item('Escribe la explicacion de los pasos:'))

                         ]),

   send_list(Pregunta1,append,['Madera','Plastico','Metal']),
   send_list(Pregunta2,append,['Muebles','Utencilios de cocina','Juguetes']),
   send_list(Pregunta3,append,['Pintura','Lodo','Comida']),
   send_list(Pregunta4,append,['Ahora','30 min', '1 Hora']),
   send_list(Pregunta5,append,['Humedo','Seco']),
   send_list(Nombrenuevo,append,['']),
   send_list(Descripcion,append,['']),

   send(Pregunta1,alignment,left),
   send(Pregunta2,alignment,left),
   send(Pregunta3,alignment,left),
   send(Pregunta4,alignment,left),
   send(Pregunta5,alignment,left),
   send(Nombrenuevo,alignment,left),
   send(Descripcion,alignment,left),

   new(BotonRegresar,button('Regresar al menu principal',and(message(@prolog,main),
      message(Frame,free),
      message(Frame,destroy)))),
   new(BotonEnviar,button('Enviar',and(message(@prolog,guardar,
    Pregunta1?selection,
    Pregunta2?selection,
    Pregunta3?selection,
    Pregunta4?selection,
    Pregunta5?selection,
    Nombrenuevo?selection,
    Descripcion?selection),
    message(Frame,free),
    message(Frame,destroy)))),
    new(BotonSalir,button('Salir',and(message(@prolog,iniciar),
           message(Frame,free),
           message(Frame,destroy)))),
   send(Frame,append,BotonRegresar),
   send(Frame,append,BotonEnviar),
   send(Frame,append,BotonSalir),
   send(Frame,open,point(470,50)).
%%%%%%%%%%%%%MÃ‰TODO RESPUESTA QUE COMPARA CON LA BASE DE HECHOS

respuesta(R1,R2,R3,R4,R5):-
  findall(Nombre,acc(R1,R2,R3,R4,R5,Nombre,Descri),Resultado),
  findall(Descri,acc(R1,R2,R3,R4,R5,Nombre,Descri),_),
  length(Resultado,Longitud),
  Longitud is 0,desplegarerror.

respuesta(R1,R2,R3,R4,R5):-
  findall(Nombre,acc(R1,R2,R3,R4,R5,Nombre,Descri),Resultado),
  findall(Descri,acc(R1,R2,R3,R4,R5,Nombre,Descri),Descripcion),
  length(Resultado,Longitud),
  Longitud >= 1,desplegarencontrado(Descripcion,Resultado).


acc(R1,R2,R3,R4,R5,Nombre,Descri):-
  acc1(R1,R2,R3,R4,R5,Nombre,Descri).



desplegarerror:-
  new(Frame,dialog('No conozco la respuesta, ¿Deseas agregarla?')),
  mostrar2('C:/SistemaExperto/recursos/error.jpg',Frame),
  new(BotonRegresar,button('No agregar',and(message(@prolog,main),
    message(Frame,free),
    message(Frame,destroy)))),
  new(BotonAgregar,button('Agregar a la base de conocimiento',and(message(@prolog,adquirir),
    message(Frame,free),
    message(Frame,destroy)))),
    send(Frame,append,BotonRegresar),send(Frame,append,BotonAgregar)  ,
    send(Frame,open).

desplegarencontrado(Descripcion,Nombre):-
  new(Frame,dialog('Respuesta Experto')),
  send(Frame,size,size(500,400)),
  send(Frame,scrollbars,vertical),
  cabeza(Descripcion,Nombre,CabezaD,CabezaN,ColaD,ColaN),
  %concat('C:/SistemaExperto/recursos/',CabezaI,Ext),
  %concat(Ext,'.jpg',Ruta),
  %mostrar3(Ruta,Frame),
  send(Frame,append(label(n,'Materiales: ',font('sans','bold',16)))),
  send(Frame,append(label(n,CabezaN,font('sans','serif',18)))),
    new(BotonExplicacion,button('Explicación',and(message(@prolog,explicacion,CabezaD),
      message(Frame,free),
      message(Frame,destroy)))),
  send(BotonExplicacion,alignment,left),

  send(Frame,append,BotonExplicacion),
  send(Frame,open),
  desplegarencontrado(ColaD,ColaN).

cabeza([CabezaD|ColaD],[CabezaN|ColaN],CabezaD,CabezaN,ColaD,ColaN):-!.

guardar(_,_,_,_,_,_,Des):-
  Des == '',error.

guardar(_,_,_,_,_,Nom,_):-
  Nom=='',error.

guardar(P1,P2,P3,P4,P5,Nomb,Desc):-
  new(Frame,dialog('Se guardo exitosamente')),
  send(Frame,size,size(450,600)),
  mostrar2('C:/SistemaExperto/recursos/correcto.jpg',Frame),
  send(Frame,append(label(n,'Los materiales:',font('sans','serif',18)))),
  send(Frame,append(label(n,Nomb,font('sans','serif',18)))),
  send(Frame,append(label(n,' ha sido guardado exitosamente',font('sans','serif',18)))),

  new(BotonRegresar,button('Regresar a agregar conocimiento',and(message(@prolog,adquirir),
      message(Frame,free),
      message(Frame,destroy)))),
  send(Frame,append,BotonRegresar),

  send(Frame,open,point(670,200)),
  tell('C:/SistemaExperto/adquisicion.pl'),
  assert(acc1(P1,P2,P3,P4,P5,Nomb,Desc)),
  listing(acc1),
  told.

 error:-
  new(Frame,dialog('Error!!!')),
  send(Frame,size,size(550,450)),

  send(Frame,append(label(n,'Favor de llenar los campos',font('sans','serif',18)))),
  new(BotonRegresar,button('Aceptar',and(message(@prolog,adquirir),
      message(Frame,free),
      message(Frame,destroy)))),
  send(Frame,append,BotonRegresar),
  send(Frame,open,point(470,100)).

explicacion(Expli):-
  new(Frame,dialog('Explicación')),
	send(Frame,size,size(700,150)),
    send(Frame,scrollbars,horizontal),
    send(Frame,append(label(n,'Descripción: ',font('sans','bold',16)))),
    send(Frame,append(label(n,Expli,font('sans','serif',12)))),
    new(BotonAceptar,button('Aceptar',and(message(Frame,free),
        message(Frame,destroy)))),
    send(Frame,append,BotonAceptar),
    send(Frame,open).

mostrar(Ruta,Frame,Menu):-
      new(Imagen,image(Ruta)),
      new(Imagen2,bitmap(Imagen)),
      new(Figura,figure),
      send(Figura,display,Imagen2),
      send(Frame,display,Figura),
      send(Figura,alignment,center),
      send(Figura,below(Menu)).
mostrar2(Ruta,Frame):-
      new(Imagen,image(Ruta)),
      new(Imagen2,bitmap(Imagen)),
      new(Figura,figure),
      send(Figura,display,Imagen2),
      send(Figura,alignment,center),
      send(Frame,display,Figura).
mostrar3(Ruta,Frame):-
      new(Imagen,image(Ruta)),
      new(Imagen2,bitmap(Imagen)),
      new(Figura,figure),
      send(Figura,display,Imagen2),
      send(Figura,alignment,left),
      send(Frame,display,Figura).
salir:-!.
