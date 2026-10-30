import escenario.*  

object posicionValida {

    // Limites del tablero
    const limiteMinX = 1
    const limiteMaxX = 140
    const limiteMinY = 1
    const limiteMaxY = 70

    //esto el ingeniero
    method esValida(position) =
        position.x() >= limiteMinX and position.x() <= limiteMaxX and
        position.y() >= limiteMinY and position.y() <= limiteMaxY and
        not sistemaDeObstaculos.estaOcupado(position)

    //esto es para los modificadores asi no aparecen fuera del limite
    method aleatoria() {
        const candidata = game.at(
            limiteMinX.randomUpTo(limiteMaxX + 1).truncate(0),
            limiteMinY.randomUpTo(limiteMaxY + 1).truncate(0)
        )
        return if (self.esValida(candidata)) candidata else self.aleatoria()
    }
}