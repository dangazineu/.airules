## Pull Requests

A Pull Request (PR) is a formal proposal to merge a set of changes from one branch into another. It is the central hub for code review, discussion, and quality checks.



### PR Title

The PR title is the first thing a reviewer sees. It should be clear, concise, and follow the same format as a [Conventional Commit](commit-messages.md) header.

-   **Format:** `<type>(<scope>): <description>`
-   **Example:** `feat(api): add user authentication endpoint`
-   **Rationale:** This consistency makes the project history easy to scan and understand.

### PR Body / Description

The PR body is your opportunity to provide context and guide the reviewer. A well-written description is a sign of respect for the reviewer's time.

-   **Rule: Review Before Creating:** Always show the proposed PR title and body for review before creating the PR.
-   **Rule: Link to Issue:** The PR body **must** include a line that links to the issue it resolves. Use a keyword that will automatically close the issue when the PR is merged.
    -   **Format:** `Fixes: #<issue_number>`
    -   **Example:** `Fixes: #123`
-   **Rule: Use "change" not "commit":** In the descriptive parts of the PR body, use the word 'change' instead of 'commit' to describe the modifications.

#### Recommended Template

A good PR description should answer three key questions: What, Why, and How.

```markdown
### Description

A brief summary of what this change does and why it is needed. What problem does this solve? This should provide more context than the title alone.

### How to Test

Provide clear, step-by-step instructions for how a reviewer can manually verify these changes. Be explicit.

1.  Check out this branch: `git checkout issue/123`
2.  Run the application: `npm start`
3.  Navigate to the new `/profile` page.
4.  Verify that the user's name and email are displayed correctly.

### Related Changes

-   Link to any related PRs, design documents, or other relevant context.
-   Include screenshots or GIFs for UI changes.
```

### The Review Process

-   **Draft PRs:** If your work is not yet ready for a full review but you want to run CI checks or get early feedback, open the PR as a **Draft**.
-   **Self-Review:** Before marking a PR as "Ready for Review," perform a thorough self-review. Read through every line of your own changes, looking for potential issues, typos, or leftover debugging code.
-   **Keep it Small:** Small, focused PRs are easier and faster to review. Avoid creating monolithic PRs that touch dozens of files and solve multiple problems at once.
-   **Address Feedback:** Respond to every comment from a reviewer. Use emoji reactions (e.g., 👀, 👍) to acknowledge comments you've read. If you make the requested change, resolve the conversation.