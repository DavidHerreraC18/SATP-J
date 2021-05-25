Feature: Acudiente karate test script

  Background:
    * url 'http://localhost:8082/acudientes'

  Scenario: Obtener acudientes
    Given path ''
    When method get
    Then status 200