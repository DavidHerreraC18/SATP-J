Feature: Practicante karate Prueba Karate

  Background:
    * url 'http://localhost:8082/practicantes'
    * configure headers = { Authorization : 'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjNkOWNmYWE4OGVmMDViNDI0YmU2MjA1ZjQ2YjE4OGQ3MzI1N2JjNDIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdGVsZXBzaWNvLTFlOWM4IiwiYXVkIjoidGVsZXBzaWNvLTFlOWM4IiwiYXV0aF90aW1lIjoxNjIxMzg4ODQ0LCJ1c2VyX2lkIjoiQkQ3WHpLcFZHMWd5QmN3TVFyclhjWEpXbjJxMSIsInN1YiI6IkJEN1h6S3BWRzFneUJjd01RcnJYY1hKV24ycTEiLCJpYXQiOjE2MjEzODg4NDQsImV4cCI6MTYyMTM5MjQ0NCwiZW1haWwiOiJkYXZpZDE4aGNAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbImRhdmlkMThoY0BnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.aZirAmXKHHriK2hBe0N0E5sT-owA4DSer2UCriiMOcJUdmG-nYjGAoGFAJCg-Zvy8tNWPDjd4ccEbo7QgJvH6ZnvAKHSwrUrVjVxag7czp4fhZWClY1gdZJ1AfA0kOAZcp3QDpTEZJMPZyoQhMgSVFjIouZzrl5ruL9smI0DRXN9QixLPfy5By8_lRKTdRteGA47utva-M11f5-yOivQq1hd9uLs3f0_8K4zKFe7Sz4IYFSBjyVEm2PvBEGTFL7hrrMe0upBiQx5WVsidD1m3Fow7v_mb8FnV8bkU-4THqd2pAKOYvrDKx-EZBhUOrXox7Np8cuQMolJZ8b5m9GEaw'}
  Scenario: Obtener practicantes
    Given path ''
    When method get
    Then status 200

  Scenario: Obtener practicantes horas
    Given path '/horas'
    When method get
    Then status 200

  Scenario: Obtener practicantes pacientes
    Given path '/pacientes'
    When method get
    Then status 200