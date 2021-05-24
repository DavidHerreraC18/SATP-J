Feature: Nota Evolucion karate test script

  Background:
    * url 'http://localhost:8082/notasevolucion'

  Scenario: Obtener Notas de Evolucion
    Given path ''
    When method get
    Then status 200