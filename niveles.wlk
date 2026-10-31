import wollok.game.*
import enemigos.*
import ingeniero.*
import modificadores.*


class Nivel{
    const cafe = new Cafe()
    const utnianos = new Utnianos()

    method enemigo()
    method velocidadPersecucion()
    method velocidadDisparo()
    method superado()= not self.enemigo().estaVivo()
    method iniciar(){
        game.addVisual(ingeniero)
        game.addVisual(self.enemigo())
        game.onTick(100, "colision", {self.enemigo().atacarEnSuPosicion()})
        game.onTick(self.velocidadPersecucion(),"persecucion", {self.enemigo().perseguir(ingeniero)})
        game.onTick(self.velocidadDisparo(),"disparo", {self.enemigo().disparar()})
        cafe.activar()
        utnianos.activar()
    }
    method detener(){
        game.removeVisual(ingeniero)
        game.removeVisual(cafe)
        game.removeVisual(utnianos)
        game.removeTickEvent("colision")
        game.removeTickEvent("persecucion")
        game.removeTickEvent("disparo")
    }
}



class NivelHaskell inherits Nivel{

    const haskell = new Haskell(position =game.at(50,50))
    override method enemigo()= haskell
    override method velocidadPersecucion()= 700
    override method velocidadDisparo() = 1000
}

class NivelProlog inherits Nivel{
    const prolog = new Prolog (position = game.at(50,50))
   override method enemigo()= prolog
override method velocidadPersecucion()= 700
       override method velocidadDisparo() = 1000
}

class NivelWollok inherits Nivel{
       const wollokEnemigo = new WollokEnemigo (position = game.at(50,50))
     override method enemigo()= wollokEnemigo
    override method velocidadPersecucion()= 700
       override method velocidadDisparo() = 1000
}


object gestorNiveles {
    var numeroDeNivel= 1 //inicializa en (haskell)
    var nivel = null
    var terminoElJuego = false
    method nivelActual() = nivel
    method esUltimoNivel() =(numeroDeNivel == 3)
    method crearNivel()=
    if (numeroDeNivel ==1) new NivelHaskell()
            else if (numeroDeNivel ==2) new NivelProlog()
            else new NivelWollok()
    
    
    method iniciar(){
        nivel = self.crearNivel()
        nivel.iniciar()
    }
    method perder() {
        if (not terminoElJuego) {
            terminoElJuego = true
           
            nivel.detener()
            const pantalla = new PantallaFinal(
                position = game.at(70, 35)
            )

            game.addVisual(pantalla)
        }
    }
  
 method completarNivel() {
        nivel.detener()
        if (not self.esUltimoNivel() and nivel.superado() and ingeniero.estaVivo()) { 
            keyboard.enter().onPressDo({
                numeroDeNivel += 1 
                self.iniciar()     
            })
        }
    }

           
}
class PantallaFinal {
    var property position

    method image() = "caida.gif"
}