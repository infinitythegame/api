Feature: Snippets
  In order to not manually write definitions every time
  As a feature tester
  I need tool to generate snippets for me

  Background:
    Given a file named "features/coffee.feature" with:
      """
      Feature: Snippets

        Background:
          Given I have magically created 10$

        Scenario: Single quotes
          When I have chose 'coffee with turkey' in coffee machine
          Then I should have 'turkey with coffee sauce'
          And I should get a 'super/string':
            '''
            Test #1
            '''
          And I should get a simple string:
            '''
            Test #2
            '''

        Scenario: Double quotes
          When I have chose "pizza tea" in coffee machine
          And do something undefined with \1
          Then I should have "pizza tea"
          And I should get a "super/string":
            '''
            Test #1
            '''
          And I should get a simple string:
            '''
            Test #2
            '''
      """

  Scenario: Regex snippets
    Given a file named "features/bootstrap/FeatureContext.php" with:
      """
      <?php

      use Behat\Behat\Context\CustomSnippetAcceptingContext,
          Behat\Behat\Tester\Exception\PendingException;
      use Behat\Gherkin\Node\PyStringNode,
          Behat\Gherkin\Node\TableNode;

      class FeatureContext implements CustomSnippetAcceptingContext {
          public static function getAcceptedSnippetType() { return 'regex'; }
      }
      """
    When I run "behat --no-colors -f progress features/coffee.feature"
    Then it should pass with:
      """
      UUUUUUUUUUU

      2 scenarios (2 undefined)
      11 steps (11 undefined)

      --- FeatureContext has missing steps. Define them with these snippets:

          /**
           * @Given /^I have magically created (\d+)\$$/
           */
          public function iHaveMagicallyCreated($arg1)
          {
              throw new PendingException();
          }

          /**
           * @When /^I have chose '([^']*)' in coffee machine$/
           */
          public function iHaveChoseCoffeeWithTurkeyInCoffeeMachine($arg1)
          {
              throw new PendingException();
          }

          /**
           * @Then /^I should have '([^']*)'$/
           */
          public function iShouldHaveTurkeyWithCoffeeSauce($arg1)
          {
              throw new PendingException();
          }

          /**
           * @Given /^I should get a '([^']*)':$/
           */
          public function iShouldGetASuperString($arg1, PyStringNode $string)
          {
              throw new PendingException();
          }

          /**
           * @Given /^I should get a simple string:$/
           */
          public function iShouldGetASimpleString(PyStringNode $string)
          {
              throw new PendingException();
          }

          /**
           * @When /^I have chose "([^"]*)" in coffee machine$/
           */
          public function iHaveChoseInCoffeeMachine($arg1)
          {
              throw new PendingException();
          }

          /**
           * @Given /^do something undefined with \\(\d+)$/
           */
          public function doSomethingUndefinedWith($arg1)
          {
              throw new PendingException();
          }

          /**
           * @Then /^I should have "([^"]*)"$/
           */
          public function iShouldHave($arg1)
          {
              throw new PendingException();
          }

          /**
           * @Given /^I should get a "([^"]*)":$/
           */
          public function iShouldGetA($arg1, PyStringNode $string)
          {
              throw new PendingException();
          }
      """

  Scenario: Regex snippets are working
    Given a file named "features/bootstrap/FeatureContext.php" with:
      """
      <?php

      use Behat\Behat\Context\CustomSnippetAcceptingContext,
          Behat\Behat\Tester\Exception\PendingException;
      use Behat\Gherkin\Node\PyStringNode,
          Behat\Gherkin\Node\TableNode;

      class FeatureContext implements CustomSnippetAcceptingContext {
          public static function getAcceptedSnippetType() { return 'regex'; }
      }
      """
    When I run "behat --no-colors -f progress --append-snippets features/coffee.feature"
    And I run "behat --no-colors -f progress features/coffee.feature"
    Then it should pass with:
      """
      P----P-----

      --- Pending steps:

          Given I have magically created 10$ # FeatureContext::iHaveMagicallyCreated()
            TODO: write pending definition

          Given I have magically created 10$ # FeatureContext::iHaveMagicallyCreated()
            TODO: write pending definition

      2 scenarios (2 pending)
      11 steps (2 pending, 9 skipped)
      """

  Scenario: Turnip snippets
    Given a file named "features/bootstrap/FeatureContext.php" with:
      """
      <?php

      use Behat\Behat\Context\SnippetAcceptingContext,
          Behat\Behat\Tester\Exception\PendingException;
      use Behat\Gherkin\Node\PyStringNode,
          Behat\Gherkin\Node\TableNode;

      class FeatureContext implements SnippetAcceptingContext { }
      """
    When I run "behat --no-colors -f progress features/coffee.feature"
    Then it should pass with:
      """
      UUUUUUUUUUU

      2 scenarios (2 undefined)
      11 steps (11 undefined)

      --- FeatureContext has missing steps. Define them with these snippets:

          /**
           * @Given I have magically created :arg1$
           */
          public function iHaveMagicallyCreated($arg1)
          {
              throw new PendingException();
          }

          /**
           * @When I have chose :arg1 in coffee machine
           */
          public function iHaveChoseInCoffeeMachine($arg1)
          {
              throw new PendingException();
          }

          /**
           * @Then I should have :arg1
           */
          public function iShouldHave($arg1)
          {
              throw new PendingException();
          }

          /**
           * @Given I should get a :arg1:
           */
          public function iShouldGetA($arg1, PyStringNode $string)
          {
              throw new PendingException();
          }

          /**
           * @Given I should get a simple string:
           */
          public function iShouldGetASimpleString(PyStringNode $string)
          {
              throw new PendingException();
          }

          /**
           * @Given do something undefined with \:arg1
           */
          public function doSomethingUndefinedWith($arg1)
          {
              throw new PendingException();
          }
      """

  Scenario: Turnip snippets are working
    Given a file named "features/bootstrap/FeatureContext.php" with:
      """
      <?php

      use Behat\Behat\Context\SnippetAcceptingContext,
          Behat\Behat\Tester\Exception\PendingException;
      use Behat\Gherkin\Node\PyStringNode,
          Behat\Gherkin\Node\TableNode;

      class FeatureContext implements SnippetAcceptingContext { }
      """
    When I run "behat --no-colors -f progress --append-snippets features/coffee.feature"
    And I run "behat --no-colors -f progress features/coffee.feature"
    Then it should pass with:
      """
      P----P-----

      --- Pending steps:

          Given I have magically created 10$ # FeatureContext::iHaveMagicallyCreated()
            TODO: write pending definition

          Given I have magically created 10$ # FeatureContext::iHaveMagicallyCreated()
            TODO: write pending definition

      2 scenarios (2 pending)
      11 steps (2 pending, 9 skipped)
      """
