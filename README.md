 Currency Converter - ASP.NET4.8 - Eng Maged Ali

![1](https://github.com/user-attachments/assets/6506d121-20e7-4b5c-9333-e01876c761b7)

![2](https://github.com/user-attachments/assets/87279bd9-c3bb-44de-9981-f2848892de09)


![3](https://github.com/user-attachments/assets/5f7575e9-7aab-4762-a9a2-b2c3edf24071)


This project is a Currency Converter built using ASP.NET 4.8 and C#. It allows users to select currencies and retrieve the latest exchange rates for those currencies, using an API to get real-time data. Let’s break down the project step by step:

1. ASP.NET Web Form Page (WebForm1.aspx)

The WebForm1.aspx file is the frontend, responsible for rendering the user interface (UI) that the users will interact with. It includes:

- HTML Structure: Uses Bootstrap for layout and styling, with a title and a section to select currencies.
- Currency Selection: A button to toggle a currency selection panel. When clicked, it shows or hides the list of currencies.
- Exchange Rates Section: Displays the selected exchange rates after the user submits the form.
- Down Arrow & Up Arrow: These allow the user to smoothly scroll down or up the page, triggered when they click the arrows.
- JavaScript: Includes jQuery to manage button click events (like toggling the visibility of the currency list) and to manage smooth scrolling behavior for the arrows.
  
Key Features in WebForm1.aspx:
1. Toggle Button: Shows and hides the currency selection section (`#currencySection`) using jQuery.
2. Up and Down Arrows: Smooth scrolling functionality with jQuery to move up and down the page.
3. Currency List (Dynamic): A placeholder (`#pnlCurrencies`) where dynamic checkboxes for currencies will be loaded by the code-behind (from the server).

---

2. Code-Behind (WebForm1.aspx.cs)

This file is written in C# and handles the business logic of the application. It processes requests, fetches data, and communicates with the API. Below are the main components of the code-behind:

Key Components:

1. API Integration:
   - ApiUrl: A URL for fetching the list of available currencies (`https://openexchangerates.org/api/currencies.json`).
   - LatestRatesUrl: A URL for fetching the latest exchange rates for those currencies (`https://openexchangerates.org/api/latest.json`). The app key in the URL authenticates requests to the Open Exchange Rates API.
   
   This API returns data in JSON format, which is deserialized and used within the app.

2. Page_Load Event:
   - LoadCurrencies() is called on page load. This method fetches the currency list from the API, creates dynamic checkboxes, and adds them to the `pnlCurrencies` panel.
   - On every postback, the currencies are loaded, but other initializations are done only once, i.e., on first load (`!IsPostBack`).

3. LoadCurrencies Method:
   - This method makes an asynchronous API call to the Open Exchange Rates API, retrieves the list of currencies, and dynamically creates checkboxes for each currency.
   - It ensures that EGP (Egyptian Pound) is the first currency on the list by adding a checkbox for it manually and then removing it from the dictionary to avoid duplication.
   - The checkboxes are laid out in a flexbox container, allowing for a responsive layout that fits well on various screen sizes.

4. btnConvert_Click Event:
   - This method handles the button click when the user wants to fetch exchange rates.
   - It checks which currencies have been selected by the user, then calls the `GetApiResponseAsync` method to fetch the latest exchange rates.
   - The API response is then processed by the `GetExchangeRatesForSelectedCurrencies` method to display the relevant exchange rates.

5. GetApiResponseAsync Method:
   - This asynchronous method sends an HTTP GET request to the given API URL and retrieves the response.
   - If the request succeeds, it returns the response data (JSON). If there’s an error, it catches the exception and returns an error message.

6. GetExchangeRatesForSelectedCurrencies Method:
   - This method processes the JSON response from the API and extracts exchange rates for the selected currencies.
   - It checks if the selected currencies are present in the response and formats the result into a readable string (`1 USD = X Currency`).
   - If no valid currencies are found, an error message is returned.

---

3. Client-Side Functionality (JavaScript)

- jQuery is used for:
  - Scroll Events: Showing and hiding the up and down arrows when the user scrolls the page.
  - Smooth Scroll: The up and down arrows allow smooth scrolling to the top or bottom of the page when clicked.
  - Toggle Button: Used to show or hide the currency selection section when the user clicks on the "Show Select Currency" button. The button text also changes dynamically based on the visibility state of the currency section.

---

4. Bootstrap and Font Awesome

- Bootstrap 4.5: Used for layout, styling, and responsiveness. The form is structured using Bootstrap’s grid system (`container`, `row`, `col-md-12`), and buttons are styled with Bootstrap classes (`btn`, `btn-primary`, `btn-block`).
- Font Awesome: Icons are used for the up and down arrows.

---

5. How it Works Step-by-Step:

1. Page Loads:
   - The `Page_Load` method is triggered.
   - It calls `LoadCurrencies`, which makes an API call to get the list of currencies.
   - The list is displayed dynamically as checkboxes.

2. User Interaction:
   - The user selects one or more currencies from the dynamically generated list and clicks the "Get Exchange Rates" button.
   - The `btnConvert_Click` event is triggered, which gathers the selected currencies and makes an API call to get the latest exchange rates.
   - The rates for the selected currencies are displayed in the `litExchangeRates` placeholder.

3. Scrolling:
   - If the user scrolls down the page, the up and down arrows appear, providing quick navigation to the top or bottom.

---

6. Error Handling:
- API Response Handling: The API calls are wrapped in `try-catch` blocks to handle any errors (e.g., network issues or invalid responses).
- User Feedback: If no currencies are selected, the user is prompted to select at least one currency.

---

7. Summary of Technologies Used:

- ASP.NET 4.8: For creating the web form and handling server-side logic.
- C#: For writing the business logic, including API calls and event handling.
- Open Exchange Rates API: To fetch currency lists and real-time exchange rates.
- Bootstrap: For responsive design and layout.
- Font Awesome: For icons (up/down arrows).
- jQuery: For client-side interactivity (toggling sections and smooth scrolling).

This project combines modern web development techniques with classic ASP.NET Web Forms to create a dynamic, user-friendly currency converter.

In the Code-Behind (WebForm1.aspx.cs) file, the URL for fetching the latest exchange rates from the Open Exchange Rates API is defined as:

 
private const string LatestRatesUrl = "https://openexchangerates.org/api/latest.json?app_id=Your_App_ID&base=USD";
 

Important Note: App ID Requirement

In order for the API to work correctly, the user must:

1. Sign up at [Open Exchange Rates](https://openexchangerates.org/signup) to get an App ID (API key).
2. Replace the placeholder `"Your_App_ID"` in the `LatestRatesUrl` string with the actual App ID.

For example, if your App ID is `abcd1234`, you would change the URL to:

 
private const string LatestRatesUrl = "https://openexchangerates.org/api/latest.json?app_id=abcd1234&base=USD";
 

Without a valid App ID, the API requests will fail, and the application won’t be able to retrieve live exchange rates. This ensures that the API usage is properly authenticated and tracked.
