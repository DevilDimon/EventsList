## General notes
* The provided Zeplin mockups were not clickable, so I could not inspect the actual element sizes, offsets, text styles and colours. I managed to extract everything I could from Styleguide (i.e. colours and some text styles), but the sizes & offsets found in the final app are approximate and could be a bit off. Anyway, this is much quicker to fix when needed than the app's logic.
* I added a slight dark gradient on every image view as the texts in the mockups were not clearly visible on brighter images such as the ones actually returned by the API.

## Approach explanation
* I spent around 5-6 hours on the task in total.
* I chose MVVM as the architecture I am most familiar (and currently, productive) with. This architecture also provides a good tradeoff between code complexity and testability/difficulty of support. 
* I used simple closure callbacks for bindings since they don't require a radical paradigm shift or massive external dependencies (unlike Combine/RxSwift) and they don't pollute the global namespace with throwaway delegate protocols.
* I built all the layouts in code as it eases code review & is more sustainable in the long run (i.e. no suddent XIB changes in git, no need to open IB to edit).
* External dependencies include:
	* SnapKit as a lightweight DSL for AutoLayout used in most projects
	* Kingfisher to offload the frequent task of image loading and caching to a tried & tested solution

## Current limitations & proposed solutions
* Tabs (both view and logic) were not implemented due to them not being utilised in the task description.
* There is no fine-grained manual loading control after initial load (e.g. pull-to-refresh). This could be fixed with extra time on the project.
* No animations are present.
* Image caching & downsampling does not take the real cell size into account. This also could be fixed with more time by passing the actual size into the view models.
* A separate navigation service/router/coordinator is not present as the app only has a single screen.
* There are no tests as I could not write them in time, but all the view models are easily testable: they depend on protocols with mockable implementations, their inputs coming from views are exposed as internal methods, their outputs – as internal variables, all of which could be checked in a unit test when needed.