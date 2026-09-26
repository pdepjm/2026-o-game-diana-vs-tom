
import haskell.*

object ingeniero {

  method position() = game.center()
  const property image = "ingeniero.jpeg"


  
  var vida = 1000 // en corazones

  method recibirAtaque(){
    vida = vida - haskell.ataque()
  }


  var energia = 200 //si tiene menos del 50% de energia, esta cansado-->pega un 25% menos
  method sueño(cantidad) { energia = energia-cantidad } // si energia<0 se duerme, osea muere xd

  var property ataque = 100
  method ataque() = ataque

  method modificarAtaque() {
    if(energia < 100){ ataque = ataque - 0.25*ataque} // si su energia es <100, pega un 25% menos
    
    else if(energia>300){ ataque = ataque + 0.25*ataque} //si su energia es >300, pega 25% mas
  }
}




