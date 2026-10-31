import movimiento.*
import proyectiles.*

class EfectoMuerte {
    var property position
    const prefijo
    var frame = 0

    method image() = prefijo + "_muerte_" + frame + ".png"

    method animar() {
        game.schedule(500, { frame = 1 })
        game.schedule(1000, { frame = 2 })
        game.schedule(3000, { game.removeVisual(self) })
    }
}

class Personaje {
    var property position
    var caminando = false
    var property vida
    var property direccionActual = derecha
    var vivo = true

    // Animación con frames
    var property frame = 0
    var orientacion = "right"
    var pasos = 0

    // método abstracto: cada personaje dice cómo se llaman sus archivos
    method prefijo()

    // cada personaje puede pisarlo si tiene otra cantidad de frames
    method cantidadFrames() = 4

    // Los hijos lo pisan con true si tienen sprites <prefijo>_up_N / <prefijo>_down_N
    method tieneSpritesVerticales() = false

    method image() =
        if (caminando) self.prefijo() + "_" + orientacion + "_" + frame + ".png"
        else self.prefijo() + "_idle_" + orientacion + ".png"

    method estaVivo() = vivo

    method avanzarFrame() { frame = (frame + 1) % self.cantidadFrames() }

    method empezarACaminar() { caminando = true }
    method dejarDeCaminar() { caminando = false }
    method estaCaminando() = caminando
    method tieneFramesMuerte() = false

    method mover(direccion) {
        direccionActual = direccion
        orientacion = direccion.orientacion(orientacion, self.tieneSpritesVerticales())

        const nuevaPosicion = direccion.siguiente(position)
        if (movimiento.esPosicionValida(nuevaPosicion)) {
            position = nuevaPosicion
            self.empezarACaminar()
            self.avanzarFrame()

            // si en 300 ms no dio otro paso, vuelve a idle
            pasos += 1
            const pasoActual = pasos
            game.schedule(300, { if (pasos == pasoActual) self.dejarDeCaminar() })
        }
    }

    method imagenProyectil() = ["Cero_claro.png", "Uno_Claro.png"].anyOne()

    method disparar(){
        if(self.estaVivo()){
            const proximaPos = direccionActual.siguiente(position)
            if (movimiento.esPosicionValida(proximaPos)) {
                const proyectil = new Proyectil(
                    image = self.imagenProyectil(),
                    position = proximaPos, // Un paso adelante
                    emisor = self,
                    direccion = direccionActual
                )
                proyectil.disparar()
            }
        }
        
    }

   method recibirAtaque(atacante) {
        vida = (vida - atacante.ataque()).max(0)

        if (vida == 0) {
            self.morir()
        }
    }

    method morir() {
        if (vivo) {
            vivo = false
            game.removeVisual(self)

            if (self.tieneFramesMuerte()) {
                const efecto = new EfectoMuerte(position = position, prefijo = self.prefijo())
                game.addVisual(efecto)
                efecto.animar()
            }
        }
    }

method vivo() = vivo

}
