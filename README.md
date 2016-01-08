# HackerBooksS
**Práctica KCSMB II Fundamentos IOS (Swift)**

##Preguntas

**Procesado JSON ¿is, as?**

Según he averiguado, isKindOfClass te indica si un objeto desciende de la clase que le indicas. El procesado del JSON he presupuesto que lo que nos descargamos es un array de Libros, por falta de tiempo no he podido contemplar la posibilidad de que sea un libro solo. He usado el casteo de los campos con as?.

**¿Donde guardarías las imágenes de portada y los pdfs?**

Las he guardado en las Caches de NSFileManager, pues entiendo que ocuparan bastante espacio y así si es necesario se podria liberar.
He utilizado AGTAsyncImage en Objetive-C, queda pendiente portarla a swift
Los PDF de momento se descargan cada vez que los vas a leer, queda pendiente hacer la descarga a local.

**Favoritos**

Los favoritos lo resolvi añadiendolos como un tag más, y una propiedad computada, para modificarlo en tiempo de ejecución lo he resuelto con una notificación, que reciben el controlador de tabla y el de detalle y así cuando marcas o desmarcas un libro se ve reflejado en tiempo real tanto en la tabla como en la vista de detalle. También se podría haber hecho con delegado, pero con notificaciones da pie a más posibilidades en el futuro, poder marcar o desmarcar desde otras partes de la app los libros.

**reloadData**

Creo que el reloadData solo actualiza los datos que se ven en pantalla en ese momento por lo que no es crítico en el rendimiento, no conozco formas alternativas, quizá implementar un método propio con notificaciones, pero de todas formas en este caso que se podía cambiar el orden por dos criterios creo que no habria mucha diferencia ya que se volvian a cargar casi todos los datos.

##Extras

**a** Le añadiria opciones de añadir URL's personalizadas desde las que cargar libros o arrays de libros.

**b** De momento no lo he hecho, intente descargar las plantillas del enlace, pero te pedían un correo para enviarte los link y no me llego nada. Tampoco le dedique demasiado tiempo.

**c** Mejorándola un poco se podría utilizar como biblioteca de libros de pago, o de manuales o guías que tuvieras que desbloquear previo pago, por ejemplo.


##Comentarios

Después de las últimas modificaciones creo que ha quedado bastante mejor que al principio la app, aunque todavía se puede mejorar mucho.

Creo que hubo poco tiempo para entregar (Cuando nos pasasteis la guia ya quedaba menos de una semana y encima coincidia con el curso de Scrum) y que era más compleja de lo que parecía, o a lo mejor me he complicado yo solo con el UISegmentedControl, porque no he visto nadie mas que lo haya implementado... pero yo entendí que había que hacerlo así.

El modelo creo que me ha quedado bastante bien, implemente el multidiccionario con una estructura y funciona muy bien (Tampoco he visto a nadie más que lo haya hecho.

La navegación la he acabado haciendo desde 0 empezando con un proyecto splitview con segues, cuando en un principio lo estaba haciendo como dijiste con delegado y notificaciones, en eso he perdido unas 5h, en otro repo que tengo subido está esa primera versión que no conseguí que funcionara bien.

Me gustaría aprender como hacerlo sin las segues pues se pierde mucho el control de lo que pasa, a parte de la perdida de rendimiento que ya nos advertisteis en la clase.
