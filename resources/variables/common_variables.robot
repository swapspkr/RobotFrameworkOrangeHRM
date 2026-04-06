*** Settings ***
Documentation    Global variable declarations for the framework.
...              These are EMPTY by default — populated at Suite Setup
...              by reading the active YAML config file.

*** Variables ***
# -------------------------------------------------------
# Config control — override via CLI:
#   robot --variable CONFIG_FILE:config/staging.yaml tests/
# -------------------------------------------------------
${CONFIG_FILE}          config/dev.yaml

# -------------------------------------------------------
# Application — set from YAML at runtime
# -------------------------------------------------------
${BASE_URL}             ${EMPTY}
${APP_NAME}             OrangeHRM

# -------------------------------------------------------
# Credentials — set from YAML at runtime
# -------------------------------------------------------
${ADMIN_USERNAME}       ${EMPTY}
${ADMIN_PASSWORD}       ${EMPTY}

# -------------------------------------------------------
# Browser — set from YAML at runtime
# -------------------------------------------------------
${BROWSER}              chrome
${HEADLESS}             ${FALSE}
${IMPLICIT_WAIT}        10
${EXPLICIT_WAIT}        30

# -------------------------------------------------------
# Timeouts (used in page objects and keywords)
# -------------------------------------------------------
${SHORT_WAIT}           5 sec
${MEDIUM_WAIT}          15 sec
${LONG_WAIT}            30 sec

# -------------------------------------------------------
# Reporting
# -------------------------------------------------------
${SCREENSHOTS_DIR}      results/screenshots