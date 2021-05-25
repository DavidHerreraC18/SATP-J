Feature: Registro Practica karate test script

  Background:
    * url 'http://localhost:8082/registropracticas'

  Scenario: Obtener registro de practicas
    Given path ''
    When method get
    Then status 200