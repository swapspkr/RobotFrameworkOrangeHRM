*** Settings ***
Documentation    All locators for the OrangeHRM Login Page.
...              Centralized here so a single change fixes all tests.

*** Variables ***
# -------------------------------------------------------
# Login Form Elements
# -------------------------------------------------------
${USERNAME_INPUT}       xpath=//input[@name='username']
${PASSWORD_INPUT}       xpath=//input[@name='password']
${LOGIN_BUTTON}         xpath=//button[@type='submit']
${LOGIN_LOGO}           xpath=//div[@class='orangehrm-login-logo']

# -------------------------------------------------------
# Error Messages
# -------------------------------------------------------
${LOGIN_ERROR_ALERT}    xpath=//div[contains(@class,'oxd-alert--error')]
${FIELD_REQUIRED_MSG}   xpath=//span[contains(@class,'oxd-input-field-error-message')]

# -------------------------------------------------------
# Forgot Password
# -------------------------------------------------------
${FORGOT_PWD_LINK}      xpath=//p[normalize-space()='Forgot your password?']