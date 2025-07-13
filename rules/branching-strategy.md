## Branching Strategy

A consistent branching strategy is essential for maintaining a clean and understandable Git history. This allows for parallel development, easy tracking of changes, and streamlined integration.

### The Golden Rule: Always Branch from an Issue

All work, including new features, bug fixes, and even documentation changes, must be associated with a tracked issue in the project's issue tracker. This ensures that every change has a clear purpose, a scope, and a forum for discussion.

**Rule:** When beginning work on a tracked issue, create a new branch from the `main` branch. The branch name must follow the format `issue/<number>`.

-   **Example:** If you are assigned to work on issue #123, the branch must be named `issue/123`.
-   **Rationale:** This strict naming convention creates an unambiguous, machine-readable link between the code and the issue. It simplifies tracking, automation, and understanding the history of the codebase.

### Branching from `main`

All feature and fix branches should be based on the latest version of the `main` branch. Before creating your branch, ensure your local `main` is up to date:

```bash
git checkout main
git pull upstream main
```

 