@javascript
Feature: Spending monster points around games
  As a user with a character
  I want to be able to spend monster points on the character
  So that I can increase the rank of the character without playing them on a game
  
  Background:
    Given there is a user
    And the user is logged in
    And the user has a character
    And there is a game in the past
    And the user has 100 monster points available

  Scenario: Can spend after a game played as the character
    Given the character has 20 character points
    And the character was on the game
    And the game has been debriefed
    And the character has received 10 character points in the debrief
    When the user buys 1 character point for the character after the game
    Then the character should have 31 character points
  
  Scenario: Cannot spend before a game played as the character if it has been debriefed
    Given the character has 20 character points
    And the character was on the game
    And the game has been debriefed
    And the character has received 10 character points in the debrief
    When the user tries to buy character points for the character before the game
    Then the user should be told they cannot create a monster point spend before their most recent debriefed game
  
  Scenario: Can spend before a game played as the character if the debrief has not been started
    Given the character has 20 character points
    And the character was on the game
    And the game has not been debriefed
    When the user buys 1 character point for the character before the game
    Then the character should have 21 character points
  
  Scenario: Can spend before a game played as the character if the debrief has not been finished
    Given the character has 20 character points
    And the character was on the game
    And the game debrief has been started
    When the user buys 1 character point for the character before the game
    Then the character should have 21 character points
  
  Scenario: After playing a game, the number of CP you can buy is reset
    Given the character has 150 character points
    And the user bought 30 character points for the character before the game
    And the character was on the game
    And the game has been debriefed
    And the character has received 10 character points in the debrief
    When the user buys 30 character points for the character after the game
    Then the character should have 190 character points
  
  Scenario: After playing a non-stats game, the number of CP you can buy is not reset
    Given the character has 150 character points
    And the user bought 29 character points for the character before the game
    And the character was on the game
    And the game is a non-stats game
    And the game has been debriefed
    And the character has received 10 character points in the debrief
    When the user tries to buy 2 character points for the character after the game
    Then the user should be told they cannot buy more than 1 character point

