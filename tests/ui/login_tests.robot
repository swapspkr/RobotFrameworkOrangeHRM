***** Settings ***
Documentation    Login page functional tests.
...              Demonstrates: tags, screenshot on failure, test teardown, logging.
...
...              Run all:        robot tests/ui/login_tests.robot
...              Run smoke only: robot --include smoke tests/ui/login_tests.robot
...              Skip wip:       robot --exclude wip tests/ui/login_tests.robot
Resource         ../../resources/keywords/browser_setup.robot
Resource         ../../resources/keywords/common_keywords.robot
Resource         ../../resources/page_objects/login_page.robot
Resource         ../../resources/page_objects/dashboard_page.robot

Suite Setup      Initialize Test Suite
Suite Teardown   Close My Browser
Test Setup       Navigate To Login Page
Test Teardown    Handle Test Teardown

Test Tags        regression    ui    login

*** Test Cases ***
TC-LOGIN-001 Login Page Should Load Correctly
    [Documentation]    Verifies all key elements visible on login page.
    [Tags]    smoke    critical
    Verify Login Page Is Loaded

TC-LOGIN-002 Valid Login Should Reach Dashboard
    [Documentation]    Logs in with valid credentials — confirms dashboard loads.
    [Tags]    smoke    critical
    Login With Credentials    ${ADMIN_USERNAME}   ${ADMIN_PASSWORD}
    Verify Dashboard Is Loaded

TC-LOGIN-003 Dashboard Should Show Logged In Username
    [Documentation]    Confirms the username appears in the nav bar after login.
    Login With Credentials    ${ADMIN_USERNAME}    ${ADMIN_PASSWORD}
    ${name}=    Get Logged In User Name
    Should Not Be Empty    ${name}
    ...    msg=Username not displayed — session may have failed.

TC-LOGIN-004 Logout Should Return To Login Page
    [Documentation]    Full login → logout → confirm back to login page.
    [Tags]    smoke
    Login With Credentials    ${ADMIN_USERNAME}    ${ADMIN_PASSWORD}
    Verify Dashboard Is Loaded
    Logout
    Verify Login Page Is Loaded

TC-LOGIN-005 Empty Credentials Should Show Validation Error
    [Documentation]    Submitting blank form shows required field validation.
    Click Login Button
    Verify Required Field Error Is Shown

TC-LOGIN-006 Invalid Credentials Should Show Error Alert
    [Documentation]    Wrong credentials displays the error banner.
    Login With Credentials    invalid_user    wrong_password
    Verify Login Error Is Shown

TC-LOGIN-007 Forgot Password Link Should Navigate To Reset Page
    [Documentation]    Clicks the forgot password link — verifies navigation.
    Click Forgot Password Link
    Wait Until Page Contains    Reset Password    timeout=${MEDIUM_WAIT}

TC-LOGIN-008 WIP - New SSO Login Flow
    [Documentation]    SSO feature not yet implemented — excluded from CI runs.
    [Tags]    wip
    Log    SSO login test placeholder — not yet implemented    level=WARN
    Pass Execution    Skipping — SSO feature under development

*** Keywords ***
Initialize Test Suite
    [Documentation]    Loads environment config then opens the browser.
    Load Environment Config
    Open My Browser

Navigate To Login Page
    [Documentation]    Resets browser to the login URL before each test.
    Run Keyword And Ignore Error    Logout
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    xpath=//input[@name="username"]    10s

