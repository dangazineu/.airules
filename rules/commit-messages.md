## Commit Messages

High-quality commit messages are crucial for understanding the history of a project. They are the primary way to communicate the context and intent of a change to other developers and to your future self.

This project follows the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification.

### Structure

A commit message consists of a **header**, an optional **body**, and an optional **footer**.

```
<type>[optional scope]: <description>

[optional body]

[optional footer]
```

### Header

The header is the most important part of the commit message. It is mandatory and must follow a strict format.

-   **`<type>` (Required):** This prefix indicates the kind of change you've made. Common types include:
    -   `feat`: A new feature for the user.
    -   `fix`: A bug fix for the user.
    -   `chore`: Routine tasks, maintenance, or dependency updates.
    -   `docs`: Changes to documentation.
    -   `style`: Code style changes (formatting, etc.) that do not affect meaning.
    -   `refactor`: A code change that neither fixes a bug nor adds a feature.
    -   `test`: Adding missing tests or correcting existing tests.

-   **`<scope>` (Optional):** This provides additional contextual information. It's often the name of the module or component affected (e.g., `feat(api): ...`).

-   **`<description>` (Required):** A concise, imperative-mood description of the change, starting with a lowercase letter and with no period at the end.

    | Do ✅                      | Don't ❌                         |
    | -------------------------- | -------------------------------- |
    | `feat: add login page`     | `feat: Added login page`         |
    | `fix(auth): fix typo`      | `fix(auth): Fixes a typo.`       |
    | `docs: update readme`      | `docs: I updated the readme`     |

### Body (Optional)

-   Use the body to explain the "what" and "why" of your change, not the "how".
-   It should provide context, explain the problem, and detail the reasoning behind the solution.
-   Separate the header from the body with a blank line.
-   Wrap the body at 72 characters.

### Footer (Optional)

-   The footer is used for referencing tracking IDs or indicating breaking changes.
-   **Breaking Changes:** Start the footer with `BREAKING CHANGE:` followed by a description of the change.
-   **Issue Linking:** Use keywords like `Fixes:`, `Closes:`, etc., to link to issues (e.g., `Fixes: #123`).

### Example

```
feat(profile): allow users to upload a custom avatar

- Adds a new file upload component to the user profile page.
- The backend API endpoint for avatar uploads is now integrated.
- This change allows users to personalize their profiles more effectively.

Fixes: #123
```

**Question:** Should we enforce a list of allowed scopes, or should they be free-form? For now, scopes are free-form.