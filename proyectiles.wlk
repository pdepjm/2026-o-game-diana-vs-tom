/*class Proyectil {
    var property position
    var property image = "p.proyectilHielo.png"
    const emisor     //quien  disparó 
    const direccion  //arriba, abajo, izquierda, derecha
    const velocidad = 80               // milisegundos por paso
    const bala = "proyectil_" + self.identity().toString()
method disparar() {
    game.addVisual(self)
    game.onTick(velocidad, bala, {self.avanzar()})
    game.onCollideDo(self, {objetivo => self.impactar(objetivo)})
}
method impactar(objetivo){

}


method avanzar() {
    const proximaPosicion = direccion.siguiente(position)
}
} */