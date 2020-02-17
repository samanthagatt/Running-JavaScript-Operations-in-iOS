# Running JavaScript Operations in iOS

## Process
- Thought about how I wanted to set up the user interface
  - Allow user to pick how many operations to start
  - Provide a restart button
  - Use `UIProgressView`s because it has built in functionality that matched the requirements for the challenge
    - If I spent more time on it, I'd create a custom view (maybe a circle progress track)
- Looked over the pseudo-type representation of a message provided in the challenge instructions
- Turned it into a `Decodable` Swift `struct`
- Configured data task to fetch JavaScript code as a string
- Researched how to execute JavaScript code in the context of a web view
  - https://developer.apple.com/documentation/webkit/wkwebview/1415017-evaluatejavascript
- Researched what `window.webkit.messageHandlers` is and how it's used
  - https://spin.atomicobject.com/2016/09/01/sharing-web-data-wkwebview/
- Set up main UI in interface builder
- Uses web view's `evaluateJavaScript` function to add the provided JavaScript functions that were fetched
- Thought about how to organize the progress views
  - Initially thought of using a table view but realized I would need references to each progress view to update them abd the table view cells get reused
  - Thought of adding and removing new progress views whenever user incremented the number of operations
    - The reason table views reuse their cells is so they don't have to keep creating new views
    - Decided on having a set number of progress views (10) and create an IBOutlet collection that contained them all so I can hide the ones that are not being used (instead of deleting them and then having to create more each time the user adds another one)
- Implemented the rest of the UI and the stepper functionality
- Made sure progress views would update each time `window.webkit.messageHandlers.jumbo` is called
- Made unit tests for the `JumboOperationController` since it handles all the logic for the model before it interacts with the UI
