Feature: Practicante karate test script

  Background:
    * url 'http://localhost:8082/practicantes'

  Scenario: Obtener practicantes
    Given path ''
    When method get
    Then status 200

  Background:
    * url 'http://localhost:8082/practicantes'

  Scenario: Obtener practicantes pacientes
    Given path '/pacientes'
    When method get
    Then status 200