*** Settings ***
Documentation    Shared utility keywords used across all test suites.
Library          SeleniumLibrary


*** Keywords ***
Verify Page Title Contains
    [Documentation]    Gets the browser tab title and asserts it contains expected text.
    [Arguments]    ${expected_text}
    ${title}=    Get Title
    Should Contain    ${title}    ${expected_text}
    ...  msg=Page title does not contain '${expected_text}'. Actual title: '${title}'

Element Should Be Visible On Page
    [Documentation]    Waits up to 15 seconds for an element to appear, then asserts it.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=15 sec
    ...    error=Element not found on page: ${locator}

Click On Element
    [Documentation]    Waits for element to be clickable then clicks it.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=15 sec
    Click Element    ${locator}

Enter Text Into Field
    [Documentation]    Clears a field and types the given value.
    [Arguments]    ${locator}    ${value}
    Wait Until Element Is Visible    ${locator}    timeout=15 sec
    Clear Element Text               ${locator}
    Input Text                       ${locator}    ${value}

Wait For Page To Be Ready
    Wait Until Keyword Succeeds    3x    3s    Page Should Contain Element    xpath=//body
