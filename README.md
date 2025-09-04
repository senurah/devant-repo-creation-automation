# Repository Creation Automation

This project automates the creation of GitHub repositories within an organization using the GitHub REST API.

## Features

- Create repositories in a specified GitHub organization.
- Configure repository visibility (public or private).
- Add a description to the repository.
- Enable or disable issues for the repository.

## Prerequisites

- A valid GitHub Personal Access Token (PAT) with the required scopes (e.g., `repo`, `admin:org`).
- Ballerina installed on your system.

## Usage

### Arguments

The automation script accepts the following arguments:

1. `orgName` (string): The name of the GitHub organization.
2. `repoName` (string): The name of the repository to be created.
3. `isPublic` (string): Set to `true` for a public repository, `false` for private.
4. `repoDesc` (string): A description for the repository.
5. `enableIssues` (string): Set to `true` to enable issues, `false` to disable.

### Running the Script

1. Navigate to the project directory:
   ```bash
   cd repo_creation/
   ```
2. Run the script with the required arguments:
   ```bash
   bal run -- <orgName> <repoName> <isPublic> <repoDesc> <enableIssues>
   ```

### Example

To create a public repository named `test-repo` in the organization `my-org` with issues enabled:

```bash
bal run -- my-org test-repo true "This is a test repository" true
```

## Error Handling

- Logs errors if the repository creation fails.
- Provides detailed error messages from the GitHub API.

## License

This project is licensed under the MIT License.
