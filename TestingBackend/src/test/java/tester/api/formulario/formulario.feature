Feature: Formulario karate test script

  Background:
    * url 'http://localhost:8082/formularios'

  Scenario: Obtener formularios
    Given path ''
    When method get
    Then status 200

  Scenario: Obtener formularios
    Given path '/pendientes-aprobacion'
    When method get
    Then status 200

  Scenario: Obtener formularios
    Given path '/aprobados'
    When method get
    Then status 200