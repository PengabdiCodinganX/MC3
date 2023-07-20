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