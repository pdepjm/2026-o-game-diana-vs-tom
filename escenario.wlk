import wollok.game.*

class Obstaculo {
    var property position
    var property image
}

// ahora los obstaculos los define cada nivel 
object sistemaDeObstaculos {
    var obstaculos = []

    method cargar(nuevos) {
        self.limpiar()
        obstaculos = nuevos
        obstaculos.forEach({ obstaculo => game.addVisual(obstaculo) })
    }

    method limpiar() {
        obstaculos.forEach({ obstaculo =>
            if (game.hasVisual(obstaculo)) {
                game.removeVisual(obstaculo)
            }
        })
        obstaculos = []
    }

    method estaOcupado(position) =
        obstaculos.any({ obstaculo => obstaculo.position() == position })
}
