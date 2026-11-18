import wollok.game.*


object audio {

    var musicaActual = null

   
    method musicaAmbiente() = "musicaAmbiente.mp3"//ya ta
    method sonidoDisparo() = "disparo.wav"//ya ta
    method sonidoMuerteIngeniero() = "muerteIngeniero.wav"//ya ta
    method sonidoVictoria() = "victoria.wav"//ya ta

  
    method efecto(archivo) {
        self.efecto(archivo, 0.7)
    }

    method efecto(archivo, volumen) {
        const sonido = game.sound(archivo)
        sonido.volume(volumen)
        sonido.play()
    }

    // musica de fondo en loop
    method musica(archivo) {
        self.detenerMusica()
        musicaActual = game.sound(archivo)
        musicaActual.shouldLoop(true)
        musicaActual.volume(0.3)
        musicaActual.play()
    }

    method detenerMusica() {
        if (musicaActual != null) {
            musicaActual.stop()
            musicaActual = null
        }
    }
}
