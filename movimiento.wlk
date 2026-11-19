
import wollok.game.*
import escenario.*
import posicionValida.*
object movimiento {


    method configurarFlechas(personaje) {
        keyboard.up().whilePressedDo({ personaje.mover(arriba) }, 400)
        keyboard.down().whilePressedDo({ personaje.mover(abajo) }, 400)
        keyboard.left().whilePressedDo({ personaje.mover(izquierda) }, 400)
        keyboard.right().whilePressedDo({ personaje.mover(derecha) }, 400)

        keyboard.up().onReleaseDo{ personaje.dejarDeCaminar() }
        keyboard.down().onReleaseDo{ personaje.dejarDeCaminar() }
        keyboard.left().onReleaseDo{ personaje.dejarDeCaminar() }
        keyboard.right().onReleaseDo{ personaje.dejarDeCaminar() }

        keyboard.space().whilePressedDo({personaje.disparar()}, 400)
    }

    // La posición tiene que estar dentro de los límites y sin obstáculo
    method esPosicionValida(position) = posicionValida.esValida(position)
}

object izquierda {
    method siguiente(position) = position.left(10)
    method orientacion(actual, conVerticales) = "left"
}

object derecha {
    method siguiente(position) = position.right(10)
    method orientacion(actual, conVerticales) = "right"
}

object abajo {
    method siguiente(position) = position.down(10)
    method orientacion(actual, conVerticales) = if (conVerticales) "down" else actual
}

object arriba {
    method siguiente(position) = position.up(10)
    method orientacion(actual, conVerticales) = if (conVerticales) "up" else actual
}

