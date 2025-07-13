## Git Interaction

This section provides rules for interacting with the `git` command-line interface and maintaining a clean, understandable version history.

### The Main Branch

-   **Single Source of Truth:** The `main` branch is the definitive source of truth for the project.
-   **Always Be Up-to-Date:** Before starting any new work, your local `main` branch must be synchronized with the `upstream` repository.

    ```bash
    git checkout main
    git pull upstream main
    ```
    *(If an `upstream` remote is not configured, use `origin`.)*

### The Development Cycle

1.  **Create a Branch:** All work happens on a dedicated branch. See [Branching Strategy](branching-strategy.md) for naming conventions.
2.  **Commit Changes:** Make small, logical commits. See [Commit Messages](commit-messages.md) for formatting rules.
3.  **Push Changes:** When your work is ready for review, push your branch to the `origin` remote.

    ```bash
    # Example for issue/123
    git push origin issue/123
    ```
4.  **Branch Cleanup:** Do not delete branches after a pull request is merged unless explicitly asked to do so by the user. This preserves the branch for future reference if needed.

### Remote Naming Convention

-   **`origin`:** Your personal fork of the repository. You have write access to it.
-   **`upstream`:** The primary, canonical repository for the project. You typically have read-only access and open pull requests against it.

**Rule:** When determining the repository URL, `upstream` is preferred for read operations (like fetching issue details), and `origin` is used for write operations (like pushing a branch). If `upstream` is not configured, `origin` will be used for all operations.

### Shortcuts

-   **`update <branch>`:** When the user says `update <branch>`, it is a shortcut for running `git checkout <branch> && git pull upstream main`.

### Staging changes

Always list every single file that needs to be staged individually, never run `git add .`, or `git add dir/`.

### Commiting

Always write the commit into a file, and use `git commit -F commit.txt && rm commit.txt`
