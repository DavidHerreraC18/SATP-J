Feature: Comprobante Pago karate test script

  Background:
    * url 'http://localhost:8082/comprobantespago'

  Scenario: Obtener comprobantes
    Given path ''
    When method get
    Then status 200