package tester.api.tarifa_sesion;

import com.intuit.karate.junit5.Karate;

class TarifaSesion {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("usuario").relativeTo(getClass());
    }    

}
