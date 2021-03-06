Feature: Login 

    Scenario: Login with incorrect account

        Given "login-page" appeared

        Then I fill "login-page-email-field" with "incorrect-account.@gmail.com"
        Then I fill "login-page-password-field" with "12345678"

        When I tap the "login-page-login-button"

        Then I should see "login-page-email-field" appeared


    Scenario: Login with correct account

        Given "login-page" appeared

        Then I fill "login-page-email-field" with "poc@project.com"
        Then I fill "login-page-password-field" with "12345678"
        # Then I fill "login-page-password-field" with "87654321"
        # for dev flavor


        When I tap the "login-page-login-button"
        
        Then I should see "home-navigation-page" appeared