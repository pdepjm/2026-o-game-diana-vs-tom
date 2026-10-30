import escenario.*
import movimiento.*
import personaje.*
import ingeniero.*
class Enemigo inherits Personaje{

    var terminado = false

   method finalizarJuego() {
    if (not terminado) {
        terminado = true
        game.removeVisual(ingeniero)

        const pantalla = new PantallaFinal(
            position = game.at(70, 35)
        )

        game.addVisual(pantalla)
    }

}

method perseguir(personaje) {
    if (self.puedeActuar()) {
        self.acercarseA(personaje.position())
        if (self.alcanzo(personaje)) {
            self.finalizarJuego()
        }
    }
}

method puedeActuar() = not terminado and self.estaVivo()

method alcanzo(personaje) = position == personaje.position()

method acercarseA(objetivo) {
    const posibles = self.direccionesHacia(objetivo).filter({ direccion =>
        movimiento.esPosicionValida(direccion.siguiente(position))
    })
    if (not posibles.isEmpty()) {
        self.mover(posibles.first())
    }
}

method direccionesHacia(objetivo) {
    const diferenciaX = objetivo.x() - position.x()
    const diferenciaY = objetivo.y() - position.y()

    return if (diferenciaX.abs() >= diferenciaY.abs())
        self.prioridadHorizontal(diferenciaX)
    else
        self.prioridadVertical(diferenciaY)
}

method prioridadHorizontal(diferenciaX) =
    if (diferenciaX > 0) [derecha, arriba, abajo, izquierda]
    else [izquierda, arriba, abajo, derecha]

method prioridadVertical(diferenciaY) =
    if (diferenciaY > 0) [arriba, derecha, izquierda, abajo]
    else [abajo, derecha, izquierda, arriba]

   
method atacarEnSuPosicion() {
    if (not terminado and position == ingeniero.position()) {
        self.finalizarJuego()
    }
}
}


object prolog inherits Enemigo(position = game.at(50, 60), vida = 500) {
    override method prefijo() = "owl"

    // el búho se ve de frente: usa los mismos frames para los dos lados
    override method image() =
        if (self.estaCaminando()) "owl_right_" + self.frame() + ".png"
        else "owl_right_0.png"

    const ataque = 1000
    method ataque() = ataque
}


object haskell inherits Enemigo(position = game.at(50, 50), vida = 500) {
    override method prefijo() = "haskell"
    override method tieneFramesMuerte() = true

    const ataque = 1000
    method ataque() = ataque
}



class PantallaFinal {
    var property position

    method image() = "caida.gif"
}

object wollokEnemigo inherits Enemigo(position = game.at(60, 55), vida = 500) {
    override method prefijo() = "wollok"
    override method tieneFramesMuerte() = true
}