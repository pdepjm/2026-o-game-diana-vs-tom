
import enemigos.*
import personaje.*
import movimiento.*

object ingeniero inherits Personaje(position = game.at(120, 20), vida = 1000) {

    override method morir() {
    super()
    game.removeTickEvent("cansancio")}

    override method image() =
    if (!self.estaVivo()) "caida.gif"
    else if (self.estaCaminando()) "final.gif"
    else "ingeniero_quieto.png"


    var property energia = 1000
    var property ataque = 200

    method empezarACansarse() {
        game.onTick(1000, "cansancio", { self.sueño(1) })
    }

    method sueño(cantidad) {
  energia = (energia - cantidad).max(0)
  self.modificarAtaque()
  if (energia == 0) { self.morir() }
}

    method sumarEnergia(cantidad) {
        energia = energia + cantidad
       
    }

    method modificarAtaque() {
    if(energia < 100){ ataque = ataque - 0.25*ataque} // si su energia es <100, pega un 25% menos
  }

    method sumarAtaque(cantidad) {
        ataque = ataque+cantidad
    }
}



