# Cat Facts App 🐱

An iOS application that displays random cat facts and adorable cat images. Built with **SwiftUI** and the **MVVM** architecture, it fetches data from the [MeowFacts API](https://meowfacts.herokuapp.com/) and [The Cat API](https://thecatapi.com/).

---

## Features

- 📚 **Random Cat Facts**: Learn fun facts about cats.
- 🖼️ **Adorable Cat Images**: Display random cat images sourced from The Cat API.
- ⚡ **Asynchronous Fetching**: Fetches data concurrently for a seamless user experience.
- 📱 **SwiftUI-Based**: Modern UI built using SwiftUI.
- 🏢 **MVVM Architecture**: Clean separation of concerns using MVVM.

---

## Project Structure

- **Model**: Defines the `CatFact` and `CatImage` data structures.
- **Network Manager**: Handles API requests using `URLSession`.
- **ViewModel**: Manages data fetching and state for the app.
- **View**: Displays the user interface using `SwiftUI`.

---

## How It Works

1. **Fetch Data**: On app launch, the `fetchCatData` method is called in the `CatViewModel` to fetch:
   - A random cat fact from MeowFacts API.
   - A random cat image from The Cat API.
2. **Update UI**: The `ContentView` updates to display the retrieved cat fact and image.
3. **Error Handling**: If an error occurs during fetching, the app shows a user-friendly error message.

---

## API References

- [MeowFacts API](https://meowfacts.herokuapp.com/)
- [The Cat API](https://thecatapi.com/)

---

## Testing

The project includes unit tests for the `CatViewModel` to verify:

- Successful data fetching.
- Error handling for API failures.

THE UNIT TESTING IS STILL UNDER DEVELOPMENT
