package tester.api.paciente;

import com.intuit.karate.junit5.Karate;

class Paciente {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("paciente").relativeTo(getClass());
    }    

}
