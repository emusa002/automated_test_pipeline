*** Settings ***
Documentation     A test suite.
Library  SeleniumLibrary

*** Variables ***
${LOGIN URL}      https://emusa002.github.io/automated_test_pipeline/index.html
${BROWSER}        headlesschrome

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Maximize browser window
#    Input Username    demo
#    Input Password    mode
#    Submit Credentials
#    Welcome Page Should Be Open
    Minimize browser window
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Login Page

Input Username
    [Arguments]    ${username}
    Input Text    username_field    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password_field    ${password}

Submit Credentials
    Click Button    login_button

Welcome Page Should Be Open
    Title Should Be    Welcome Page

