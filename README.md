# .airules

This project provides a curated collection of global rules for AI coding assistants like Claude and Gemini. The goal is to offer a centralized, community-driven set of instructions that can be easily imported into your global configuration files to improve an agent's behavior, safety, and efficiency across all your projects.

## Philosophy

-   **Agent Agnostic:** The rules are intended to be useful for any AI coding assistant that supports importing external instructions.
-   **Global Scope:** The rules focus on general development workflows and best practices that are applicable across most software projects.
-   **Simplicity:** The project aims for a simple, flat structure. Rules are just Markdown files, easily browsable and understandable.

## Project Structure

```
.
├── install.sh          # The main installation script.
├── README.md           # This file.
├── rules/              # Contains all the individual rule files.
│   ├── branching-strategy.md
│   ├── commit-messages.md
│   ├── git.md
│   ├── github.md
│   └── pull-requests.md
└── tests/              # Houses the testing infrastructure.
    ├── Dockerfile          # Defines the isolated test environment.
    ├── local-tests.sh      # A helper script to run tests locally via Docker.
    └── tests.sh            # The core test script with all test scenarios.
```

## The Rules

The following rule sets are currently included:

-   **[Branching Strategy](rules/branching-strategy.md):** Defines a strict `issue/<number>` convention for branch names.
-   **[Commit Messages](rules/commit-messages.md):** Enforces the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification.
-   **[Git Interaction](rules/git.md):** Provides rules for the `git` CLI, including workflow, remote naming, and shortcuts.
-   **[GitHub Interaction](rules/github.md):** Defines a comprehensive, issue-driven workflow for interacting with GitHub.
-   **[Pull Requests](rules/pull-requests.md):** Outlines best practices for creating and reviewing pull requests.

## Installation

To install the rules, run the `install.sh` script from the project root:

```bash
bash install.sh
```

The script will automatically detect if you have `~/.claude` or `~/.gemini` directories and configure them accordingly.

-   **For Claude:** It will add a line to your `~/.claude/CLAUDE.md` to import the entire `rules` directory.
-   **For Gemini:** It will create a symlink (`~/.gemini/airules`) to this project's root and add individual import statements for each rule to your `~/.gemini/GEMINI.md`.

The script is safe to run multiple times. It will not create duplicate entries.

## Testing

This project includes a robust test suite to ensure the `install.sh` script works as expected.

### Running Tests Locally

To run the tests on your local machine, you need to have **Docker** installed. Then, you can run the local test script:

```bash
bash tests/local-tests.sh
```

This script will build a clean Docker image, copy the project into it, and run the `tests/tests.sh` script in an isolated environment.

### Continuous Integration

The project is configured with a GitHub Actions workflow (`.github/workflows/ci.yml`) that automatically runs the test suite on every push and pull request to the `main` branch. This ensures that all changes are verified before being integrated.

## Rule Authoring Conventions

To ensure consistency and proper parsing by the AI agents, please follow these conventions when authoring new rules:

-   **Heading Levels:** All rule files must start their headings at the H2 level (`##`). Deeper nesting should use H3 (`###`), H4 (`####`), and so on. This is to ensure that when the rules are imported, they do not create a top-level H1 heading, which could disrupt the document's structure.