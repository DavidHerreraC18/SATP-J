package tester.api.acudiente;

import com.intuit.karate.junit5.Karate;

class AcudienteRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("acudiente").relativeTo(getClass());
    }    

}
