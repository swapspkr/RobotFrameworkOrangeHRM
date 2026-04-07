*** Settings ***
Documentation    Shared utility keywords used across all test suites.
Library          SeleniumLibrary
Library          ../../libraries/config_reader.py
Resource         ../variables/common_variables.robot

*** Keywords ***
# ============================================================
# ENVIRONMENT CONFIGURATION
# ============================================================
Load Environment Config
    [Documentation]    Reads the active YAML config and sets all suite variables.
    ...                Call this in Suite Setup before opening the browser.
    ...                Override config file via: --variable CONFIG_FILE:config/staging.yaml
    [Arguments]    ${config_file}=${CONFIG_FILE}
    Log    Loading config: ${config_file}    level=INFO
    ${config}=    Read Config    ${config_file}
    Set Suite Variable    ${BASE_URL}         ${config}[application][base_url]
    Set Suite Variable    ${APP_NAME}         ${config}[application][app_name]
    Set Suite Variable    ${ADMIN_USERNAME}   ${config}[credentials][username]
    Set Suite Variable    ${ADMIN_PASSWORD}   ${config}[credentials][password]
    Set Suite Variable    ${BROWSER}          ${config}[browser][name]
    Set Suite Variable    ${IMPLICIT_WAIT}    ${config}[browser][implicit_wait]
    Set Suite Variable    ${EXPLICIT_WAIT}    ${config}[browser][explicit_wait]
    # Grid URL — loaded from YAML so each environment can point to its own hub.
    # USE_GRID is intentionally NOT set here — it is a CLI/infrastructure flag
    # (--variable USE_GRID:true) and must not be overridden by YAML values.
    ${grid}=    Evaluate    $config.get('grid', {})
    ${grid_url_from_yaml}=    Evaluate    $grid.get('url', 'http://localhost:4444/wd/hub')
    Set Suite Variable    ${GRID_URL}    ${grid_url_from_yaml}
   Log    ✔ Config loaded | ENV: ${config}[environment] | URL: ${BASE_URL} | Grid: ${USE_GRID} | GridURL: ${GRID_URL}    level=INFO

# ============================================================
# WAITS & INTERACTIONS (your existing keywords below)
# ============================================================
Verify Page Title Contains
    [Documentation]    Gets the browser tab title and asserts it contains expected text.
    [Arguments]    ${expected_text}
    ${title}=    Get Title
    Should Contain    ${title}    ${expected_text}
    ...    msg=Page title does not contain '${expected_text}'. Actual: '${title}'

Element Should Be Visible On Page
    [Documentation]    Waits up to 15 seconds for element to appear, then asserts it.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=15 sec
    ...    error=Element not found: ${locator}

Click On Element
    [Documentation]    Waits for element to be clickable then clicks it.
    [Arguments]    ${locator}
    Log    Clicking element: ${locator}    level=DEBUG
    Wait Until Element Is Visible    ${locator}    timeout=15 sec
    Click Element    ${locator}

Enter Text Into Field
    [Documentation]    Clears a field and types the given value.
    [Arguments]    ${locator}    ${value}
     Log    Typing '${value}' into: ${locator}    level=DEBUG
    Wait Until Element Is Visible    ${locator}    timeout=15 sec
    Clear Element Text               ${locator}
    Input Text                       ${locator}    ${value}