/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }

class Golosina {
	var peso = 15
	var property libreGluten = false
	method peso() = peso

	method calcularEspacio(estanteria) = peso + 25 < estanteria.lugarDisponible()

	method enOferta() = self.precio() < 10
	
	method precio()
}
/*
 * Golosinas
 */
class Bombon inherits Golosina(libreGluten = true){
	override method precio() = 6
	method mordisco() {
		 peso = peso * 0.8 - 1 
		 }
	method sabor() { return frutilla }
}

class BombonDuro inherits Bombon{
	override method mordisco(){
		peso = peso - 1
	}
	method gradoDureza() = 
		if (peso > 12) 
			3 
		else 
			if (peso.between(8, 12)) 
				2 
			else 
				1
}


class Alfajor inherits Golosina {
	
	override method precio() =12 
	method mordisco() { peso = peso * 0.8 }
	method sabor() { return chocolate }
}

class Caramelo inherits Golosina(peso = 5,libreGluten = true){
	
	var property sabor = frutilla
	override method precio() = peso * 17 
	method mordisco() { 
		peso = peso - 1.2
		//otra cosa mas
		 }
	
//	method sabor() = sabor 
///	method sabor(nuevo){
//		sabor = nuevo
//	}
}

class CarameloRelleno inherits Caramelo {

	override method mordisco() {
		super()
		sabor = chocolate
	}
	override method precio() = super() + 1
}


class Chupetin inherits Golosina(peso=7,libreGluten = true){
	
	override method precio() { return 2 }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method sabor() { return naranja }
}

class Oblea inherits Golosina(peso = 250){
	
	override method precio() { return 5 }
	
	method mordisco() {
		//peso = peso * (1- self.tamañoMordisco())
		peso = peso * (1 - if (peso >= 70) 0.5 else  0.25)
		
	}	
	method tamañoMordisco() = if (peso >= 70) 0.5 else  0.25

	method sabor() { return vainilla }
}

class ObleaCrujiente inherits Oblea {
	var mordiscos = 0
	override method mordisco() {
		peso = (peso * (1 - if (peso >= 70) 0.5
		 else  0.25))- self.cantMordiscosBonus()
		mordiscos +=1
	}
	method estaDebil() = mordiscos > 3
	method cantMordiscosBonus() {
		if (mordiscos < 3) {
			return 1
		} else {
			return 0
		}
	}
}

class Chocolatin inherits Golosina{
	// hay que acordarse de *dos* cosas, el peso inicial lo heredamos y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var comido = 0
	override method precio() { return peso * 0.50 }
	override method peso() { return (peso - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method sabor() { return chocolate }

}

class ChocolatinVip inherits Chocolatin{
	const humedad 
	override method peso(){
		return super() * (1+ humedad)
	}
}


class ChocolatinPremium inherits ChocolatinVip{
    override method peso() {
        return (peso - comido).max(0) * (1 + (humedad / 2))
    }
}

class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti {
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return (if(self.libreGluten()) 7 else 10) }
	method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}