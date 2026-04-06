*** Settings ***
Documentation    Login Page Object — encapsulates all user interactions
...              with the OrangeHRM login page.
...              Tests call these keywords. Locators are never exposed to tests.
Library          SeleniumLibrary
Resource         ../keywords/common_keywords.robot
Resource         ../variables/locators/login_locators.robot

*** Keywords ***
Verify Login Page Is Loaded
    [Documentation]    Confirms the login page is fully rendered.
    Element Should Be Visible On Page    ${LOGIN_LOGO}
    Element Should Be Visible On Page    ${USERNAME_INPUT}
    Element Should Be Visible On Page    ${LOGIN_BUTTON}

Enter Username
    [Documentation]    Types the given text into the username field.
    [Arguments]    ${username}
    Enter Text Into Field    ${USERNAME_INPUT}    ${username}

Enter Password
    [Documentation]    Types the given text into the password field.
    [Arguments]    ${password}
    Enter Text Into Field    ${PASSWORD_INPUT}    ${password}

Click Login Button
    [Documentation]    Clicks the Login submit button.
    Click On Element    ${LOGIN_BUTTON}

Login With Credentials
    [Documentation]    Performs a full login with the given username and password.
    [Arguments]    ${username}    ${password}
    Enter Username    ${username}
    Enter Password    ${password}
    Click Login Button

Verify Login Error Is Shown
    [Documentation]    Confirms the error alert is displayed after a failed login.
    Element Should Be Visible On Page    ${LOGIN_ERROR_ALERT}

Verify Required Field Error Is Shown
    [Documentation]    Confirms the required-field validation message appears.
    Element Should Be Visible On Page    ${FIELD_REQUIRED_MSG}

Click Forgot Password Link
    [Documentation]    Clicks the Forgot your password? link.
    Click On Element    ${FORGOT_PWD_LINK}