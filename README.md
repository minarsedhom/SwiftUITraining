# SwiftUITraining

**Views&Modifiers:**
- Conditional modifiers
- Environment modifiers
- Views as properties
- View composition
- Custom modifiers
- Custom containers
- Navigation View
<img width="297" alt="image" src="https://github.com/minarsedhom/SwiftUITraining/assets/134082704/f3261cb6-feb6-4b5e-a020-92777ad177bf">


**VHZstacks:**

<img width="343" alt="image" src="https://github.com/minarsedhom/SwiftUITraining/assets/134082704/99585eca-1509-4159-8f17-51db50a16c2c">

**StateObjectVSObservedObject**
- covers the difference between StateObject and ObservedObject and how to use both.

**WorkingWithLists**
- create static and dynamic rows
- Using Foreach
- Delete items from list
- Add new item to dynamic list (append to @state list)
- Entring Edit mode (we can add an Edit/Done button to the navigation bar)

https://github.com/minarsedhom/SwiftUITraining/assets/134082704/befa7923-f8c7-4a8d-b2ad-47a97cd1c4d8

**EnvironmentObjectExample**
It Covers:
- @State and @Binding for sharing data between value types (Views - Structs)
- @ObservedObject or @EnvironmentObject, both of which are designed for reference types to be shared across potentially many views.

**AsyncAwaitSwiftUI**
It Covers:
- URLsession "async" function
- Using async/await to handle network request
- Using AsyncImage(url:


**ViewInspectorForTestingSwiftUIViews2**
- Install ViewInspector as a Swift Package.
- Use ViewInspector to write your first UI tests.
- Learn to write asynchronous UI tests.
- Test a custom ButtonStyle.
- Learn to control the search direction when finding UI elements.


**SwiftUnitTesting**
- Use Xcode’s Test navigator to test an app’s model and asynchronous methods
- Fake interactions with library or system objects by using stubs and mocks
- Test UI and performance

**- *Notes:* -**
The acronym FIRST describes a concise set of criteria for effective unit tests. Those criteria are:
Fast: Tests should run quickly.
Independent/Isolated: Tests shouldn’t share state with each other.
Repeatable: You should obtain the same results every time you run a test. External data providers or concurrency issues could cause intermittent failures.
Self-validating: Tests should be fully automated. The output should be either “pass” or “fail”, rather than relying on a programmer’s interpretation of a log file.
Timely: Ideally, you should write your tests before writing the production code they test. This is known as test-driven development.
