package tester.api.formulario;

import com.intuit.karate.junit5.Karate;

class FormularioRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("formulario").relativeTo(getClass());
    }    

}
