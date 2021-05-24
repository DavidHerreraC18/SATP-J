package tester.api.registro_practica;

import com.intuit.karate.junit5.Karate;

class RegistroPracticaRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("registro_practica").relativeTo(getClass());
    }    

}
