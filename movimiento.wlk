
import wollok.game.*
import ingeniero.*

object movimiento {

    const limiteMinX = 1
    const limiteMaxX = 100
    const limiteMinY = 1
    const limiteMaxY = 85

    method configurarFlechas(visual){
        keyboard.up().onPressDo{ self.mover(arriba,visual)}
        keyboard.down().onPressDo{ self.mover(abajo,visual)}
        keyboard.left().onPressDo{ self.mover(izquierda,visual)}
        keyboard.right().onPressDo{ self.mover(derecha,visual)}
    }

    method mover(direccion, ingeniero){
        const nuevaPosicion = direccion.siguiente(ingeniero.position())
        if (self.esPosicionValida(nuevaPosicion)) {
            ingeniero.position(nuevaPosicion)
        }
    }

    method esPosicionValida(position) =
        position.x() >= limiteMinX and position.x() <= limiteMaxX and
        position.y() >= limiteMinY and position.y() <= limiteMaxY

}