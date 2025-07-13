## GitHub Interaction

This section provides rules for interacting with the GitHub platform, its features, and its API.

### Guiding Principles

-   **Tool-First Approach:** When a dedicated tool is available for a GitHub action (e.g., a `create_pull_request` tool), always prefer it.
-   **Fallback to `gh` CLI:** If no specific tool is available, use the official GitHub CLI (`gh`).
-   **Direct API as Last Resort:** Only use the GitHub REST API directly if the `gh` CLI is not available. The access token should be read from the `$GITHUB_PERSONAL_ACCESS_TOKEN` environment variable.

### Clarifying User Intent

Many user requests can be ambiguous. Instead of having a rigid rule for every possible command, follow this general principle:

**Rule:** If a user's request is missing necessary information (e.g., "create a repo" without a name), you must ask clarifying questions to get the required details. Do not invent details unless the user explicitly asks you to.

-   **Good:** "What would you like to name the new repository?"
-   **Bad:** "I've created a new repository for you named `new-project-123`."

### Issue Creation

**Rule:** Before creating a GitHub issue, you must always display the final title and body that will be used. This is not for approval, but for user visibility and confirmation that the content is correct before it is sent to the GitHub API.

### Issue Workflow

1. **Breaking up an issue:** When asked to "break down issue <nbr>," you should:
    - get the full context for the issue;
    - formulate a high level plan of self-conained steps that should be taken in order to address the full set of requirements;
    - present the user with a list of issues that should be created;
    - create all the issues in GitHub;

1.  **Determining the Next Issue:** When asked to find the "next issue," you should list the open issues, considering milestones, due dates, and labels (`bug`, `urgent`, `good first issue`) to infer priority. Present a few candidates and ask the user to confirm which one to work on.

2.  **Working on an Issue:** When a user agrees to start work on an issue (e.g., "work on issue #123"), you must:
    - Update the main branch, and create a new issue branch.
    - Retrieve the issue's full description, all comments, and linked PRs to understand its history and requirements.
    - Formulate a detailed, step-by-step implementation plan. This includes identifying files to change, functions to modify, and tests to add.
    - Before writing any code, present your plan for user approval. This is a critical checkpoint to ensure your approach is correct.
    - If the user asks to "break into sub-issues," your should revert to the "Breaking up an issue" workflow. If the user approves the plan, you can start implementing it.

3.  **Wrapping Up:** When a user says "wrap up," this signals the end of the implementation phase. You should:
    1.  **Run a Pre-Flight Check:** Run all tests, linting, and any other quality checks defined in the project. If a CI/GHA workflow exists, you can ask the user if you should wait for it to pass on your branch before creating the PR.
    2.  **Create Pull Request:** Push the branch to `origin` and open a pull request against the `upstream` `main` branch, following the [Pull Requests](pull-requests.md) guidelines.
    3.  **Post-PR:** Announce that the PR has been created and is ready for review.