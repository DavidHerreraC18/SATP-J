Feature: Alerta karate test script

  Background:
    * url 'http://localhost:8082/alertas'

  Scenario: Obtener alertas
    Given path ''
    When method get
    Then status 200

  Background:
    * url 'http://localhost:8082/alertas'

  Scenario: Obtener alertas
    Given path '/usuario'
    When method get
    Then status 200