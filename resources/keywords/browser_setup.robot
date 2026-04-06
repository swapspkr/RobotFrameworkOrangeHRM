*** Settings ***
Documentation    Browser lifecycle keywords — open, configure, and close browser.
Library          SeleniumLibrary
Library          OperatingSystem
Library          DateTime
Library    String
Resource         ../variables/common_variables.robot

*** Keywords ***
Open My Browser
    [Documentation]    Opens Chrome and navigates to the given URL.
    [Arguments]    ${url}=${BASE_URL}    ${browser}=${BROWSER}    ${headless}=${HEADLESS}
    ${options}=    Get Chrome Options    ${headless}
    Open Browser    ${url}    ${browser}    options=${options}
    Maximize Browser Window
    Set Browser Implicit Wait    ${IMPLICIT_WAIT}

Get Chrome Options
    [Documentation]    Builds ChromeOptions with stability flags and optional headless mode.
    [Arguments]    ${headless}=${FALSE}
    ${options}=    Evaluate    selenium.webdriver.ChromeOptions()    modules=selenium
    Evaluate       $options.add_argument('--no-sandbox')
    Evaluate       $options.add_argument('--disable-dev-shm-usage')
    Evaluate       $options.add_argument('--window-size=1920,1080')
    ${headless}=    Convert To Boolean    ${headless}
    IF    ${headless}
        Evaluate   $options.add_argument('--headless=new')
    END
    RETURN    ${options}

Close My Browser
    [Documentation]    Closes all open browser windows cleanly.
    Close Browser

Take Screenshot On Failure
    [Documentation]    Captures a timestamped screenshot when a test fails.
    ...                Called automatically from Test Teardown.
    ...                Screenshots saved to: results/screenshots/
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${safe_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    ${filename}=     Set Variable    FAIL_${safe_name}_${timestamp}.png
    ${filepath}=     Set Variable    ${SCREENSHOTS_DIR}/${filename}
    Create Directory    ${SCREENSHOTS_DIR}
    Run Keyword And Ignore Error    Capture Page Screenshot    ${filepath}
    Log    Screenshot saved: ${filepath}    level=WARN

Handle Test Teardown
    [Documentation]    Runs after EVERY test. Takes screenshot only on failure.
    ...                Add this as Test Teardown in your test suite Settings.
    Run Keyword If Test Failed    Take Screenshot On Failure