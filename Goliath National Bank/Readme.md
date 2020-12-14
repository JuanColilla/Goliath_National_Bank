
                                            Comentarios
1. Mi intención principal era hacer uso de RealmSwift inyectándolo mediante CocoaPods, pero no ha sido posible dado que tengo algún conflicto en el Terminal que no he sabido resolver, de todas formas para inyectar una dependencia con CocoaPods basta con (teniendolo instalado) entrar en la carpeta del proyecto desde Terminal, escribir "pod init" posteriormente entrar en el Podfile con TextEdit, añadir las dependencias en su correspondiente sección, guardar y desde terminal ejecutar "pod install", una vez hecho bastará con trabajar desde el archivo ".xcworkspace" que es generado automáticamente.

2. Tenía intención de documentar todo el código pero creo que me he quedado al 75% aproximadamente, también he ido saltando entre Castellano e Inglés según cuando lo documentase.

3. A última hora la pantalla de bienvenida al usuario que pretendía mostrar "at first launch" ha entrado en conflicto con el DataFlow de CoreData y debido a la escasez de tiempo he decidido comentar dicha función, está en el ViewController principal (SKUListVC).

4. He hecho uso de Swift Package Manager para inyectar una dependencia muy útil y sencilla que permite mover las vistas para que el teclado nunca llegue a solaparse con los TextFields, aunque debido al punto 3 ésta función no será visible en ningún momento.

5. Los iconos y assets de la aplicación han costado 5 minutos, por lo que pese a no ser requeridos los he implementado ya que visualmente ayudaban a apreciar mejor la app.

6. Finalmente no he podido añadir localización a este proyecto, de todas formas queda constancia en Places de que es algo que conozco.

Gracias por la atención 🤗

