package tester.api.sesion_terapia;

import com.intuit.karate.junit5.Karate;

class SesionTerapiaRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("sesion_terapia").relativeTo(getClass());
    }    

}
