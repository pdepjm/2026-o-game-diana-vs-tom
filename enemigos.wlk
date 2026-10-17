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
    if (not terminado) {
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

 object haskell inherits Enemigo(position = game.at(50, 50), vida = 3000){
    override method image () = "haskell_enojado.png"
    const ataque = 1000

    method ataque() = ataque
 }

class PantallaFinal {
    var property position

    method image() = "caida.gif"
}