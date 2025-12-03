# Creating a Global Git Auto-Documentation Command

## Overview

This guide shows how to generate documentation for any git repository.

## Configuration

Create a `.readmeIgnore` file to exclude paths:

```
node_modules
.git
dist
build
```

## Requirements

- Git
- Bash
- node
- pnpm
- Internet connection (first run only)

## Installation Instructions (for users)

**One-line installation:**

```bash
curl -fsSL https://raw.githubusercontent.com/nayan458/auto-doc/main/install.sh | bash
```

**Manual installation:**

```bash
# Clone repository
git clone https://github.com/nayan458/auto-doc.git ~/.auto-doc

# Add to PATH
echo 'export PATH="$HOME/.auto-doc:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Make executable
chmod +x ~/.auto-doc/auto-doc
```

## Usage


```bash
# Navigate to any git repository
cd /path/to/any/repo

# Run the command
auto-doc
```

## Example README.md for Your Repository


# auto-doc

Automatically generate comprehensive documentation for any Git repository.

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/nayan458/auto-doc/main/install.sh | bash
```

## Usage

```bash
cd your-project
auto-doc
```

This will:
1. Create a `project/doc` branch
2. Collect all README files from your project
3. Generate a navigation structure (`nav.json`)
4. Set up a documentation viewer frontend
5. Commit everything to the branch

## Features

- 🔍 Automatically finds all README files
- 📁 Preserves directory structure
- 🎨 Includes beautiful documentation viewer
- 🚫 Respects `.readmeIgnore` file
- 🌿 Creates isolated documentation branch

## Configuration

Create a `.readmeIgnore` file to exclude paths:

```
node_modules
.git
dist
build
```

## Requirements

- Git
- Bash
- Internet connection (first run only)

## License

MIT
````
