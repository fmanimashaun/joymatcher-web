# Troubleshooting Joymatcher

This guide provides solutions to common issues you may encounter while setting up or developing the Joymatcher project.

## Common Issues

**1. `Gem::Ext::BuildError: ERROR: Failed to build gem native extension.`**

This error often occurs when certain gems require compiling native extensions, and your system is missing necessary dependencies (like build tools or libraries).

*   **Solution:** 
    * Ensure you have a compiler and related tools installed. On macOS, you might need Xcode Command Line Tools. On Ubuntu/Debian, install `build-essential`. For other systems, consult your OS documentation.
    * If you're using a Devcontainer, ensure the necessary dependencies are installed within the container.
    * Check the gem's documentation for specific dependency requirements.

**2. `Could not find a JavaScript runtime.`**

This error indicates that a JavaScript runtime like Node.js is not available in your development environment.

*   **Solution:** 
    * Ensure that Node.js and npm (or yarn) are installed on your system. You can check by running `node -v` and `npm -v` (or `yarn -v`) in your terminal. 
    * If you're using a Devcontainer, Node.js should already be included, but double-check your `devcontainer.json` configuration.

**3. `Error connecting to database.`**

This error occurs when the application cannot connect to the database.

*   **Solution:**
    *   Verify that the database server (PostgreSQL in this case) is running.
    *   Check the database credentials in your `config/database.yml` file to ensure they are correct.
    *   Make sure the necessary database adapter gem is installed (`pg` for PostgreSQL).
    *   If you're using a Devcontainer, ensure the database service is properly defined and running in your `devcontainer.json`.

**4. `Rails::Generators::Error: Could not find generator '...'`**

This error means Rails cannot find the specified generator.

*   **Solution:**
    * Ensure the gem that provides the generator is in your `Gemfile` and that you've run `bundle install`.
    * If the generator is from a plugin or engine, make sure it's properly installed and loaded.

**5. `ActionView::Template::Error (The asset '...' is not present in the asset pipeline.)`**

This error occurs when an asset (JavaScript, CSS, image) referenced in a view cannot be found.

*   **Solution:**
    *   Verify that the asset exists in the appropriate `app/assets` directory (e.g., `app/assets/javascripts`, `app/assets/stylesheets`, `app/assets/images`).
    *   Make sure the asset is properly linked or imported in your manifest files (e.g., `application.js`, `application.css`).
    *   Check for typos in the asset path or filename.
    *   If you're precompiling assets, run `rails assets:precompile` to ensure they are available.

**6. Problems with Tailwind CSS**

*   **Solution:**
    * Ensure Tailwind CSS is properly installed and configured. Refer to the [Tailwind CSS documentation](https://tailwindcss.com/docs/installation) for guidance.
    * Check your Tailwind configuration files (`tailwind.config.js`, `postcss.config.js`) for any errors.
    * Make sure your CSS is being processed correctly by your build pipeline.

## Still Having Trouble?

If you encounter an issue not listed here or are unable to resolve your problem, please don't hesitate to ask for help in our [Discussions forum](https://github.com/fmanimashaun/joymatcher-web/discussions).
