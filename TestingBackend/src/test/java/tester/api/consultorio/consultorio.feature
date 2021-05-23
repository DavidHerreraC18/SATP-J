Feature: Acudiente karate test script

  Background:
    * url 'http://localhost:8082/consultorios'

  Scenario: Obtener consultorios
    Given path ''
    When method get
    Then status 200