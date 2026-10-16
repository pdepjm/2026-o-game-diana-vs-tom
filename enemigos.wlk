import escenario.*
import movimiento.*
import personaje.*
class Enemigo inherits Personaje{

 method moverseAlAzar() {
    const posVecinas = [
        izquierda.siguiente(position), 
        derecha.siguiente(position), 
        arriba.siguiente(position), 
        abajo.siguiente(position)]

    const posibles = posVecinas.filter{pos => movimiento.esPosicionValida(pos)}
    if(not posibles.isEmpty()){
        position = posibles.anyOne()
    }

 }
 method ataque () = 10
 }

 object haskell inherits Enemigo(position = game.at(110, 40), vida = 3000){
    override method image () = "haskell_enojado.jpeg"
 }