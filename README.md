# SwiftInteractiveLectureTemplate

## Step 1- Create a person model with
```swift
    let id: UUID
    var name: String
    var address: String
```

Have its initializer take in a default parameter for the `id` that is equal to `UUID()`
    You may be wondering what a UUID is. A UUID  

## Step 2 - Create a Group model with
```swift
    let id: UUID
    var name: String
    var people: [Person]
```
Once again have the initializer take in a default parameter for id that is equal to `UUID()`

## Step 3 -  Create a Group controller with
* a shared instance
* a place to hold a list of groups
* a create, update, and delete  function for Group
    * These methods will have similar parameters and bodies to previous CRUD functions

## Step 4 - Create your storyboard
* Create a storyboard with a Nav Controller , 2 tableviews, and a view controller
* connect a segue from the cell of the first TBVC to the second TBVC and a segue from the cell of the second TBVC to the detail view
* On the first tableview controller add an add button to the top right corner

This next part can be a little complicated so be sure to follow along carefully
* Drag a `UIView` into the `tableviewHeader` on the second tableViewController
* Drag a `VerticalStackView` into that `UIView`
* Drag a `UiTextField` into that `VerticalStackView`
* Constrain the stackview to be 8 from the top, 16 from the left, 16 from the right, and 8 from the bottom

