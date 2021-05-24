Feature: Documento Paciente karate test script

  Background:
    * url 'http://localhost:8082/documentos'

  Scenario: Obtener documentos
    Given path ''
    When method get
    Then status 200