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
    Input Username    standard_user
    Input Password    secret_sauce
    Submit Credentials
    Shopping Page Should Be Open
    Minimize browser window
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Swag Labs

Input Username
    [Arguments]    ${username}
    Input Text    username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password    ${password}

Submit Credentials
    Click Button    login-button

Shopping Page Should Be Open
    Title Should Be    Swag Labs
    Wait until element is visible    id=product-page

