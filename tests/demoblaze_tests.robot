*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/keywords.robot
Suite Setup       Open Browser To DemoBlaze
Suite Teardown    Close Browser

*** Variables ***
${USERNAME}       loginusername
${PASSWORD}       loginpassword

*** Test Cases ***
Test Case 1: User Login
    [Tags]    screenshot
    Login To DemoBlaze    ${USERNAME}    ${PASSWORD}
    Page Should Contain Element    xpath=//a[@id='logout2']
    Page Should Contain    Welcome ${USERNAME}
    Logout From DemoBlaze

Test Case 2: Add Highest Priced Monitor to Cart
    [Tags]    screenshot
    Login To DemoBlaze    ${USERNAME}    ${PASSWORD}
    Click Link    Monitors
    ${highest_priced_product}=    Get Product With Highest Price
    Click On Product By Name    ${highest_priced_product}[1]
    Add Product To Cart
    Click Link    Cart
    Verify Product In Cart    ${highest_priced_product}
    Logout From DemoBlaze
