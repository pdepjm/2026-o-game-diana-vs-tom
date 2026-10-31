
import personaje.*
import ingeniero.*
import posicionValida.*


class Modificadores {
    var property position
    var property image

    method serAgarradoPor(ingeniero) {
        game.removeVisual(self)
    }

    method reubicar() {
        position = posicionValida.aleatoria()
    }

    method activar() {
        self.reubicar()
        game.addVisual(self)
        game.onCollideDo(self, { algo =>
            if (algo == ingeniero) self.serAgarradoPor(ingeniero)
        })
    }
}


object utnianos inherits Modificadores(position = game.at(60, 60), image = "utnianos.png") {

  override method serAgarradoPor(ingeniero) {
    ingeniero.sumarAtaque(100)  
    super(ingeniero)              
  }}

object cafe inherits Modificadores(position = game.at(70, 70), image = "tazaCafe.png"){
    override method serAgarradoPor(ingeniero){
        ingeniero.sumarEnergia(100)
        super(ingeniero) // no logramos q se vea :c
    }
}