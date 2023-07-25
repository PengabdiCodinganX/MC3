# MC3

## Setup

This project uses Xcodegen and has a Git hook set up to run it each time you switch branches. To set up the environment, you need to run a setup script named `setup.sh`.

### Running the setup script

1. Open Terminal.

2. Navigate to the project's root directory:

   ```bash
   cd /path/to/project/MC3
   ```

   Replace `/path/to/project/MC3` with the actual path to your cloned MC3 repository.

3. Make the `setup.sh` script executable:

   ```bash
   chmod +x setup.sh
   ```

4. Run the `setup.sh` script:

   ```bash
   ./setup.sh
   ```

The `setup.sh` script does the following:

- Checks if Homebrew is installed and installs it if not.
- Checks if Xcodegen is installed and installs it if not.
- Generates an Xcode project.
- Sets up Git hooks.
- Makes the `post-checkout` hook script executable.
- Copies the `post-checkout` hook script to `.git/hooks`.
- Runs XcodeGen with cache.

Now, each time you switch branches with `git checkout`, Git will automatically run the `post-checkout` script and execute XcodeGen to generate your Xcode project.

### Special note for SourceTree users

If you are using SourceTree, it is necessary to open the app via the Terminal for the Git hook to work properly. You can do so with this command:

```bash
open /Applications/SourceTree.app/Contents/MacOS/SourceTree
```

This ensures that SourceTree has access to the necessary command-line tools.

### Special Note for Developers

When you switch between branches in this project, please remember to manually enable the "Sign in with Apple" and "iCloud" capabilities in Xcode. 

The settings for these capabilities are not tracked by Git and therefore need to be re-enabled every time a branch is switched. 

Here are the steps to enable these capabilities:

1. Open the project in Xcode.
2. Select the main target of your app.
3. Navigate to the "Signing & Capabilities" tab.
4. If the "Sign in with Apple" and "iCloud" capabilities are not listed, click on "+ Capability" to add them.
5. Find and click on "Sign in with Apple" and "iCloud" in the list.

Failure to perform these steps might result in unexpected behavior or errors during runtime, especially when using related features in your app.

Your understanding and cooperation are highly appreciated. Thank you!
