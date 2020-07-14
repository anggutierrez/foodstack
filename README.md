# foodstack

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
foodstack is a meal prep and calorie counting companion app. Where you can save recipes and track your calorie history.

### App Evaluation
- **Category:** Health & Nutrition
- **Mobile:** True
- **Story:** Companion app to aid users in making healthier food choices.
- **Market:** Anyone that wants to make healthier food choices can use this app! Ranging from the average person that wants to track their food habits and athletes that use the app for meal-prepping!
- **Habit:** Users can make additions to their logs after every meal and spend time browsing their saved recipes/preps.
- **Scope:** foodstack will feel like more of a food diary that has the potential to have more of a "food community" feel with a few more functionalities like timeline updates, recipe sharing, and picture views of food creations from the community.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Sign Up for foodstack account
* Log in / Log Out to foodstack
* Use Camera to set profile picture
* User can view calories based on the food they enter
* User can create "meal prep" lists
* Location-logged eating habits
    * Google Maps SDK
* Double-tap to favorite recipes
* Visual Polish
    * Auto-layout
    * Change between views with a button
    * Animations
    * External library

**Optional Nice-to-have Stories**

* Persisted User across app restarts
* Use camera to share pictures of food to a feed
* "Explore"/"Discover" page for food, meal preps, and recipes
* Subscribe/follow a user to keep track of their food with them (togglable)


### 2. Screen Archetypes

* Login Screen
   * User can login and logout
* Register Screen
   * User can register
* Timeline Screen
    * User can see their recent entries
* Recipes & Meal Prep
    * Users can see their saved lists

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Timeline
* Recipes & Meal Preps

**Flow Navigation** (Screen to Screen)

* Login Sceen
    * Register screen
* Timeline Screen
* Recipes and Meal prep screen
    * Compose screen

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://i.imgur.com/qTVA6uF.jpg" width=600>

## Schema 

### User
| Property  | Type   | Description |
| --------- | ------ | --- |
| createdAt | string | post time |
| author | string | username |
| profileImageView | file | user takes picture to update their profile photo |

### Entry
| Property  | Type   | Description |
| --------- | ------ | --- |
| createdAt | string | post time |
| description | string | to view the contents of the entry |
| calorieCount | integer | number of calories eaten |

### Recipes
| Property | Type | Description |
| -------- | -------- | -------- |
| recipeName | string | name of the recipe |
| recipeDescription | string | description of the recipe |
| calorieCount | integer | used to present calorie count to user |
| ingredientCount | integer | used to present number of ingredients to user |
| servingSize | integer | used to make calorie counts |



### Networking
- Timeline
    - (Read/GET) Query all entries where user is author
- Lists
    - (Read/GET) Query all recipes where user is author
- Compose
    - (Create/POST) Create a new entry
- Add Recipe
    - (Create/POST) Create a new recipe
- Search
    - (Create/POST) Create a favorite on a recipe
    - (Delete) Delete existing like

- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
