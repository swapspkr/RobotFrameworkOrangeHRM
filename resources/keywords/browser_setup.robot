*** Settings ***
Documentation    Browser lifecycle keywords reused across all test suites.
Library          SeleniumLibrary

*** Keywords ***
Open My Browser
    [Documentation]    Opens Chrome and navigates to the given URL.
    [Arguments]    ${url}    ${browser}=chrome
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

Close My Browser
    [Documentation]    Closes all open browser windows.
    Close Browser