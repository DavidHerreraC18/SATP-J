package tester.api.grupo;

import com.intuit.karate.junit5.Karate;

class GrupoRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("grupo").relativeTo(getClass());
    }    

}
