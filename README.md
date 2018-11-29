# New[sic]

## What is New[sic]?

• New[sic] lets users pull news articles based on any subject crawling and indexing through relevant articles from over 30,000 news sources and blogs within the last 29 days thanks to and powered by NewsAPI.org. 

## Setup:

• Currently the New[sic] app is not in the app store.  To access, a user will need to need to have a mac computer and download Xcode from the app store on their mac.  They can then download the file from Github: https://github.com/bbattiste/Newsic2.0 

• Click Clone or download on the right and then click Download ZIP from the dropdown.  New[sic] will be under filename newsic and can be opened with Xcode.

• Once Xcode is open, the user can click on the play button at the top of Xcode to build the app in a simulator.

## How to use?

### Initial Search View:
• By tapping on the initial search view's textField, users can type in any subject they would like to search and tap the search button.  If any errors occur based on the search, users will be notified below the text box.  If the search is successful,
users will be brought to all the news articles the app found in the news view.

• Users are able to save articles for later and will persist in the New[sic] app's core data.  At the bottom of this initial search view, users can skip searching for articles and tap the saved icon to access the saved articles in the saved view
straight from this initial search view.

![nsearchscreen](https://user-images.githubusercontent.com/20981744/49249109-a4501f80-f3d8-11e8-9296-782ed96066d6.png)

### News View:
• Users can look at different news articles found by swiping up and down on this view shown by different rows of information.

• By tapping on a row of information, the app will open the link associated with the news article in the safari app.  If a user would like to return to the New[sic] app, a return link will be at the top left of the safari app.

• If the user would like to save an article to the app, they can tap on the save button to the right of an article row.  The user will see that the app is saved by the save button changing from the label: "Save" to "Saved" and change the button's background color to gray.

• If the user would like to unsave any instances of this article, they can do this by retapping on the now gray "Saved" labeled button where the "Save" labeled button used to be.

• Users can return to the initial search view by tapping the Search button at the top left of the screen.

• If users would like to access the saved articles, they can tap the "Saved Articles" button at the top right of the screen.

![nnewsscreen](https://user-images.githubusercontent.com/20981744/49249080-969a9a00-f3d8-11e8-849d-5d84f5ca5f4a.png)

### Saved Articles View:
• Users can look at different saved articles found by swiping up and down on this view shown by different rows of information.

• By tapping on a row of information, the app will open the link associated with the saved news article in the safari app.  If a user would like to return to the New[sic] app, a return link will be at the top left of the safari app.

• If a user would like to delete any saved articles, they can do this in 2 ways:

##### WARNING: If a user deletes an article that was created 30 days or older, they will not be able to access this article again.  It will be permanently inaccessible through the New[sic] app.

  1. The user can tap the delete button at the top right of the screen.  This puts the saved view in edit state.  Any row tapped will now be deleted as well as the saved article associated with it.  To end the edit state, the user can tap the Done button at the top right of the screen.
  
  2. The user can also swipe any row to the left and this will bring up a red delete button to the right of the row.  If they would like to confirm this deletion, they can tap on the red delete button. The row will now be deleted as well as the saved article associated with it.

• If the user accessed the saved articles view from the news view, they can return to the news view by tapping on the back button to the top left of the screen.

• If the user accessed the saved articles view from the search view, they can return to the search view by tapping on the Search tab at the bottom left of the screen

![nsavedscreen](https://user-images.githubusercontent.com/20981744/49249130-add98780-f3d8-11e8-8895-289482f061b5.png)

#### Attribution:
A special thank you to Wyatt Mufson: Attribution to ideas on how to code the newsAPIManager.swift and NewsClient.swift:
https://github.com/WyattMufson/NewsAPI-Swift
