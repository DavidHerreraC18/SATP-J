package tester.api.documento_paciente;

import com.intuit.karate.junit5.Karate;

class DocumentoPaciente {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("documento_paciente").relativeTo(getClass());
    }    

}
