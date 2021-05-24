Feature: Sesion Terapia karate test script

  Background:
    * url 'http://localhost:8082/sesionterapias'

  Scenario: Obtener Sesiones de Terapia
    Given path ''
    When method get
    Then status 200