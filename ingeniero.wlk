
import enemigos.*
import personaje.*
import movimiento.*
import Corazones.*
import proyectiles.*
import niveles.*

object ingeniero inherits Personaje(position = game.at(120, 20), vida = 300) {

    var property energia = 1000
    var property ataque = 200

    override method prefijo() = "ingeniero"
    override method cantidadFrames() = 2

    override method imagenProyectil() = ["Uno_Claro.png","Cero_claro.png"].anyOne()

    override method morir() {
    super()
    game.removeTickEvent("cansancio")
    gestorNiveles.perder()
    }

    override method recibirAtaque(atacante) {
    super(atacante)
    corazones.actualizar(vida)
}

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



