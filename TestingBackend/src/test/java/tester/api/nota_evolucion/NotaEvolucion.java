package tester.api.nota_evolucion;

import com.intuit.karate.junit5.Karate;

class NotaEvolucion {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("nota_evolucion").relativeTo(getClass());
    }    

}
