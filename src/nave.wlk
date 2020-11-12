import example.*
import tareas_sabotajes_items.*

object nave{
	var oxigeno
	const impostores= #{}
	const tripulantes = #{}
	const jugadores = impostores.union(tripulantes)
	const votados = []
	var votosEnBlanco = 0
	
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
	
	//Votaciones -> Le doy la responsabilidad a la nave porque conoce los jugadores que hay
	
	method iniciarVotacion(){
		votados.clear()
		votosEnBlanco=0
		jugadores.forEach({jugador=>jugador.votar()})
		self.finalizarVotacion()
	}
	
	method votoEnBlanco(){
		votosEnBlanco+=1
	}
	method votoTroll(){
		if(self.jugadoresNoSospechosos().isEmpty())
			self.votoEnBlanco()
		else	
			votados.add(self.jugadoresNoSospechosos().anyOne())
	}
	method votoAlMasSospechoso(){
		votados.add(jugadores.max{jugador=>jugador.sospecha()})
	}
	method votoMaterialista(){
		if(self.jugadoresSinItems().isEmpty())
			self.votoEnBlanco()
		else	
			votados.add(self.jugadoresSinItems().anyOne())
	}
	method votoAlAzar(){
		votados.add(jugadores.anyOne())
	}
	method jugadoresNoSospechosos() = jugadores.filter({jugador=>!jugador.esSospechoso()})
	method jugadoresSinItems() = jugadores.filter({jugador=>jugador.mochila().isEmpty()})
	
	method votosPorJugador(jugador) = votados.occurrencesOf(jugador)
	method masVotado() = votados.max({jugador=>self.votosPorJugador(jugador)})
	
	method expulsar(jugador){
		self.eliminarDeListas(jugador)
		jugador.expulsado(true)
		self.chequearGanadores()
	}
	
	method eliminarDeListas(jugador){
		if(tripulantes.contains(jugador))
			tripulantes.remove(jugador)
		else
			impostores.remove(jugador)
	}
	
	method finalizarVotacion(){
		if(votosEnBlanco<=self.votosPorJugador(self.masVotado()))
			self.expulsar(self.masVotado())
		else
			self.error("No fue votado nadie por mayoria de voto en blanco")
	}
	method chequearGanadores(){
		if(impostores.isEmpty())
			self.error("Ganan los tripulantes")
		if(impostores.size()==tripulantes.size())
			self.error("Ganan los impostores")
	}
}