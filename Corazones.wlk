import wollok.game.*

class Corazon {
    var property position
    var property imagen
    var visible = false   // arranca sin estar en el tablero

    method image() = imagen

    method cambiarImagen(nuevaImagen) {
        imagen = nuevaImagen
    }

    method mostrar() {
        if (not visible) {
            visible = true
            game.addVisual(self)
        }
    }

    method ocultar() {
        if (visible) {
            visible = false
            game.removeVisual(self)
        }
    }
}

object corazones {

    const corazon1 = new Corazon(
        position = game.at(130, 85),
        imagen = "Corazon_Lleno.png"
    )

    const corazon2 = new Corazon(
        position = game.at(140, 85),
        imagen = "Corazon_Lleno.png"
    )

    const corazon3 = new Corazon(
        position = game.at(150, 85),
        imagen = "Corazon_Lleno.png"
    )

 
    method mostrar(vida) {
        self.actualizar(vida)
    }

    // Se llama al terminar el nivel 
    method ocultar() {
        corazon1.ocultar()
        corazon2.ocultar()
        corazon3.ocultar()
    }

    method actualizar(vida) {
        self.actualizarCorazon(corazon1, vida)
        self.actualizarCorazon(corazon2, vida - 100)
        self.actualizarCorazon(corazon3, vida - 200)
    }

    method actualizarCorazon(corazon, vidaCorazon) {
        if (vidaCorazon >= 100) {
            corazon.cambiarImagen("Corazon_Lleno.png")
            corazon.mostrar()
        } else if (vidaCorazon >= 50) {
            corazon.cambiarImagen("Medio_Corazon.png")
            corazon.mostrar()
        } else {
            corazon.ocultar()
        }
    }
}
