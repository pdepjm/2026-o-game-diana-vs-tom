import wollok.game.*
import enemigos.*
import ingeniero.*
import modificadores.*
import escenario.*
import Corazones.*
import proyectiles.*
import audio.*



class Pantalla {
    const property image
    var property position = game.at(0, 0)
}

class CaidaIngeniero {
    var property position
    method image() = "caida.gif"
}


class Nivel {
    const cafe = new Cafe()
    const utnianos = new Utnianos()
    var accionesActivas = false

    method enemigo()
    method fondo()              // imagen del tablero de este nivel
    method obstaculos()         // distribucipn de mesas y bancos de este nivel
    method imagenVictoria()     // pantalla que se muestra al pasar nivel
    method velocidadPersecucion()
    method velocidadDisparo()
    method musica() = audio.musicaNivel()

    method mesa(x, y) = new Obstaculo(position = game.at(x, y), image = "mesa.png")
    method banco(x, y) = new Obstaculo(position = game.at(x, y), image = "banco1.png")

    method iniciar() {
        self.prepararEscena()
        game.addVisual(ingeniero)
        game.addVisual(self.enemigo())
        corazones.mostrar(ingeniero.vida())

        accionesActivas = true
        game.onTick(100, "colision", { self.enemigo().atacarEnSuPosicion() })
        game.onTick(self.velocidadPersecucion(), "persecucion", { self.enemigo().perseguir(ingeniero) })
        game.onTick(self.velocidadDisparo(), "disparo", { self.enemigo().disparar() })

        cafe.activar()
        utnianos.activar()
        audio.musica(self.musica())
    }

    method prepararEscena() {
        game.boardGround(self.fondo())
        sistemaDeObstaculos.cargar(self.obstaculos())
    }


    method detenerAcciones() {
        if (accionesActivas) {
            accionesActivas = false
            game.removeTickEvent("colision")
            game.removeTickEvent("persecucion")
            game.removeTickEvent("disparo")
        }
    }

    // saca todo lo del nivel del tablero
    method limpiar() {
        self.detenerAcciones()
        generadorDeBalas.limpiar()
        sistemaDeObstaculos.limpiar()
        corazones.ocultar()
        [ingeniero, self.enemigo(), cafe, utnianos].forEach({ visual => self.quitar(visual) })
    }

    method quitar(visual) {
        if (game.hasVisual(visual)) {
            game.removeVisual(visual)
        }
    }
}

class NivelHaskell inherits Nivel {
    const haskell = new Haskell(position = game.at(50, 50))

    override method enemigo() = haskell
    override method fondo() = "fondo_atardecer.png"
    override method imagenVictoria() = "victoriaHaskell.png"
    override method velocidadPersecucion() = 700
    override method velocidadDisparo() = 1000
    override method obstaculos() = [
        self.mesa(130, 10), self.mesa(70, 50),
        self.banco(110, 30), self.banco(30, 40)
    ]
}

class NivelProlog inherits Nivel {
    const prolog = new Prolog(position = game.at(50, 50))

    override method enemigo() = prolog
    override method fondo() = "fondo_noche.png"
    override method imagenVictoria() = "victoriaProlog.png"
    override method velocidadPersecucion() = 700
    override method velocidadDisparo() = 1000
    override method obstaculos() = [
        self.mesa(40, 20), self.mesa(100, 60), self.mesa(80, 30),
        self.banco(20, 60), self.banco(120, 40), self.banco(60, 10)
    ]
}

class NivelWollok inherits Nivel {
    const wollokEnemigo = new WollokEnemigo(position = game.at(50, 50))

    override method enemigo() = wollokEnemigo
    override method fondo() = "fondo_aula_deteriorada.png"
    override method imagenVictoria() = "victoriaWollok.png"   // además cierra el juego: "aprobaste la materia"
    override method velocidadPersecucion() = 700
    override method velocidadDisparo() = 1000
    override method obstaculos() = [
        self.mesa(30, 30), self.mesa(70, 40), self.mesa(110, 50), self.mesa(90, 10), self.mesa(130, 60),
        self.banco(50, 60), self.banco(130, 30), self.banco(20, 10), self.banco(100, 30)
    ]
}


object estadoInicio {
    method jugando() = false
    method enter() { gestorNiveles.empezarJuego() }
}

object estadoJugando {
    method jugando() = true
    method enter() { }
}


object estadoTransicion {
    method jugando() = false
    method enter() { }
}

object estadoVictoria {
    method jugando() = false
    method enter() { gestorNiveles.avanzar() }
}

object estadoDerrota {
    method jugando() = false
    method enter() { gestorNiveles.reintentar() }
}


object gestorNiveles {
    const duracionCaida = 2500   // ms que se muestra caida.gif antes de la pantalla de derrota
    var numeroDeNivel = 1        // 1 = haskell, 2 = prolog, 3 = wollok
    var nivel = null
    var pantalla = null
    var estado = estadoInicio

    method estaJugando() = estado.jugando()
    method esUltimoNivel() = numeroDeNivel == 3

    method crearNivel() =
        if (numeroDeNivel == 1) new NivelHaskell()
        else if (numeroDeNivel == 2) new NivelProlog()
        else new NivelWollok()


    method enterPresionado() {
        estado.enter()
    }


    method mostrarInicio() {
        estado = estadoInicio
        numeroDeNivel = 1
        self.mostrarPantalla("pantallaDeInicio.png")
        game.schedule(300, { if (estado == estadoInicio) audio.musica(audio.musicaMenu()) })
    }

    method empezarJuego() {
        numeroDeNivel = 1
        ingeniero.reiniciarCompleto()
        self.quitarPantalla()
        self.empezarNivel()
    }

    method empezarNivel() {
        if (nivel != null) {
            nivel.limpiar()
        }
        nivel = self.crearNivel()
        estado = estadoJugando
        ingeniero.volverAlInicio()
        nivel.iniciar()
    }


    method nivelSuperado() {
        if (estado.jugando()) {
            estado = estadoTransicion
            nivel.detenerAcciones()
            generadorDeBalas.limpiar()
            audio.detenerMusica()
            //se espera a que termine la animacion de muerte del enemigo
            game.schedule(nivel.enemigo().duracionMuerte(), { self.mostrarVictoria() })
        }
    }

    method mostrarVictoria() {
        nivel.limpiar()
        estado = estadoVictoria
        audio.efecto(audio.sonidoVictoria())
        self.mostrarPantalla(nivel.imagenVictoria())
    }

    // ENTER en la pantalla de victoria
    method avanzar() {
        self.quitarPantalla()
        if (self.esUltimoNivel()) {
            self.mostrarInicio()
        } else {
            numeroDeNivel = numeroDeNivel + 1
            self.empezarNivel()
        }
    }

 
    method ingenieroMurio() {
        if (estado.jugando()) {
            estado = estadoTransicion
            nivel.detenerAcciones()
            generadorDeBalas.limpiar()
            audio.detenerMusica()
            audio.efecto(audio.sonidoMuerteIngeniero())

            
            const caida = new CaidaIngeniero(position = ingeniero.position())
            game.addVisual(caida)

           
            game.schedule(duracionCaida, {
                nivel.quitar(caida)
                self.mostrarDerrota()
            })
        }
    }

    method mostrarDerrota() {
        nivel.limpiar()
        estado = estadoDerrota
        self.mostrarPantalla("pantallaDerrota.jpg")
    }


    method reintentar() {
        ingeniero.reiniciarCompleto()
        self.quitarPantalla()
        self.empezarNivel()
    }

    
    method mostrarPantalla(imagen) {
        self.quitarPantalla()
        pantalla = new Pantalla(image = imagen)
        game.addVisual(pantalla)
    }

    method quitarPantalla() {
        if (pantalla != null) {
            if (game.hasVisual(pantalla)) {
                game.removeVisual(pantalla)
            }
            pantalla = null
        }
    }
}
