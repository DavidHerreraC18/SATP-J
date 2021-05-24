Feature: Usuario karate test script

  Background:
    * url 'http://localhost:8082/usuarios'

  Scenario: Obtener usuarios
    Given path ''
    When method get
    Then status 200