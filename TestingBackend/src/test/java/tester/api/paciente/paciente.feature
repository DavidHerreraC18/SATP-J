Feature: Paciente karate test script

  Background:
    * url 'http://localhost:8082/pacientes'

  Scenario: Obtener pacientes
    Given path ''
    When method get
    Then status 200