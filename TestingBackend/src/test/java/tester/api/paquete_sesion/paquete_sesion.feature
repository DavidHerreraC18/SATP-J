Feature: Paquete Sesion karate test script

  Background:
    * url 'http://localhost:8082/paquetesesiones'

  Scenario: Obtener Paquetes Sesion
    Given path ''
    When method get
    Then status 200