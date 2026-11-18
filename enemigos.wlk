import escenario.*
import movimiento.*
import personaje.*
import ingeniero.*
import proyectiles.*
import niveles.*
import audio.*
import wollok.game.*

class Enemigo inherits Personaje{

    var terminado = false

    override method imagenProyectil() = "disparoEnemigo.png"

    // cuanto dura la animacion de muerte antes de mostrar la pantalla de victoria
    method duracionMuerte() = if (self.tieneFramesMuerte()) 3200 else 800

    method perseguir(personaje) {
        if (self.puedeActuar()) {
            if (self.alcanzo(personaje)) {
                personaje.recibirAtaque(self)
            } else {
                self.acercarseA(personaje.position())
            }
        }
    }

    override method morir() {
        if (self.estaVivo()) {
            super()
            audio.efecto(audio.sonidoMuerteEnemigo())
            gestorNiveles.nivelSuperado()
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

    // un enemigo muerto ya no ataca
    method atacarEnSuPosicion() {
        if (self.puedeActuar() and position == ingeniero.position()) {
            ingeniero.recibirAtaque(self)
        }
    }
}


class Prolog inherits Enemigo(position = game.at(50, 60), vida = 50) {
    override method prefijo() = "owl"

    // el búho se ve de frente: usa los mismos frames para los dos lados
    override method image() =
        if (self.estaCaminando()) "owl_right_" + self.frame() + ".png"
        else "owl_right_0.png"

    const ataque = 50
    method ataque() = ataque
}

class Haskell inherits Enemigo(position = game.at(50, 50), vida = 1) {
    override method prefijo() = "haskell"
    override method tieneFramesMuerte() = true

    const ataque = 50
    method ataque() = ataque
}

class WollokEnemigo inherits Enemigo(position = game.at(60, 50), vida = 50) {
    override method prefijo() = "wollok"
    override method tieneFramesMuerte() = true

    const ataque = 50
    method ataque() = ataque
}
