# Reading List – Advanced

This version of the Reading List app moves data source responsibilities out of the `RELReadingListController` class, and into `RELDataSource`, a custom subclass of `NSObject`. This approach simplifies the controller implementation, and makes the data source potentially reusable.

## Pros

* The data source implementation can be directly reused, and can be subclassed to accommodate different data stores, and other variations.

* Table view controllers no longer need to implement the `UITableViewDataSource` protocol, which is now implemented by `RELDataSource`. This leads to smaller, more cohesive, and less cumbersome table view controller implementations.

* Instances of `RELDataSource` can be created and their outlets connected in nib files and storyboards.

## Cons

* Configuring the data source is now more abstract; it may not be initially obvious how to set up data sources in Interface Builder.

* It may take longer to understand the example because of the greater level of abstraction.


## Configuring the Data Source in IB

The data source is already configured in the storyboard for the project, but here's how to do it if you're recreating the storyboard from scratch:

1. Drag the **Object** icon from IB's **Object Library** into the Reading List scene, either in the sidebar, or directly in the dock. 

  ![Data source icon in IB](/ReadingList-Advanced/DataSourceInIB.png)

2. Set the object's class to `RELDataSource` in the **Identity Inspector**.

3. Disconnect the table view's `dataSource` outlet from the table view controller, and connect it to the data source. Also connect the table view controller's `dataSource` to the data source.

4. Connect the data source's `tableView` outlet to the table view.



## A Note About Resizing Behavior

Because the project doesn't make use of autolayout and size classes, some components of the user interface may not gracefully handle varying device resolutions, particularly the iPhone 6 and 6 Plus.

Also, because of an apparent bug in the current iPhone Simulator, I had to configure autoresizing behavior for text fields less than optimally (they don't take full advantage of the increased table view width in landscape mode).