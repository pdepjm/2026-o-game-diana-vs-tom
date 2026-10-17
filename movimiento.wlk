
import wollok.game.*
import escenario.*

object movimiento {

    // Límites del tablero
    const limiteMinX = 1
    const limiteMaxX = 140
    const limiteMinY = 1
    const limiteMaxY = 70

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
    method esPosicionValida(position) =
        position.x() >= limiteMinX and position.x() <= limiteMaxX and
        position.y() >= limiteMinY and position.y() <= limiteMaxY and
        not sistemaDeObstaculos.estaOcupado(position)
}

object izquierda {
    method siguiente(position) = position.left(10)
}

object derecha {
    method siguiente(position) = position.right(10)
}

object abajo {
    method siguiente(position) = position.down(10)
}

object arriba {
    method siguiente(position) = position.up(10)
}


