class Jugador{
	const color
	const mochila = []
	var property sospecha = 40
	const tareasPendientes = []
	//Usar item de mochila. (mochila.contains(item)) -> mochila.remove(item) luego del uso.
	method esSospechoso () = sospecha>50
	method buscarItem(item){
		mochila.add(item)
	}
	method usarItem(item){
		mochila.remove(item)
	}
	method tiene(item) = mochila.find(item)
	
	method realizarTareaPendiente(){
		self.realizarTarea(tareasPendientes.anyOne())
	}
	method realizarTarea(tarea) {
		//Se completa en las clases hijas 
	}
	
}

class Tripulante inherits Jugador{
	method modificarSospecha(cantidad){
		sospecha+=cantidad
	}
	override method realizarTarea(tarea){
		self.validarTarea(tarea)
		tarea.realizarTarea(self)
		tareasPendientes.remove(tarea)
		nave.revisarTareas()}
		
	method validarTarea(tarea){
		if(!tarea.cumpleRequerimiento(self))
			self.error("No se puede realizar la tarea")
		}
	method terminoSusTareas() = tareasPendientes.isEmpty()
}
class Impostor inherits Jugador{
	method terminoSusTareas() = true
	
	override method realizarTarea(tarea){}
	
	method sabotear(sabotaje,afectado){
		sabotaje.realizarSabotaje(afectado)
	}
}

object nave{
	var oxigeno
	const jugadores= []
	//method impostores()=jugadores.filter({jugador=>jugador.vivo() jugador.esImpostor()})
	//method tripulantes()= jugadores.filter({jugador=>jugador.vivo() jugador.esTripulante()})
	method modificarOxigeno(cantidad){
		oxigeno+=cantidad
		self.verificarOxigeno()
	}
	method revisarTareas(){
		if(self.todosTerminaronLasTareas())
			self.error("Ganaron los tripulantes")
	}
	method todosTerminaronLasTareas() = jugadores.all({jugador=>jugador.terminoSusTareas()})
	method verificarOxigeno(){
		if(oxigeno<=0)
			self.error("Ganaron los impostores")
	}
	method alguienConTuboOxigeno() = jugadores.any({jugador=>jugador.tiene(tuboOxigeno)})
}
//Tareas
object arreglarTableroElectrico{
	method cumpleRequerimiento(tripulante) = tripulante.tiene(llaveInglesa)
	method realizarTarea(tripulante,nave) = tripulante.modificarSospecha(10)
}
object sacarLaBasura{
	method cumpleRequerimiento(tripulante) = tripulante.tiene(escoba) && tripulante.tiene(bolsaConsorcio)
	method realizarTarea(tripulante,nave) = tripulante.modificarSospecha(-5)
}
object ventilarNave{
	method cumpleRequerimiento(tripulante) = true
	method realizarTarea(tripulante,nave) = nave.modificarOxigeno(5)
}
//Items
object llaveInglesa{}
object bolsaConsorcio{}
object escoba{}
object tuboOxigeno{}
//Sabotaje
object reducirOxigeno{
	method realizarSabotaje(afectado){
		if(!nave.alguienConTuboOxigeno())
			nave.modificarOxigeno(-10)
	}
}
object impugnarJugador{
	method realizarSabotaje(afectado){
		afectado.obligadoAVotarEnBlanco()
	}
}