#  Design Document

As this is just a minimum viable product, I did not do much color design. I solely worked on putting out a functional alcohol consumption tracking application. The first thing I did when making this app was create a database of alcoholoic beverages in Microsoft Excel. This database had the brand name, alcohol type, and aBV of each of the alcoholic beverages inside. I got this information by either inputting it myself, or webscraping the information from websites with Python. After I collected data, I had about 150 different beverages in my Excel spreadsheet. I then used a software called "DataGenerator for Excel Lite" to convert the Excel database into a  .plist file called "AlcData.plist".

When I started the XCode project to make this application, I made sure that Core Data was checked, becuase that is what I was going to use to store the alcoholic beverage data. I decided to store this data in Core Data because I thought it would be faster for the application to retrieve data on alcoholic beverages from its own local storage facilities instead of communication with an online database through an API. Also, there were no APIs that had exactly what I was looking for. 

After setting up the XCode project I went to the xcdatamodeld file and created a Core Data entity called Drink which had 3 attributes: abV, brand, and type. After that, the first view controller file I worked on was the  TableViewController.swift file, which displayed all the drinks in the database. 

In order to retrieve data from Core Data, I had to initialize an NSFetchedResultsController. I configured this controller in a function called configureFetchedResultsController. The function looked into Core Data to find "Drink" entities and fetched them in asending alphabetical order of brand.

In the viewDidLoad function of this view controller, the configureFetchedResultsController function was called and the fetched Drink objects were stored in a list called "drinks". They were also stored in a variable called "searchedDrinks", which would be used with the search bar to display only some of the drinks depending on the search through the searchBar function.

The logout button of this view controller has a function onLogout that clears out all UserDefaults, signs the user out with PFUser (will be expanded upon soon), and returns them to the login screen.

After working on the data presentation aspect of the app, I worked on the logging in and out/account creation process. To do this, I used the  cloud platform Heroku to host my application online. I used an online platform called Parse in addition to this so that I could have an online database of objects and users (Parse has a good API for implementing logging in and out/account creation features). 

Account creation happens in the CreateViewController, which is accessed throught the "Sign Up here" button in the LoginViewController. The view controller asks for username, gender, weight, and password. The Parse object, PFUser, is then used with the Parse function "signUpInBackground", to create an account for the user and store it in Parse. 

To sign in on the LoginViewController page, I used the PFUser.loginWithUsername. If the user exists in the Parse database, and the username and passwords match, the user gets to go on to the main part of the application. The sign in function also adds information about the current Parse account user (via PFUser.current( ) ) through User Defaults so that the information can be loaded into the profile page.

After this I worked on the alcoholViewController, the scene that comes up when an alcoholic beverage is clicked on in the tableViewController. The segue to this controller brings the information of the beverage with it, so information on the brand, type, and aBV can be displayed. There is a "Log into Diary" button that logs the amount of alcohol consumed. 

The onLogIntoDiary function used Parse's PFObject object and saveInBackground() function to create a custom class "DiaryEntries" in Parse. I set it up such that each DiaryEntry had the following attributes: userId, date ,brand, aBV, and amount. I gave each object a userId part so that I could ensure only entries associated with the current User would pop up in the DiaryViewController. 

For the DiaryViewController, I made a function called getEntries() that uses Parse's PFQuery functionality to query the Parse database for PFObjects. getEntries looks for objects in the "DiaryEntries" class I created, and picks the ones that were logged by the current user (the ones that have a userId equal to the id of the current user). Each cell in the table view shows the following diary entry information: the date and time, brand, and amount. The table view is set up such that the most recent diary entries show up at the top. I also implemented a refreshControl using UIRefreshControl() so that the diary table view could be refreshed to show new entries if the user logged another entry in.

