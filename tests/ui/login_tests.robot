
*** Settings ***
Documentation    Login page functional tests using full Page Object Model.
...              Test cases contain ZERO locators and ZERO Selenium keywords.
Resource         ../../resources/keywords/browser_setup.robot
Resource         ../../resources/page_objects/login_page.robot
Resource         ../../resources/page_objects/dashboard_page.robot

Suite Setup      Open My Browser    ${URL}
Suite Teardown   Close My Browser
Test Setup       Navigate To Login Page


*** Variables ***

${URL}              https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USER}       Admin
${VALID_PASSWORD}   admin123

*** Test Cases ***
TC-LOGIN-001 Login Page Should Load Correctly
    [Documentation]    Verifies all key elements are visible on the login page.
    Verify Login Page Is Loaded

TC-LOGIN-002 Valid Login Should Reach Dashboard
    [Documentation]    Logs in with valid credentials and confirms dashboard loads.
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Verify Dashboard Is Loaded

TC-LOGIN-003 Dashboard Should Display Logged In Username
    [Documentation]    Confirms the user's name appears in the navigation bar.
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    ${name}=    Get Logged In User Name
    Should Not Be Empty    ${name}
    ...    msg=Username not displayed after login — session may have failed.

TC-LOGIN-004 Logout Should Return To Login Page
    [Documentation]    Logs in, logs out, confirms return to login page.
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Verify Dashboard Is Loaded
    Logout
    Verify Login Page Is Loaded

TC-LOGIN-005 Empty Credentials Should Show Validation Error
    [Documentation]    Clicks Login without entering credentials — expects validation.
    Click Login Button
    Verify Required Field Error Is Shown

TC-LOGIN-006 Invalid Credentials Should Show Error Alert
    [Documentation]    Enters wrong credentials — expects the error banner.
    Login With Credentials    invalid_user    wrong_password
    Verify Login Error Is Shown

*** Keywords ***
Navigate To Login Page
    [Documentation]    Navigates the browser back to the login URL before each test.
    Run Keyword And Ignore Error    Logout
    Go To    ${URL}
    Wait Until Element Is Visible    xpath=//input[@name="username"]    10s

