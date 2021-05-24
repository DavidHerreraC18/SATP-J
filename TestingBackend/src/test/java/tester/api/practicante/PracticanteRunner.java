package tester.api.practicante;

import com.intuit.karate.junit5.Karate;

class PracticanteRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("practicante").relativeTo(getClass());
    }    

}
