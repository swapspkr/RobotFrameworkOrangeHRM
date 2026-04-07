*** Settings ***
Documentation    Browser lifecycle keywords — open, configure, and close browser.
Library          SeleniumLibrary
Library          OperatingSystem
Library          DateTime
Library    String
Resource         ../variables/common_variables.robot

*** Keywords ***
Open My Browser
    [Documentation]    Opens browser locally or via Selenium Grid depending on USE_GRID.
    [Arguments]    ${url}=${BASE_URL}    ${browser}=${BROWSER}    ${headless}=${HEADLESS}
    ${use_grid}=    Convert To Boolean    ${USE_GRID}
    IF    ${use_grid}
        Open Browser On Grid    ${url}    ${browser}
    ELSE
        ${options}=    Get Chrome Options    ${headless}
        Open Browser    ${url}    ${browser}    options=${options}
        Maximize Browser Window
    END
    Set Browser Implicit Wait    ${IMPLICIT_WAIT}

Open Browser On Grid
    [Documentation]    Opens browser via Selenium Grid remote WebDriver.
    ...                Grid URL set by GRID_URL variable (default: http://localhost:4444/wd/hub).
    ...                Nodes run headless inside Docker — headless flag is forced on.
    [Arguments]    ${url}=${BASE_URL}    ${browser}=${BROWSER}
    ${options}=    Get Chrome Options    ${TRUE}    # Grid nodes always run headless
    Open Browser    ${url}    ${browser}
    ...    remote_url=${GRID_URL}
    ...    options=${options}
    Set Window Size    1920    1080
    Log    Browser opened on Selenium Grid: ${GRID_URL}    level=INFO

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