import ingeniero.*
class Obstaculo {
    var property position
    var property image 
}

const banco1 = new Obstaculo(position = game.at(110,30), image = "banco1.png")
const banco2 = new Obstaculo(position = game.at(30,40), image = "banco1.png")
const mesa1 = new Obstaculo(position = game.at(130,10), image = "mesa.png")
const mesa2 = new Obstaculo(position = game.at(70,50), image = "mesa.png")

object utnianos {
    var property position = game.at(60,60)
    var property image = "utnianos.png" 

    method serAgarradoPor (ingeniero){
        ingeniero.sumarEnergia(100)
        
        game.removeVisual(self)
    }
    
 
}

object sistemaDeObstaculos{
    const obstaculos = [banco1, banco2, mesa1, mesa2]

    method estaOcupado(position) = 
        obstaculos.any ({obstaculo => obstaculo.position() == position})
    

}