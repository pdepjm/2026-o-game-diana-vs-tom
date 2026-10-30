
import personaje.*
import ingeniero.*


class Modificadores{
    var property position
    var property image

    method serAgarradoPor(ingeniero){
        game.removeVisual(self)
    }

    method reubicar() {
    position = game.at(0.randomUpTo(game.width()), 0.randomUpTo(game.height()))
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