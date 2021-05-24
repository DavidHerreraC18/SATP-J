package tester.api.usuario;

import com.intuit.karate.junit5.Karate;

class UsuarioRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("usuario").relativeTo(getClass());
    }    

}
