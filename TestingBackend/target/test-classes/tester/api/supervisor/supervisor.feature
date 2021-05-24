Feature: Supervisor karate test script

  Background:
    * url 'http://localhost:8082/supervisores'

  Scenario: Obtener supervisores
    Given path ''
    When method get
    Then status 200