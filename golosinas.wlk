class Golosina {
    var property precio //precio = 0 se le puede dar un valor si queres
    var property sabor
    var property peso
    var property gluten

    method mordisco() {
        peso = (peso * 0.8) -1
    }
}

object bombon inherits Golosina(precio = 5, sabor = "frutilla", peso = 15, gluten = false) { //prueba de clases

}
// object bombon {
    // var property precio = 5
    // var property sabor = "frutilla"
    // var property peso = 15
    // var property gluten = false
    
    // method mordisco() {
        // peso = (peso * 0.8) -1
    // }
// }

object alfajor {
    var property precio = 12
    var property sabor = "chocolate"
    var property peso = 300
    var property gluten = true //no es libre de gluten osea tiene
    
    method mordisco() {
        peso = (peso * 0.8)
    }
    
}

object caramelo {
    var property precio = 1
    var property sabor = "frutilla"
    var property peso = 5
    var property gluten = false
    
    method mordisco() {
        peso -= 1
    }
    
}

object chupetin {
    var property precio = 2
    var property sabor = "naranja"
    var property peso = 7
    var property gluten = false
    
    method mordisco() {
        if (peso > 2) {
            peso = (peso * 0.9)
        } else {
            peso = 2
        }
    }
    
}

object oblea {
    var property precio = 5
    var property sabor = "vainilla"
    var property peso = 250
    var property gluten = true
    
    method mordisco() {
        if (peso > 70) {
            peso = (peso * 0.5)
        } else {
            peso = (peso * 0.75)
        }
    }
    
}

object chocolatin {
    var property precio = 0
    var property sabor = "chocolate"
    var property peso = 0
    var property gluten = true
    
    method asignarPeso(gramos) {
        peso = gramos
        precio = gramos * 0.5
    }

    method mordisco() {
        peso -= 2
    }
    
}

object golosinaBaniada {
    var property precio = 0
    var property sabor = ""
    var property peso = 0
    var property gluten = null
    var property golobase = null
    var baniado = 4

    method asignarBase(golosina) {
        peso = golosina.peso() + baniado.max(0)
        precio = golosina.precio() + 2
        sabor = golosina.sabor()
        gluten = golosina.gluten()
        self.golobase(golosina)
    }

    method mordisco() {
        self.golobase().mordisco()
        baniado -= 2
        peso = golobase.peso() + baniado.max(0)
    }

}

object pastilla {
    var property precio = 0
    var property sabor = ["frutilla","chocolate","naranja"]
    var property peso = 5
    var property gluten = null
    var property saborIndex = 0

    method gluten_(a) {
        if (a == true) {
            gluten = true
            self.precio(10)
        } else {
            gluten = false
            self.precio(7)
        }
    }

    method mordisco() {
        saborIndex = (saborIndex + 1) % sabor.size()
        peso -= 1 //no pone que baje de peso cuando la mordes
    }
    //Primero es 0 si le das un mordisco:
    //Si saborIndex es 0, (0 + 1) % 3 = 1.
    //Si saborIndex es 1, (1 + 1) % 3 = 2.
    //Si saborIndex es 2, (2 + 1) % 3 = 0.

    method sabor() = sabor.get(saborIndex)

}

object mariano {
    var property bolsa = []

    method comprar(golosina) {
        bolsa.add(golosina)
    }
    method desechar(golosina) {
        bolsa.remove(golosina)
    }
    method probarGolosinas() {
        bolsa.forEach{a => a.mordisco()}
    }
    method haySinTacc() {
        return bolsa.any{a => a.gluten() == false}
    }
    method preciosCuidados() {
        return bolsa.all{a => a.precio() <= 10}
    }
    method golosinaDeSabor(unSabor) {
        return bolsa.find{a => a.sabor() == unSabor}
    }
    method golosinasDeSabor(unSabor) {
        return bolsa.filter{a => a.sabor() == unSabor}
    }
    method sabores() {
        const saboresSet = #{}
        bolsa.forEach{a => saboresSet.add(a.sabor())}
        return saboresSet
    }
    method golosinaMasCara() {
        return bolsa.max{a => a.precio()}
    }
    method pesoGolosina() {
        return bolsa.sum{a => a.peso()}
    }

    method golosinasFaltantes(golosinasDeseadas) {
        return golosinasDeseadas.filter{a => !bolsa.contains(a)}
    } //filtra los valores(objetos) de golosinasDeseadas que la bolsa No contenga
//agarra los de golosinasDeseadas que no esten en bolsa
    method gustosFaltantes(gustosDeseados) {
        const gustosCubiertos = #{}
        bolsa.forEach{a => gustosCubiertos.add(a.sabor())}
        return gustosDeseados.filter{a => !gustosCubiertos.contains(a)}
    }// se fija en la bolsa los gustos que tiene cada objeto y los pone en un set
    // se fija los gustosDeseados con los gustos cubiertos Y devuelve los gustosDeseados que no estan en gustosCubiertos

    //* parte 3
    method baniar(unaGolosina) {
        golosinaBaniada.asignarBase(unaGolosina)
        self.comprar(golosinaBaniada)
    }


}
