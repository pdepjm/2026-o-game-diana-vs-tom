import movimiento.*
import proyectiles.*
class EfectoMuerte {
    var property position
   
}

class EfectoVictoria {
    var property position

    method image() = "haskell_muerte4.gif"
}
class Personaje {
    var property position
    var caminando = false
    var property vida
    var property direccionActual = derecha
    method image()
    var vivo = true
    

    //Agregar animacion con frames
    var property frame = 0
    var orientacion = "right"
    var pasos = 0
    const cantidadFrames = 4

    //usamos este metodo abstracto para llamar a los frames en los diferentes personajes
    method prefijo()
    method estaVivo() = vivo


    method avanzarFrame() { frame = (frame + 1) % cantidadFrames }

    method empezarACaminar() { caminando = true }
    method dejarDeCaminar() { caminando = false }
    method estaCaminando() = caminando

    // Los hijos lo pisan con true si tienen sprites <prefijo>_up_N / <prefijo>_down_N
    method tieneSpritesVerticales() = false

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
    method disparar(){
       const proximaPos = direccionActual.siguiente(position)
    if (movimiento.esPosicionValida(proximaPos)) {
        const proyectil = new Proyectil(
            position = proximaPos, // Un paso adelante
            emisor = self, 
            direccion = direccionActual
        )
        proyectil.disparar()
    }
    }
        

  method recibirAtaque(atacante) {
        vida = (vida - atacante.ataque()).max(0)
        if (vida == 0) { self.morir() }
    }
  

    
   method morir() {
        vivo = false
        game.removeVisual(self)                  

        const efecto = new EfectoMuerte(position = position)
        game.addVisual(efecto)                 
        game.schedule(3000, { game.removeVisual(efecto) })  
    }

}
