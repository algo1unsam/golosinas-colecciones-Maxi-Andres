class Golosina {
    var property precio //precio = 0 se le puede dar un valor si queres
    var property sabor
    var property peso
    var property gluten

    method mordisco() {
        peso = (peso * 0.8) -1
    }
}

object bombon inherits Golosina(precio = 5, sabor = "frutilla", peso = 15, gluten = false) {}

object alfajor inherits Golosina(precio = 12, sabor = "chocolate", peso = 300, gluten = true) {
    override method mordisco() {
        peso = (peso * 0.8)
    }
}

object caramelo inherits Golosina(precio = 1, sabor = "frutilla", peso = 5, gluten = false) {
    override method mordisco() {
        peso -= 1
    }
}

object chupetin inherits Golosina(precio = 2, sabor = "naranja", peso = 7, gluten = false) {
    override method mordisco() {
        if(peso > 2) {
            peso = peso * 0.9
        }
    }
}

object oblea inherits Golosina(precio = 5, sabor = "vainilla", peso = 250, gluten = true) {
    override method mordisco() {
        if (peso > 70) {
            peso = (peso * 0.5)
        } else {
            peso = (peso * 0.75)
        }
    }
}

object chocolatin inherits Golosina(precio = 0, sabor = "chocolate", peso = 0, gluten = true) {
    override method peso(gramos) {
        peso = gramos
        pesoInicial = gramos
    }
    var property pesoInicial = 0
    override method mordisco() {
        peso -= 2
    }
    override method precio() = 0.5 * pesoInicial
}

class GolosinaBaniada inherits Golosina(precio = base.precio(), sabor = base.sabor(), peso = base.peso() + self.baniado(), gluten = base.gluten()) {
    var property baniado = 4
    var property base //le asigno bombon porque sino no funciona

    method asignarBase(golosinaBase) {
        peso = golosinaBase.peso() + baniado.max(0)
        precio = golosinaBase.precio() + 2
        sabor = golosinaBase.sabor()
        gluten = golosinaBase.gluten()
        self.base(golosinaBase)
    }
    override method mordisco() {
        self.base().mordisco()
        baniado -= 2
        peso = base.peso() + baniado.max(0)
    }
}

object pastilla inherits Golosina(precio = 0, sabor = ["frutilla","chocolate","naranja"], peso = 5, gluten = false) {
    var property saborIndex = 0
    //Si es libre de gluten(false) el precio es $7; si no(true), es de $10.  
    override method gluten(a) {
        if (a) {
            gluten = false
        } else {
            gluten = true
        }
    }
    override method precio() {
        return if (self.gluten()) {7}
        else {10}
    }
    override method mordisco() {
        saborIndex = (saborIndex + 1) % sabor.size()
    }
    //Primero es 0 si le das un mordisco:
    //Si saborIndex es 0, (0 + 1) % 3 = 1.
    //Si saborIndex es 1, (1 + 1) % 3 = 2.
    //Si saborIndex es 2, (2 + 1) % 3 = 0.
    override method sabor() = sabor.get(saborIndex)
}

object mariano {
    var property bolsa = []

    method comprar(golosina) = bolsa.add(golosina)
    method desechar(golosina) = bolsa.remove(golosina)
    method probarGolosinas() = bolsa.forEach{golo => golo.mordisco()}
    method haySinTacc() = bolsa.any{golo => !golo.gluten()}
    method preciosCuidados() = bolsa.all{golo => golo.precio() <= 10}
    method golosinaDeSabor(unSabor) = bolsa.find{golo => golo.sabor() == unSabor}
    method golosinasDeSabor(unSabor) = bolsa.filter{golo => golo.sabor() == unSabor}
    method sabores() = bolsa.map{golosina => golosina.sabor()}.asSet()//lo hago un set para borrar repetidos
    // method sabores() {
        // const saboresSet = #{}
        // bolsa.forEach{a => saboresSet.add(a.sabor())}
        // return saboresSet }
    method golosinaMasCara() = bolsa.max{golo => golo.precio()}
    method pesoGolosina() = bolsa.sum{a => a.peso()}

    method golosinasFaltantes(golosinasDeseadas) {
        return golosinasDeseadas.filter{golo => !bolsa.contains(golo)} 
    }// de la colleccion que le das devuelve los que no esten en la bolsa
    method gustosFaltantes(gustosDeseados) {
        return gustosDeseados.filter{gusto => !bolsa.any{golo => golo.sabor() == gusto}}
    }

    method baniar(golosina) {
    bolsa.add(new GolosinaBaniada(base = golosina))
    }//! esto no entiendo mucho

}
