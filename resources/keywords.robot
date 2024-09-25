*** Settings ***
Library           SeleniumLibrary
Library           ScreenshotListener
Library           Collections

*** Variables ***
${URL}            https://www.demoblaze.com/
${USERNAME}       test_user
${PASSWORD}       test_password
${BROWSER}        chrome

*** Keywords ***
Open Browser To DemoBlaze
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    1s

Login To DemoBlaze
    [Arguments]    ${username}    ${password}
    Click Element    xpath=//a[@id='login2']
    Wait Until Page Contains Element    id=logInModal
    Input Text    id=loginusername    ${username}
    Input Text    id=loginpassword    ${password}
    Click Button    xpath=//button[@onclick='logIn()']
    Wait Until Page Contains    Welcome ${username}

Logout From DemoBlaze
    Click Element    xpath=//a[@id='logout2']
    Wait Until Page Does Not Contain    Welcome ${username}

Get Product With Highest Price
    ${price_elements}=    Get WebElements    xpath=//*[@class='card-block']/h5
    ${prices}=     Create List
    FOR    ${element}    IN    @{price_elements}
        ${text}=    Get Text    ${element}
        ${price}=    Convert To Integer    ${text}[1:]
        Append To List    ${prices}    ${price}
    END
    ${highest_price}=    Evaluate    max(${prices})
    ${product_name_element}=    Get WebElement    xpath=//h5[contains(text(),'${highest_price}')]/preceding-sibling::h4/a
    ${product_name}=    Get Text    ${product_name_element}
    ${highest_priced_product}=    Create List    ${highest_price}    ${product_name}
    [Return]    ${highest_priced_product}

Update Highest Price
    [Arguments]    ${price}
    ${highest_price}=    Set Global Variable    ${price}

Click On Product By Name
    [Arguments]    ${product_name}
    Click Link    xpath=//a[text()='${product_name}']

Get Product Price
    ${product_price}=    Get Text    xpath=//h3[@class='price-container']
    [Return]    ${product_price}

Add Product To Cart
    Click Link    css=.btn-success
    Alert Should Be Present
    Click Link    Cart

Verify Product In Cart
    [Arguments]    ${product}
    Page Should Contain    ${product}[0]
    Page Should Contain    ${product}[1]

# Listener class to take screenshots based on the tag
*** Settings ***
Library    ScreenshotListener

*** Keywords ***
Take Screenshot On Tag
    [Arguments]    ${message}
    Take Screenshot    results/screenshot-${message}.png