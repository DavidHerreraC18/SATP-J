package tester.api.comprobante_pago;

import com.intuit.karate.junit5.Karate;

class ComprobantePagoRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("comprobante_pago").relativeTo(getClass());
    }    

}
