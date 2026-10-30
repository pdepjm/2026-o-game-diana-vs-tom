import movimiento.*
import proyectiles.*

class EfectoMuerte {
    var property position
}

class EfectoVictoria {
    var property position
    method image() = "haskell_muerte4.gif"
   
}

/*object victoriaHaskell inherits EfectoVictoria{
    override method image() = "haskell_muerte4.gif"
}*/

class Personaje {
    var property position
    var caminando = false
    var property vida
    var property direccionActual = derecha
    method image()
  
    method empezarACaminar() { caminando = true }
    method dejarDeCaminar() { caminando = false }
    method estaCaminando() = caminando

    method mover(direccion) {
        self.empezarACaminar()
        direccionActual = direccion
        const nuevaPosicion = direccion.siguiente(position)
        if (movimiento.esPosicionValida(nuevaPosicion)) {
            position = nuevaPosicion
        }
    }
    method disparar(){
       const proximaPos = direccionActual.siguiente(position)
    if (movimiento.esPosicionValida(proximaPos)) {
        const proyectil = new Proyectil(
            position = proximaPos, // Un paso adelante
            emisor = self, 
            direccion = direccionActual
        )
        proyectil.disparar()
    }
    }
        

  method recibirAtaque(atacante) {
        vida = (vida - atacante.ataque()).max(0)
        if (vida == 0) { self.morir() }
    }
  var vivo = true

    method estaVivo() = vivo
   method morir() {
        vivo = false
        game.removeVisual(self)                  

        const efecto = new EfectoMuerte(position = position)
        game.addVisual(efecto)                 
        game.schedule(3000, { game.removeVisual(efecto) })  
    }

}
