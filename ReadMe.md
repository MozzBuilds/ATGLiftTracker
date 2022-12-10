
#ATG Lift Tracker


## App Purpose
Simple, offline, ad free, app for tracking gym exercises. Quick to open, quick to find your exercise e.g. bench, and quick to add your recent sets


## Home Page

### MVP
* User opens app, sees the home page
* There will be the compound exercises already there
* User sees all the exercises they've added
* Exercises are organised by name (or date)
* User can add a new exercise by pressing a button. Presented modally
* New exercise gets added, table refreshes
* User clicks on any exercise, taken to a page for that exercise
* When a user comes back from said page, the home page data refreshes
* Exercise cell shows the name

### Nice to have
* Search function on home screen for exercises
* Sort capability on home screen, for Name, or Date Last Modified (date of last entry on the exercises)
* Scroll to bottom/scroll to top buttons
* Exercise cell shows the name, last date lifted, and the very last entry
* Favourite exercises can be chosen and stay up top

## Exercise Specific Page

### MVP
* Users can quickly add a new entry of a lift they made, with a date, weight, reps, sets
* Any entries on the same date, get added to the same cell
* Any entries on the same date/weight/reps, get their sets added together instead of a new entry on the cell
* Latest entry up top
* Back button goes back to home page

### Nice to have
* Some kind of trend or data graph showing progress


## Development Process

* Use MVVM
* Can I use a common view for the 'add new' alert?
* Use asset colors
* Styles sheet that can return a style, which has a font, text size, text color etc
* Work with light and dark mode, using the phones system settings
* Data will be saved as a dictionary, locally. Do UserDefaults to start with because its easy, but structure the class so we can easily then change it to more secure data persistence, for potential future work
* Apply SOLID principles, taking advantage of protocols
* Unit testing!
* Use workers for models for things like reading/writing to data and passing the data back, for the model to then decode into what it needs


### Extremes to think about
* User quitting then re-opening app
* Interruptions when adding entries (e.g. phonecall)
* App timeout


### ViewModel Structure

*QUESTIONS
    - Clicking a cell. Cell was selected. Whose responsibility for kicking off the next VC?
        - Current VC?
        - The VC's viewModel?
        - The cells viewModel?
    - Table within a cell, whats the VM laws for that?
    

* ViewModels are used to hold logic for a view controller
* They will grab data from the models, to then clean it/interpret it/pass it to the VC
* A VC will have one viewModel, and in this case our HomeVC's model will contain the data needed for the cells
* However this data will be passed to the cells via viewModel, using the tableView method, viewModelForCellAt
    - cell.viewModel => viewControllerViewModel.cellViewModelForIndexPath(i)
    - This method will then create a CellViewModel for that cell, which contains the data it needs


HomeViewModel
    - Hosts logic for the HomeViewController
    - Grabs all the model data needed for the app
    - Has a method to assign an ExerciseCellViewModel to an ExerciseCell on the homepage
    - This ViewModel contains all the model data for that exercise
    
ExerciseCellViewModel:
    - Use to provide model data for the Exercise cells on the home page
    - Will be one model for each cell
    - Data includes:
        name: String
        lastDate: String - The most recent entry date for that exercise
        lastWeight: Decimal trimmed to 2 decimal places, as above
        lastReps: Int, as above
        lastSets: Int, as above
    
ExerciseViewModel:
    - Hosts logic the Exercise ViewController
    - Provides a method to assign an ExerciseSessionCellViewModel, to an ExerciseSessionCell
    - And can handle things like overlaying a new VC for adding a new entry, then sending this data to be saved etc
    
ExerciseSessionCellViewModel:
    - Used to provide the data to an ExerciseSessionCell
    - Will be one cell for each model. And each cell will have data about a whole dates gym session
    - Then provides an ExerciseSessionEntryCellViewModel for each cell in the ExerciseSessionCell's table
    - Handles shit like, when a user adds an a new entry, if its the same as the one before, combine the sets in an entryCell already there..
    - 
    
ExerciseSessionEntryCellViewModel:
    - Used to provide the data to an ExerciseSessionEntryCell
    - Will be one cell for each model
    - Just holds weight, reps, sets

----------------------------------------------------

On the Homescreen view controller, the cell will:
* Be based on an Exercise model
* Use the name of the exercise
* Show the most recent exerciseSession'd date (can protocol this!)
* Show the most recent exerciseSession's exerciseSessionEntry for that date

On the Exercise view controller, the cell will:
* Be based on the ExerciseSession model
* Use the date of the exercise session
* Then create a sub table in the cell, of all Exercise Session Entries, for that session
* The sub cell will display them all from highest to lowest weight
