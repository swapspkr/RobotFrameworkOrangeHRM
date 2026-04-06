*** Settings ***
Documentation    Dashboard Page Object — encapsulates all interactions
...              with the OrangeHRM dashboard/home page.
Library          SeleniumLibrary
Resource         ../keywords/common_keywords.robot
Resource         ../variables/locators/dashboard_locators.robot

*** Keywords ***
Verify Dashboard Is Loaded
    [Documentation]    Asserts the Dashboard heading is visible after login.
    Element Should Be Visible On Page    ${DASHBOARD_HEADER}

Get Logged In User Name
    [Documentation]    Returns the display name from the top navigation bar.
    Wait Until Element Is Visible    ${USER_DISPLAY_NAME}    timeout=15 sec
    ${name}=    Get Text    ${USER_DISPLAY_NAME}
    RETURN    ${name}

Logout
    [Documentation]    Clicks the user menu then the Logout option.
    Click On Element    ${USER_MENU}
    Click On Element    ${LOGOUT_OPTION}