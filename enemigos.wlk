import escenario.*
import movimiento.*
import personaje.*
import ingeniero.*
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
 method atacarEnSuPosicion(){
    if(position == ingeniero.position()){
        ingeniero.recibirAtaque(self)
    }
 }
}

 object haskell inherits Enemigo(position = game.at(50, 50), vida = 3000){
    override method image () = "haskell_enojado.png"
    var ataque = 1000

    method ataque() = ataque
 }