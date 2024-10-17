# Fetch Mobile Take Home Project

### Summary

I had a lot of fun with this project. SwiftUI is still new and evolving and there are always new things I am excited to try with it. In this case, I went out of my way to use `symbolEffect` with the multi-layer SF Symbols. It didn't quite perfect the animations with it, but I'm pretty happy with it. 

I didn't have long blocks of time today to work on this project, so I worked on it in many smaller increments over the course of the day. It's never ideal, but it gave me a chance to take breaks from my code and get fresh eyes when I came back.

Because the direction specified that the app should consist of only one screen, I made the decision to open the links externally. It can be a bit jarring and a better UI would probably be helpful, but it functions.

### Steps to Run the App

The app should run without incident from Xcode by pressing run. There are no CocoaPods or other commands to run from the CLI.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I made a point that as much of this code is testable as possible. Besides the inherent value of the tests themselves, it gave me a chance to play with the new Swift Testing framework. It's a great improvement over the old XCTest framework and I would prefer to never go back, given the choice. I will even confess that writing the unit tests helped me to catch a few bugs in the ViewModel code that I might have otherwise missed.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

As mentioned in the summary, I worked on this in many small blocks spread over the day. I probably spent about 1 hour on roughing out the UI, but then another hour on the details. I could easily have spent several more hours adding animations and tweaking transitions, but that doesn't seem purposeful in this case. 

The data models and data fetching went pretty quick. I probably spent under an hour writing the code and then about an hour writing test cases to validate my code. Once those were done, the ViewModel was almost trivial. 

In total, I'm probably at about 4 hours as I started writing this README.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I had considered adding multiple List Cell layouts with a Segmented Control to switch between them. Ultimately, I decided that a single Segmented Control was enough and adding another would make the UI seem cluttered. 

The biggest trade-off I made was to add multiple layers into the JSON fetching/parsing process. It would have been much simpler to fetch the data in the ViewModel using URLSession with a hard-coded URL, but it wouldn't have been testable without hitting that URL Endpoint. The dependency injection and additional layers allow unit tests to work without any network activity. 

### Weakest Part of the Project: What do you think is the weakest part of your project?

The designs for the Loading, Error, and Empty states are pretty horrible. They exist and they prove a methodology for doing such a state, but they appear for such a small amount of time that I didn't want to spend more time than necessary on them.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

When I started building my `UrlLoader` protocol, I had intended to use it as a component for the image loading and caching pipeline. When I finished the JSON loading functionality, I decided that it probably wasn't worth re-inventing the wheel when there are other frameworks out there for exactly this purpose. As a result, I decided to include Nuke and NukeUI. The interface was clean and it took very little effort to include. Since it used SwiftPM, it doesn't add any manual steps in order to build the project. 

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

Most of the time I get to sit down with a Project Manager and Designer to work out the precise functionality and design before I write the first line of code. Obviously, that wasn't the case here. The design was improvised and probably could use some improvements. At least the design doesn't get in the way of the functionality.