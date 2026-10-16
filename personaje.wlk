import movimiento.*
import proyectiles.*
class EfectoMuerte {
    var property position
    method image() = "caida.gif"
}

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
        const proyectil = new Proyectil(position = position, emisor = self, direccion = direccionActual)
        proyectil.disparar()
        
    }
        

  method recibirAtaque(atacante) {
        vida = (vida - atacante.ataque()).max(0)
        if (vida == 0) { self.morir() }
    }
  var vivo = true

    method estaVivo() = vivo
   method morir() {
        vivo = false
        game.removeVisual(self)                  // 1. desaparece el personaje

        const efecto = new EfectoMuerte(position = position)
        game.addVisual(efecto)                   // 2. aparece el gif
        game.schedule(3000, { game.removeVisual(efecto) })   // 3. desaparece el gif
    }

}
