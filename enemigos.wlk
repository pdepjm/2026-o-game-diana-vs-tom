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
    if (not terminado and self.estaVivo()) {
        const diferenciaX = personaje.position().x() - position.x()
        const diferenciaY = personaje.position().y() - position.y()

        const direcciones = if (diferenciaX.abs() >= diferenciaY.abs()) {
            if (diferenciaX > 0) [derecha, arriba, abajo, izquierda]
            else [izquierda, arriba, abajo, derecha]
        } else {
            if (diferenciaY > 0) [arriba, derecha, izquierda, abajo]
            else [abajo, derecha, izquierda, arriba]
        }

        const posibles = direcciones.filter({ direccion =>
            movimiento.esPosicionValida(direccion.siguiente(position))
        })

        if (not posibles.isEmpty()) {
            self.mover(posibles.first())
        }

        if (position == personaje.position()) {
            self.finalizarJuego()
        }
    }
}

   
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