# MC3

## Tutorial

### Step 1: Install Homebrew

Homebrew is a package manager for macOS that lets you install free and open-source software.

Open Terminal and run the following command:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Step 2: Install Xcodegen
Xcodegen is a command line tool written in Swift that generates your Xcode project using your folder structure and a project spec.

To install Xcodegen using Homebrew, run the following command in Terminal:

```
brew install xcodegen
```

### Step 3: Generate Project
Now, navigate to your project directory in Terminal and run the following command:

```
xcodegen generate
```