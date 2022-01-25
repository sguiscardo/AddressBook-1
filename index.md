# Address Book: Part 1

In this project, you will use your knowledge of Swift to build an app that allows you to create a group of contacts. What’s exciting about this project is that you will face the challenge of handling the data of multiple Model Objects and how they interface with each other. The UI will be fairly straight forward but the way you handle the data will be the main challenge. 

The final challenge of this project is to allow the data the user creates to persist through multiple app launches.

Students who complete this project independently or as a pairing will showcase their understanding of the following principles:

* Basic Storyboard constraints
* UITableviews
* Creating Custom `class` objects
* Constants, Variables, and Basic Data Types
* Collections
* Functions
* Control Flow
* IBActions && IBOutlets
* Multiple Model Objects
* Multiple Segues
* Local Persistence

---

## Design
Our  Address book app will display `Group` objects in a `UITableView`. Once you create a`Group`  you can segue to a second `List View` that will allow users to `Add` contacts to that group. Navigating from the `PeopleTableView` will land you on a final view in which you can update the particulars on the contact.

This project will use quite a bit of the skills you’ve picked up in Unit2. We feel confident that you’ll be able to build the UI for this app just by seeing how the design looks and feels.  We recommend building this project one `scene` at a time and wiring up the `segue`  at the end.

It's gonna be great! Let's get started…
Initial screen:

![Inital Screen](/AddressBookGroupsTBVC.png)

Second Screen. Take note of what the segue is hi-lighting…

![Second Screen](/ABSegue&PeopleTBVC.png)

Hint for how the blue view is above the `TableView`
* Drag a `UIView` element and hover it UNDER the navigation item - yet ABOVE the tableview. You should see a blue line appear.
* Release to set the `UIView` element in the proper position.
* To view this element easier, change the background color
* Hover your cursor to the bottom-middle of the `UIView`. You should see an icon that looks like a black bar with an up and down arrow. 
* Using this icon, click and drag the `view` until the height is set to `60`
* Great! Now we need to drop a `UITextField` into that view.
* Give this element a `Placeholder` of `Group Name`
* Lock this item in place with `8` point constraints for the `Top`, `Leading`, `Trailing`, and `Bottom`

Final Screen. Take note of what the segue is hi-lighting…

![Final Screen](/FinalScreenAB.png)


Really great work on building that UI from the images! This is similar to what you will experience on-role as an iOS Developer. Now, let’s get to building the `Models` for this project. BUT! Before we do what should you do? 

* A - Always
* B - Be
* C - Committing
---

## Model 1- Create a `Person` model with
```swift
    let id: UUID
    var name: String
    var address: String
```

Create the member-wise initializer
	* Pass in a default value for the `id` property. The default value should be of type UUID and assigned the value of a UUID Initialized
		* `id: UUID = UUID()`
		
You may be wondering what a UUID is. A UUID is a universally unique value that can be used to identify types, interfaces, and other items…. Basically, a UUID is a random set of characters. We will use this to differentiate our different  `people` objects.

We will be allowing our users to delete `Person` Objects. Adopt, and conform to the `Equatable` protocol.

---

## Model 2 - Create a `Group` model with..

This Model object should hold
```swift
    let id: UUID
    var name: String
    var people: [Person]
```

The member-wise initializer for this `Model` will be a bit unique… We will have two `properties` that have a default value:
* `id`
	* Default set to a `UUID` initialized
* `people`
	* Default set to an empty array of `Person` objects
	* `people: [Person] = []`

We will be allowing our users to delete `Group` Objects. Adopt, and conform to the `Equatable` protocol.

At this time you should have two `Model` Objects with completed initializers. Take note of how the `Group` model has a property that is a collection of `Person` objects. That's all you have to do link those two objects together! Cool.

---

## Model Controller(s)
Each `Model` will need a file to manage its properties and functions. Many of these methods will be familiar to you. Let’s start with our `Person` Model.

### Person Controller
Create the necessary file to hold your `PersonController` file. Once you have that step done, along with creating the actual `class` define the following method signatures:
* Create
* Delete
* Update

We will need to access these functions outside the `PersonController` file. To imbue the CRUD functions with that ability mark each of them as `static`. 

At this time you should have three `static`  CRUD methods on your `PersonController`. Jump into the `create` function and define three parameters with the following default values:
* name: String = “New Contact”
* address: String = “”
* group: Group

Within the body of this method we need to:
 * Initialize a `Person` object using the parameters. 
 * Append this new `person` object to the `people` array on the `group`
 * Comment here to remind you to save the data when the time comes


```swift
 static func createPerson(name: String = "New Contact",
                      address: String = "",
                      group: Group) {
    ....
		//TODO: - Save to persistent store
   }
``` 

Now write the necessary code to complete the `update` and `delete` functions. Think about what information you would need to accomplish the goals for these methods:
* To update the `Person` I need…
* To delete the `person` I need…

Within the body of the `create`, `update` and the `delete` functions write a comment that reminds you to  call your `save` method when you can.
`//TODO: - Save to persistent store`

Nice! Make a commit with your now complete(ish) `PersonController`

---

### Group Controller
Welcome to the `GroupController` file. Lets start by defining method signatures for the functions we will need:

* Create
* Update
* Delete
* saveContactsToDisk
* loadContactsFromDisk

Make a mark for your properties and create the following properties:
* A singleton
* A source of truth

Once you’ve created the method signature for `saveContactsToDisk`  and the singleton, we recommend navigating to the `PersonController` and replacing all your `TODO: - ...` with call to your `saveContactsToDisk`.

Make a mark under the properties titled `Initializers` and write the following code:
```swift
init() {
        loadContactsFromDisk()
    }
```
What this is allowing us to do is `capture` the initialization of the `GroupController`  class. Whenever this file is initialized we will load the data from disk. Cool huh? Take a moment and ask yourself how many times this class will be initialized in the lifespan (open-close ) of the app. 

Jump into the `create` function and define two parameters with the following default values:
* name: String = “Untitled Group”
* people: [Person] = []
Complete this function. 
Be sure to call `saveContactsToDisk`

Now, complete the `delete` and the ` update` functions. We feel it would be a good idea to `save` the data every time something is updated or deleted…

Okay! Well done! At this time you should have your `properties`, `singleton`, and `CRUD` functions completed. The `save` and `load` functions should just be method signatures at this time.

---

#### Save, Load, and the URL it all goes to

Before we start filling out the `save` and `load` functions there is one final property we need. For readability, we recommend creating this under the `loadContactsToDisk`function.

Define a `private` variable with the name `fileURL` that is of the type `URL` optional. This will be a `computed property`, which means the value will be the result of some computation. You define a computed property by opening a scope following the type.
``` swift
private var fileURL: URL? {
// Computed Property
}
```

##### Url

Within the body of the `fileURL` computed property, we need to accomplish a few goals….

First - We need to locate a file where we can save the data for this application. Because the data will be saved onto the phone the file path will be a URL. The best place to save basic data is directly in the `Documents` directory on the phone.

Secondly - we need to assign the proper `Path Comment` so we can locate this file again. 

Finally - when all is said and done we can return a `url` that we can use over and over.

``` swift
private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = documentsDirectory.appendingPathComponent("addressbook.json")
        return url
    }
```

We mark this computed property as private because we don’t want any other class to have access to this property. It's, well, private property haha. 

##### Save
Save, and load, will seem intimidating at the start but as we break into the code and practice, it will become more approachable. The best news is that the format we will use for today's project is the SAME for every project going forward.

Within the body of the `saveContactsToDisk` function, we need to accomplish a few goals. Before you read them - give yourself a chance and a challenge to think about what you may need.

We need:
*  A location to save the data. Luckily we’ve already created this we just need to ensure it's not `nil`
* Next, we need to take all of the content we want to save `Objects`, `Strings`, `Everything`, and encode it into a `data` type the computer can read and store.
* The most common data type to read and write with is called `JSON` - JavaScript Object Notation.
* Once the data is in a savable format we need to `write` the data to the `url`, or file path we created earlier. 

``` swift
func saveContactsToDisk() {
        // 1. Get the address to save the file to
        guard let url = fileURL else { return }
        do {
            // 2. Convert the swift struct or class into raw data
            let data = try JSONEncoder().encode(groups)
            // 3. Save the data to the address from step 1
            try data.write(to: url)
        } catch let error {
            print(error)
        }
    }
```

Nice work! Let’s finish the load function and party.

##### Load
Within the body of the `loadContactFromDisk` function, we need to do the opposite of `save`. Let's outline the goals of a `load` function

* We first need to make sure the `url` the data is supposed to be saved to / loaded from is not `nil`
* With that file not being `nil` we need to pull the contents, or `Data` on that `file`
* Then we need to try and convert, or `Decode` the `Data` that we pulled from the `file` to the proper data types for the app to use and display
* And finally we can set the newly loaded data to our `Source of Truth`
* Party

``` swift
 // 1. Get the address your data is saved at
    guard let url = fileURL else { return }
       do {
          // 2. Load the data from the address
          let data = try Data(contentsOf: url)
           // 3. Decode that data into our Swift model object
            let categories = try JSONDecoder().decode([Group].self, from: data)
            self.groups = categories
        } catch let error {
            print(error)
        }
```

This rounds out your controller! Great work. Study and reflect on the code for the last three functions we wrote. Take a break and commit all your hard work to your remote repo.

---

## Wire Up the Views
All we have left to do is wire up the views with the proper functions. What’s exciting about this is that you’ve had a full week of practicing these steps and they will be relatively the same from now and for the duration of your career.

##### Groups Table View Controller
To give you a build guide we will list out the steps you’ll need to complete for this file to function as intended. As always, let’s start from the top down. Take a moment and write out the necessary `//MARK: - ` to give yourself a roadmap to follow.

* Reload the `tableView`  when the view will appear

* Set your number of rows to how many groups are on the `GroupController`
* Retrieve the `group` object from the `Source of Truth` that has a matching `indexPath.row` as the cell being reused.
	* Don’t forget the cells `identifier`
	* assign the text of the `textLabel` and `detailTextLabel` to the name and amount of `people` respectively.

* Retrieve the `group` object from the `Source of Truth` that has a matching `indexPath.row` as the cell being `deleted`
* delete the `group`

We will be passing a `Group` object from this VC to the `PeopleTableViewController`. Before you complete your `prepare(for segue:)` method we recommend navigating to the `PeopleTableViewController` and creating an optional property to `receive` the data we are about to pass.

For the  `prepare(for segue:)` method we need to:

*  Identifier - We are checking to see if the identifier of our segue matches “whatever segue Identifier you wrote on the interface builder”. If it does then we will run the code inside, if not then we will just pass over it.

* Index - Discovering what row the user has selected
  
* Destination - Verifying the segue's destination leads to the *ViewController* we want. This also allows us to access the properties on that *ViewController*

* Object to send - Using the index we defined earlier we retrieve the *Model Object* that matches the index from our *Source Of Truth* array.

* Object receiving - Sets the value of the optional *Model Object* on the *destination* to the *Model Object* we just retrieved.

The final step of this VC is to complete the `IBAction` for the `Add` button. This action should:
	* Call the `create` function from the `GroupController`
	* Reload the tableView

Build. Run. Commit. Party

---

##### People TableView Controller
 To give you a build guide we will list out the steps you’ll need to complete for this file to function as intended. As always, let’s start from the top down. Take a moment and write out the necessary `//MARK: - ` to give yourself a roadmap to follow.

* Reload the `tableView`  when the view  will appear
* Set the `text` for the `TextField` to the name from the `optional` `Group` property you defined earlier.

A new user experience we are exploring for this app is how the user will not have to tap a save button to update a `Group` with a new `name`. To accomplish this we will utilize the `viewWillDisappear` method. 

Within the body:
* Guard that the optional `Group` property you defined earlier, along with the `text` from the `TextField` is not `nil`
* Call the `update` function from the `shared` instance of your `GroupConroller` and pass in the appropriate values.

* Set your number of rows to how many `people` are in the optional `Group`property you defined earlier.
	* Using `nil coalescing` return the count or `0`

* Retrieve the `person` object from the optional `group` property you defined earlier that has a matching `indexPath.row` as the cell being reused.
	* Don’t forget the cells `identifier`
	* Assign the text of the `textLabel`  to the name of `person` 

* If the editing style is `.delete`
* Guard that the optional `Group`property you defined earlier is not `nil`
* Retrieve the `person` object from the `people` array that has a matching `indexPath.row` as the cell being `deleted`
* delete the `person` from the `group`

We will be passing a `Person` object from this VC to the `PersonDetailViewController`. Before you complete your `prepare(for segue:)` method we recommend navigating to the `PersonDetailViewController` and creating an optional property to `receive` the data we are about to pass.

For the  `prepare(for segue:)` method we need to:

*  Identifier - We are checking to see if the identifier of our segue matches “whatever segue Identifier you wrote on the interface builder”. If it does then we will run the code inside, if not then we will just pass over it.

* Index - Discovering what row the user has selected
  
* Destination - Verifying the segue's destination leads to the *ViewController* we want. This also allows us to access the properties on that *ViewController*

* Object to send - Using the index we defined earlier we retrieve the *Model Object* that matches the index from our *Source Of Truth* array.

* Object receiving - Sets the value of the optional *Model Object* on the *destination* to the *Model Object* we just retrieved.

The final step of this VC is to complete the `IBAction` for the `Add` button. This action should:
	* Guard that the optional `Group`property is not `nil`
	* Call the `create` function from the `PersonController`
	* Reload the tableView

Build. Run. Commit. Dance

---

##### Person Detail View Controller
 To give you a build guide we will list out the steps you’ll need to complete for this file to function as intended. As always, let’s start from the top down. Take a moment and write out the necessary `//MARK: - ` to give yourself a roadmap to follow.

Define a `updateViews` function to display the data Don’t forget to call this in the `viewWillAppear` lifecycle method.

The `updateViews` function needs to:
* Guard that the optional `Person`property you defined earlier is not `nil`
* Set the `text` for the `TextField` to the `name` from the `optional` `Person` property you just unwrapped
* Set the `text` for the `TextField` to the `address` from the `optional` `Person` property you just unwrapped

The final step of this VC is to complete the `IBAction` for the `save` button. This action should:
	* Unwrap the `person`, the `text` from the `nameTextField`, and the `text` from the `addressTextField`. 
	* If any of those are `nil` we need to exit the scope.
	* Call the `update` function from an instance of the `PersonController` and pass in the proper values.
	* Using the `NavigationController` pop to the previous screen.

Everything should be working properly now. Be sure to test and solve any bugs that may be present.

Build. Run. Commit. Take a well-deserved break.

---

# Stretch goals
* Replace the default cells with custom cells
* Update the design of this app to allow the user to add more detailed information about the `contacts` they are saving.
* Write comments for every line of code within your project explaining what It does

