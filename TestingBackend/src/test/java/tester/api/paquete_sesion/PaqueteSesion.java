package tester.api.paquete_sesion;

import com.intuit.karate.junit5.Karate;

class PaqueteSesion {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("paquete_sesion").relativeTo(getClass());
    }    

}
