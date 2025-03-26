*** Settings ***
Documentation     A test suite.
Library  SeleniumLibrary

*** Variables ***
${LOGIN URL}      https://emusa002.github.io/automated_test_pipeline/index.html
${BROWSER}        headlesschrome
${SUCCESS_LOCATOR}  id=product-page
${ERROR_LOCATOR}    id=error-message

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Maximize browser window
    Input Username    standard_user
    Input Password    wrong_password
    Submit Credentials
    Wait For Login Outcome
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

Wait For Login Outcome
    Wait Until Any Elements Are Visible    ${SUCCESS_LOCATOR}    ${ERROR_LOCATOR}    timeout=10
    ${success}=    Run Keyword And Return Status    Element Should Be Visible    ${SUCCESS_LOCATOR}
    ${error}=      Run Keyword And Return Status    Element Should Be Visible    ${ERROR_LOCATOR}
    Run Keyword If    ${error}    Fail    Login failed: Error message displayed

Shopping Page Should Be Open
    Title Should Be    Swag Labs


Wait Until Any Elements Are Visible
    [Arguments]    @{locators}    ${timeout}=10
    ${start_time}=    Get Time    epoch
    FOR    ${locator}    IN    @{locators}
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible   ${locator}    timeout=5s
    Run Keyword If    ${status}    Return From Keyword
    ${elapsed}=    Evaluate    time.time() - ${start_time}    modules=time
    Exit For Loop If    ${elapsed} > ${timeout}
    END
    Sleep    1s
    Fail    None of the expected elements appeared within timeout.