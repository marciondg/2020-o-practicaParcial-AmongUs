import nave.*
import tareas_sabotajes_items.*
class Jugador{
	const color
	const mochila = []
	var property sospecha = 40
	const tareasPendientes = []
	var property expulsado = false
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
	
	method llamarVotacionEmergencia(){
		nave.iniciarVotacion()
	}
	method votar(){
		if(expulsado)
			self.error("No puede votar por estar eliminado")
	}
}

class Tripulante inherits Jugador{
	var property personalidad
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
	override method votar(){
		super()
		personalidad.voto()
	}
}

class Impostor inherits Jugador{
	method terminoSusTareas() = true
	
	override method realizarTarea(tarea){}
	
	method sabotear(sabotaje,afectado){
		sabotaje.realizarSabotaje(afectado)
	}
	override method votar(){
		super()
		nave.votoAlAzar()
	}
}



//Personalidades
object troll {
	method voto(){
		nave.votoTroll()
	}
}
object detective{
	method voto(){
		nave.votoAlMasSospechoso()
	}
}
object materialista{
	method voto(){
		nave.votoMaterialista()
	}
}