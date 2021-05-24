package tester.api.alerta;

import com.intuit.karate.junit5.Karate;

class AlertaRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("alerta").relativeTo(getClass());
    }    

}
