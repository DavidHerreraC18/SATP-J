Feature: Usuario karate test script

  Background:
    * url 'http://localhost:8082/tarifas'

  Scenario: Obtener tarifas
    Given path ''
    When method get
    Then status 200