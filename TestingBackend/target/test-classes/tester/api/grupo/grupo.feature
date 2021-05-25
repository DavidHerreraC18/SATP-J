Feature: Grupo karate test script

  Background:
    * url 'http://localhost:8082/grupos'

  Scenario: Obtener grupos
    Given path ''
    When method get
    Then status 200
  