import ingeniero.*
import escenario.*
import movimiento.*
import personaje.*
import modificadores.* 

describe "Sistema de obstáculos" {

    test "Una posición con un banco ocupado" { 
        assert.that(sistemaDeObstaculos.estaOcupado(gam.at(100,30)))
    }

    test "Una posición con una mesa esta ocupada" {
        assert.that(sistemaDeObstaculos.estaOcupado(game.at(130,10)))
    }

    test "Una posición sin obstáculos esta libre" {
        assert.notThat(sistemaDeObstaculos.estaOcupado(game.at(90,60)))
    }
}


