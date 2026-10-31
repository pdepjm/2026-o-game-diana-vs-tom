import movimiento.*
import wollok.game.*

class Proyectil {
    var property position
    var property image = ["Uno_Claro.png","Cero_claro.png"].anyOne()
    const emisor     //quien  disparó 
    const direccion  //arriba, abajo, izquierda, derecha
    const velocidad = 80  
    const danio= 150     // milisegundos por paso
    //cada bala  tiene un nombre de tick diferente
    const bala = generadorDeBalas.siguienteId()
    method ataque() = danio
method disparar() {
    game.addVisual(self)
    game.onTick(velocidad, bala, {self.avanzar()})

    
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