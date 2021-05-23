package tester.api.horario;

import com.intuit.karate.junit5.Karate;

class HorarioRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("horario").relativeTo(getClass());
    }    

}
