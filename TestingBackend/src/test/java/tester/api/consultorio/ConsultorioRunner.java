package tester.api.consultorio;

import com.intuit.karate.junit5.Karate;

class ConsultorioRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("consultorio").relativeTo(getClass());
    }    

}
