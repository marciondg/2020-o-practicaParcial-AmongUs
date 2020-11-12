import nave.*
import example.*
//Tareas
object arreglarTableroElectrico{
	method cumpleRequerimiento(tripulante) = tripulante.tiene(llaveInglesa)
	method realizarTarea(tripulante) {
		tripulante.modificarSospecha(10)
}
}
object sacarLaBasura{
	method cumpleRequerimiento(tripulante) = tripulante.tiene(escoba) && tripulante.tiene(bolsaConsorcio)
	method realizarTarea(tripulante){
		tripulante.modificarSospecha(-5)		
}
}
object ventilarNave{
	method cumpleRequerimiento(tripulante) = true
	method realizarTarea(tripulante){nave.modificarOxigeno(5)}
}

//Items
object llaveInglesa{}
object bolsaConsorcio{}
object escoba{}
object tuboOxigeno{}

//Sabotajes
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