Create a multi-platform app to show the real-time BTC/USD price.

Instructions

Follow the development processes and practices taught in the program (e.g., follow TDD, small commits, modular design, set up a CI/CD pipeline, etc.).

Create two separate apps - a CLI app and an iOS app - reusing code as much as possible with a clean and modular design.

The apps should display the BTC/USD exchange price every second with the latest value. The iOS app should display the latest value on the screen, and the CLI app should display the latest value on the console.
Use https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT as the primary data source and https://min-api.cryptocompare.com/data/generateAvg?fsym=BTC&tsym=USD&e=coinbase as a fallback.
If any of the links are not working, use any other BTC/USD conversion API you can find online.
Handle errors - if the network request fails or if it fails to update within a second, show an error saying it failed to load the data and show the last updated value and date (e.g., "Failed to update value. Displaying last updated value from Jan 24th, 21:07"). Hide the error once the value is updated successfully.

If you're unsure about a specific requirement, use your judgment and make a decision on your own (you should be able to justify the decision!).

Guidelines

Aim to commit your changes every time you add/alter the behavior of your system or refactor your code.
Aim for descriptive commit messages that clarify the intent of your contribution, which will help other developers understand your train of thought and purpose of changes.
The system should always be in a green state, meaning that in each commit all tests should be passing.
The project should build without warnings.
The code should be carefully organized and easy to read (e.g. indentation must be consistent).
Aim to write self-documenting code by providing context and detail when naming your components, avoiding explanations in comments.

Bitcoin Loader Use Case
Data:
- URL

Primary course (happy path):
1. Execute "Bitcoin loader" command with above data.
2. System downloads data from the URL.
3. System validates downloaded data.
4. System creates bitcoin data item from valid data.
5. System delivers bitcoin data.

Invalid data - error course (sad path):
1. System delivers error.

No connectivity - error course (sad path):
1. System delivers error.

