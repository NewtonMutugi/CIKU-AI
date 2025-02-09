# CIKU-AI  

**C.I.K.U - Cognitive Interface for Knowledge and Understanding**  

CIKU-AI is a Phoenix-based application designed to provide a conversational chatbot interface, enabling users to discuss their problems in a supportive and interactive environment. 😊  

---

## Prerequisites  

Before getting started, ensure you have the following installed on your system:  

- **Elixir** (version 1.14 or later)  
- **Phoenix** (version 1.7 or later)  
- **PostgreSQL** (version 13 or later)  

---

## Setup  

Follow these steps to set up and run CIKU-AI locally:  

1. **Clone the repository**  
   ```bash
   git clone https://github.com/your-username/ciku-ai.git
   ```

2. **Navigate to the project directory**  
   ```bash
   cd ciku-ai
   ```

3. **Install dependencies**  
   ```bash
   mix setup
   ```

4. **Set up environment variables**  
   Create a `.env` file in the root directory and add the following variables:  
   ```bash
   export DB_USERNAME="your_postgres_username"
   export DB_PASSWORD="your_postgres_password"
   export API_KEY="your_api_key"
   ```  
   Then, load the environment variables:  
   ```bash
   source .env
   ```

5. **Start the Phoenix server**  
   You can start the server in one of two ways:  
   - **Standard mode**:  
     ```bash
     mix phx.server
     ```  
   - **Interactive Elixir mode (IEx)**:  
     ```bash
     iex -S mix phx.server
     ```  

6. **Access the application**  
   Open your browser and visit [http://localhost:4000](http://localhost:4000).  

---

## Deployed Site  

You can also access the live version of CIKU-AI here:  
👉 [https://cikuai.newtonmutugi.me](https://cikuai.newtonmutugi.me)  

---

## Contributing  

We welcome contributions from the community! If you'd like to contribute, please follow these steps:  

1. **Fork the repository** and create your branch from `main`.  
2. **Open an issue** to discuss the changes you'd like to make (especially for major changes).  
3. **Submit a pull request** with a clear description of your changes.  

Please ensure your code adheres to the project's coding standards and includes appropriate tests.  

---

## Support  

For any questions, issues, or feedback, feel free to reach out by opening an issue on the repository or contacting the maintainer.  

Happy coding! 🚀
