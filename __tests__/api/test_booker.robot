# *** Variables ***  >>> resources/variables.py
# *** Settings ***   >>> resources/common.resource
# *** Test Case ***  >>> Continuam no arquivo .robot
# *** Keywords ***   >>> resources/common.resource

*** Settings ***
Library        RequestsLibrary
Resource       ../../resources/common.resource
Variables      ../../resources/variables.py
Suite Setup    Create Token    ${url}

*** Test Cases ***
Create Booking
    #header e opcional neste caso
    ${headers}    Create Dictionary    Content-Type=${content_type}
    ${body}    Evaluate    json.loads(open('./fixtures/json/booking1.json').read())

    ${response}    POST    url=${url}/booking    json=${body}    headers=${headers}
    
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[booking][firstname]    Alan
    Should Be Equal    ${response_body}[booking][bookingdates][checkin]    2024-04-27

