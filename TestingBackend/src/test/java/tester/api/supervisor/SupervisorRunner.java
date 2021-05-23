package tester.api.supervisor;

import com.intuit.karate.junit5.Karate;

class SupervisorRunner {
    
    @Karate.Test
    Karate testApi() {
        return Karate.run("supervisor").relativeTo(getClass());
    }    

}
