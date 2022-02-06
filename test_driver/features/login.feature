Feature: Login 

    Scenario: Login with incorrect account

        Given "login-page" appeared

        Then I fill "login-page-email-field" with "incorrect-account.@gmail.com"
        Then I fill "login-page-password-field" with "12345678"

        When I tap the "login-page-login-button"

        Then I should see "login-page-email-field" appeared


    Scenario: Login with correct account

        Given "login-page" appeared

        Then I fill "login-page-email-field" with "narate65.13@gmail.com"
        Then I fill "login-page-password-field" with "12345678"

        When I tap the "login-page-login-button"
        
        Then I should see "home-navigation-page" appeared