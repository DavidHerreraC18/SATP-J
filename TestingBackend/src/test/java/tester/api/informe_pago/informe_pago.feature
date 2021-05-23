Feature: Informe Pago karate test script

  Background:
    * url 'http://localhost:8082/informepagos'

  Scenario: Obtener Informe de Pagos
    Given path ''
    When method get
    Then status 200