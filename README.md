# Tales of Brave: Motivational App
## Introduction
Tales of Brave is an application that presents inspiring tales from well-known public people, primarily for college students. Discover the strength of positivism, tenacity, and resilience from the finest. Our carefully chosen stories are intended to encourage your spirit, stoke your aspirations, and awaken bravery within.

<img src="https://github.com/PengabdiCodinganX/MC3/blob/main/shot.png" width="auto" height="auto" >


## Demo
- [Video Demo](https://firebasestorage.googleapis.com/v0/b/muhammad-adha-fajri-portfolio.appspot.com/o/projects%2FTalesOfBrave.mp4?alt=media&token=2ef52e8f-3ebc-43ba-9222-9ae83813f1a8)
- [Testflight](https://testflight.apple.com/join/i14NYOE1)

## Feature
- Motivational Quote
- Motivational Stories
- Breathing Technique
- Reflection
- Self Affirmation

## Tech
- SwiftUI
- CloudKit
- AVAudio
- Speech
- NLP
- Apple Authentication
- ChatGPT Integration
- ElevenLabs Integration

## Creator
- [Muhammad Adha Fajri Jonison](https://github.com/adhafajri)
- [Muhammad Afif Maruf](https://github.com/marufboy)
- [Muhammad Rezky Sulihin](https://github.com/mrezkys)
- [Vincent Gunawan](https://github.com/maskedEnigma)
- [Monica Fiernaya](https://github.com/monicanaya)

## Installation
<details><summary>Installation guide</summary>
  
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

### Configuring CloudKit
Initiate a cloud kit container and establish these Record Types with specific fields:

API_Key: apiKey, name
History: problem, rating, reflection, story, user
Rating: rating, story, user
Sound: id, sound, text
Story: IntroductionSound, introduction, introductionSound, keywords, problem, problemSound, ratings, resolution, resolutionSound, storyRating
User: dev, email, name, userIdentifier
Finally, include your Chat GPT and Elevenlabs API keys, labelling them chatGPT and elevenLabs respectively under API_Key.

</details>
