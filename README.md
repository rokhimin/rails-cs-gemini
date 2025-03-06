# Rails Customer Support with Gemini AI

This project integrates Google's Gemini AI into a Ruby on Rails application to serve as a customer support agent, providing automated responses to customer questions.
I created a fictional coffee sales website in this project and integrated Gemini AI.

The way it works is very simple, just relying on prompts. Gemini AI is fed extensive information about this coffee sales business and instructed to act as customer support through prompts.

## View
![](https://i.imgur.com/yvMCgzw.png)

## Features

- **AI-Powered Responses:** Utilizes Gemini AI to generate human-like answers to customer questions.
- **Interactive Chat Interface:** Allows users to interact with the AI through a chat-based interface.
- **Seamless Integration:** Demonstrates how to incorporate Gemini AI into a Rails application effectively.

## Configuration

- **Gemini AI Integration:**
  - The integration with Gemini AI is handled in the `ChatController`.
  - Ensure that the API endpoint and authentication details are correctly set up in the controller.

##### Example prompt
this example i use bahasa indonesia
```
{{this information of Brew Blessed business}}
kamu berperan sebagai customer support dari Brew Blessed, kamu harus menjawab pertanyaan customer dengan baik dan benar.
jika pelanggan bertanya "#{user_message}" tolong jawab!
```

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Google's Gemini AI](https://cloud.google.com/vertex-ai) for providing the AI capabilities.
- [Ruby on Rails](https://rubyonrails.org/) for the web application framework.