import escenario.*

import wollok.game.*
import ingeniero.*

object movimiento {

	//Limite del tablero, margenes
    const limiteMinX = 1
    const limiteMaxX = 140
    const limiteMinY = 1
    const limiteMaxY = 70

    method configurarFlechas(visual){
        //whilePresseDo

keyboard.up().whilePressedDo({ self.mover(arriba, visual) }, 300)
keyboard.down().whilePressedDo({ self.mover(abajo, visual) }, 300)
keyboard.left().whilePressedDo({ self.mover(izquierda, visual) }, 300)
keyboard.right().whilePressedDo({ self.mover(derecha, visual) }, 300)

keyboard.up().onReleaseDo{ visual.dejarDeCaminar() }
keyboard.down().onReleaseDo{ visual.dejarDeCaminar() }
keyboard.left().onReleaseDo{ visual.dejarDeCaminar() }
keyboard.right().onReleaseDo{ visual.dejarDeCaminar() }}
	

//aca definimos personaje por expresividad, tranquilamente podría haber sido ingeniero
    method mover(direccion, personaje){
        personaje.empezarACaminar() //activa la animacion
        const nuevaPosicion = direccion.siguiente(personaje.position())
        if (self.esPosicionValida(nuevaPosicion)) {
            personaje.position(nuevaPosicion)
        }
    }

// comprueba que la posición esté entre los límites y no tenga un obstáculo
    method esPosicionValida(position) =
        position.x() >= limiteMinX and position.x() <= limiteMaxX and
        position.y() >= limiteMinY and position.y() <= limiteMaxY and
        not(sistemaDeObstaculos.estaOcupado(position))

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


