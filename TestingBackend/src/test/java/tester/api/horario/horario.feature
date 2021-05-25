Feature: Horario karate test script

  Background:
    * url 'http://localhost:8082/horarios'

  Scenario: Obtener horarios
    Given path ''
    When method get
    Then status 200