*** Settings ***
Documentation    Standalone smoke suite — intentionally separate from login_tests
...              so pabot can run them in parallel.
Resource         ../../resources/keywords/browser_setup.robot
Resource         ../../resources/keywords/common_keywords.robot
Resource         ../../resources/page_objects/login_page.robot

Suite Setup      Initialize Smoke Suite
Suite Teardown   Close My Browser
Test Teardown    Handle Test Teardown

Test Tags        smoke    ui

*** Test Cases ***
TC-SMOKE-001 Application Should Be Reachable
    [Documentation]    Confirms the app URL loads (no login needed).
    Verify Login Page Is Loaded

TC-SMOKE-002 Login Page Title Should Be Correct
    [Documentation]    Verifies the OrangeHRM page title.
    Verify Page Title Contains    OrangeHRM

*** Keywords ***
Initialize Smoke Suite
    Load Environment Config
    Open My Browser