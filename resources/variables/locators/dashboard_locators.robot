*** Settings ***
Documentation    All locators for the OrangeHRM Dashboard page.

*** Variables ***
# -------------------------------------------------------
# Dashboard Header
# -------------------------------------------------------
${DASHBOARD_HEADER}     xpath=//h6[normalize-space()='Dashboard']

# -------------------------------------------------------
# Top Navigation Bar
# -------------------------------------------------------
${USER_MENU}            xpath=//li[contains(@class,'oxd-userdropdown')]
${USER_DISPLAY_NAME}    xpath=//p[contains(@class,'oxd-userdropdown-name')]
${LOGOUT_OPTION}        xpath=//a[normalize-space()='Logout']