package tester.api.informe_pago;

import com.intuit.karate.junit5.Karate;

class InformePago {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("informe_pago").relativeTo(getClass());
    }    

}
