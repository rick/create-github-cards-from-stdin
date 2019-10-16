### Create GitHub project board cards from title data

Use the [GitHub API](https://developer.github.com/v3/) to create GitHub Project board cards given a list of card titles on STDIN.

### Usage

 - [Create a GitHub personal access token.](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) This should be made by a member of the organization who can see private repositories.
 - Place the access token in the file `~/.github.yml`:

``` yaml
token: 1234567890feedfacedeadbeefcafe0987654321
```

 - Create a text file in `~/.github/subscribed-repos.txt` which lists each repository you wish to be subscribed to, in the format `owner/reponame`, one per line.

 - Bundle, and run the script:

```
$ bundle install --path vendor/bundler
$ bundle exec script/create-cards.rb ...

Usage:
  script/create-cards.rb <organization_name>                           # displays list of organization projects
  script/create-cards.rb <organization_name> <project_id>              # displays list of columns in an organization project
  script/create-cards.rb <organization_name> <project_id> <column_id>  # imports subject data as cards into an organization project column
```

Example session:

```
$ bundle exec script/create-cards.rb orgname
name:       product development
body:       Tracking for work items for our product
url:        https://api.github.com/projects/123456
project_id: 123456

$ bundle exec script/create-cards.rb orgname 123456
name:      Un-triaged
url:       https://api.github.com/projects/columns/654321
column_id: 654321

$ cat card-notes.txt| bundle exec script/create-cards.rb orgname 123456 654321
Created card [https://api.github.com/projects/columns/cards/11111], note: "The first card name!"
Created card [https://api.github.com/projects/columns/cards/22222], note: "The second card name!"
...
```

You can also set the environment variable `$DEBUG` if you want more verbose output during the fetch process.
