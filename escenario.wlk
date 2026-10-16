import ingeniero.*
import modificadores.*

class Obstaculo {
    var property position
    var property image 
}

const banco1 = new Obstaculo(position = game.at(110,30), image = "banco1.png")
const banco2 = new Obstaculo(position = game.at(30,40), image = "banco1.png")
const mesa1 = new Obstaculo(position = game.at(130,10), image = "mesa.png")
const mesa2 = new Obstaculo(position = game.at(70,50), image = "mesa.png")


object sistemaDeObstaculos{
    const obstaculos = [banco1, banco2, mesa1, mesa2]

    method estaOcupado(position) = 
        obstaculos.any ({obstaculo => obstaculo.position() == position})
    

}

//aca agregamos los objetos, faltaria hacer que aparezcan random creo
/*object utnianos inherits Modificadores(position = game.at(60, 60), image = "utnianos.png") {

  override method serAgarradoPor(ingeniero) {
    ingeniero.sumarAtaque(100)  
    super(ingeniero)              
  }
} ESTE ESTA BIEN, el otro utenianos es para matar al ingeniero asi probamos su animacion de muerte*/

object cafe inherits Modificadores(position = game.at(70, 70), image = "tazaCafe.png"){
    override method serAgarradoPor(ingeniero){
        ingeniero.sumarEnergia(100)
        super(ingeniero) // no logramos q se vea :c
    }
}
object utnianos inherits Modificadores(position = game.at(60, 60), image = "utnianos.png") {

  override method serAgarradoPor(ingeniero) {
    ingeniero.morir()
    super(ingeniero)
  }
}