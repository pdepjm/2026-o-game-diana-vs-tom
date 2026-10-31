import movimiento.*
import wollok.game.*

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
        game.addVisual(self)
        game.onTick(self.velocidad(), bala, {self.avanzar()})

        
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
        
        game.removeTickEvent(bala)// apagamos reloj de movimiento de la bala
        if (game.hasVisual(self)){
            game.removeVisual(self) //borra la visual de bala
        }
    }
} 


object generadorDeBalas {
    var numero = 0;
    method siguienteId(){
        numero = numero + 1
        return "bala_" + numero
    }
}