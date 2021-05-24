package tester.api.auxiliar_administrativo;

import com.intuit.karate.junit5.Karate;

class AuxiliarAdministrativoRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("auxiliar_administrativo").relativeTo(getClass());
    }    

}
