*** Settings ***
Documentation    My first Robot Framework test.
Library          SeleniumLibrary
Resource         ../../resources/keywords/browser_setup.robot
Resource         ../../resources/keywords/common_keywords.robot
Suite Setup      Open My Browser    ${URL}   ${BROWSER}
Suite Teardown   Close My Browser


*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}    chrome

*** Test Cases ***
TC-001 Application Login Page Should Load
    [Documentation]    Verifies the OrangeHRM login page title.
    Verify Page Title Contains      OrangeHRM

TC-002 Login Page Should Have Username Field
    [Documentation]    Verifies the username input field is present.
    Element Should Be Visible On Page   xpath=//input[@name="username"]

TC-003 Login Page Should Have Password Field
    [Documentation]    Verifies the password input field is present.
    Element Should Be Visible On Page   xpath=//input[@name='password']
    
TC-004 Validate forgot password link
    [Documentation]     Verifies the forgot password link is present.
    Element Should Be Visible    xpath=//p[normalize-space()='Forgot your password?']