Feature: Auxiliar Administrativo karate test script

  Background:
    * url 'http://localhost:8082/auxiliares'

  Scenario: Obtener auxiliares
    Given path ''
    When method get
    Then status 200