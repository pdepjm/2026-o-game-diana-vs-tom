import movimiento.*
import wollok.game.*
import audio.*

class Proyectil {
    var property position
    const emisor     //quien  disparó
    const direccion  //arriba, abajo, izquierda, derecha
    var property velocidad = 80    // milisegundos por paso
    var danio = 30
    //cada bala  tiene un nombre de tick diferente
    const bala = generadorDeBalas.siguienteId()

    var image

    method image() = image

    method ataque() = danio

    method disparar() {
        generadorDeBalas.registrar(self)
        game.addVisual(self)
        game.onTick(self.velocidad(), bala, {self.avanzar()})
        audio.efecto(audio.sonidoDisparo())

        game.onCollideDo(self, {objetivo => self.impactar(objetivo)}) // si choca un personaje
    }

    method impactar(objetivo) {
        if (objetivo != emisor and objetivo != self) {
            objetivo.recibirAtaque(self)
            self.destruir()
        }
    }

    method avanzar() {
        const proximaPosicion = direccion.siguiente(position)

        if (movimiento.esPosicionValida(proximaPosicion)) {
            position = proximaPosicion
        } else {
            self.destruir()
        }
    }

    method destruir(){
        generadorDeBalas.olvidar(self)
        game.removeTickEvent(bala)// apagamos reloj de movimiento de la bala
        if (game.hasVisual(self)){
            game.removeVisual(self) //borra la visual de bala
        }
    }
}


object generadorDeBalas {
    var numero = 0
    const activas = []   // balas en el aire, para poder limpiarlas al terminar un nivel

    method siguienteId(){
        numero = numero + 1
        return "bala_" + numero
    }

    method registrar(bala) {
        activas.add(bala)
    }

    method olvidar(bala) {
        activas.remove(bala)
    }

    // destruye todas las balas que sigan en el aire
    method limpiar() {
        activas.map({ bala => bala }).forEach({ bala => bala.destruir() })
    }
}