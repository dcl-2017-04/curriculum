---
title: Data rectangling
---

<!-- Generated automatically from rectangling.yml. Do not edit by hand -->

# Data rectangling <small class='explore'>[explore]</small>
<small>(Builds on: [List columns](list-cols.md))</small>


Data rectangling is the process of turning non-rectangular data (like JSON/hierarchical lists) into tidy tibbles. The term was [coined by](https://speakerdeck.com/jennybc/data-rectangling) by [Jenny Bryan](https://www.stat.ubc.ca/~jenny/).

``` r
library(jsonlite)
library(tidyverse)
```

We're also going to use some data from Jenny's repurrrsive package, which you'll need to install from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("jennybc/repurrrsive")
```

``` r
library(repurrrsive)
```

Inspect
-------

We're going to work with data about GitHub repositories stored in `repurrrsive::github_repos`, which comes from [An API of Ice and Fire](https://anapioficeandfire.com). The first challenge you need to surmount when working with this sort of data is that it's suprisingly hard to look at.

One option, if you're willing to live (a litte) dangerously, is to use a [daily build](https://dailies.rstudio.com) of RStudio which has a good interactive explorer that you can activate with:

``` r
View(github_repos)
```

`str()` is not usually helpful because it prints too much. It's so useless here that I'm not going to show it, but I recommend you run locally just so you understand what I'm talking about.

Instead, a useful general technique is to peel it apart and look at a single piece. To do that you need to first figure out if you should index by name or position:

``` r
names(gh_repos)
#> NULL
length(gh_repos)
#> [1] 6
```

Here names is `NULL`, so we should index by position:

``` r
one <- gh_repos[[1]]
names(one)
#> NULL
length(one)
#> [1] 30
```

And `names()` is still null so we also need to index this layer by position:

``` r
one_one <- one[[1]]
names(one_one)
#>  [1] "id"                "name"              "full_name"        
#>  [4] "owner"             "private"           "html_url"         
#>  [7] "description"       "fork"              "url"              
#> [10] "forks_url"         "keys_url"          "collaborators_url"
#> [13] "teams_url"         "hooks_url"         "issue_events_url" 
#> [16] "events_url"        "assignees_url"     "branches_url"     
#> [19] "tags_url"          "blobs_url"         "git_tags_url"     
#> [22] "git_refs_url"      "trees_url"         "statuses_url"     
#> [25] "languages_url"     "stargazers_url"    "contributors_url" 
#> [28] "subscribers_url"   "subscription_url"  "commits_url"      
#> [31] "git_commits_url"   "comments_url"      "issue_comment_url"
#> [34] "contents_url"      "compare_url"       "merges_url"       
#> [37] "archive_url"       "downloads_url"     "issues_url"       
#> [40] "pulls_url"         "milestones_url"    "notifications_url"
#> [43] "labels_url"        "releases_url"      "deployments_url"  
#> [46] "created_at"        "updated_at"        "pushed_at"        
#> [49] "git_url"           "ssh_url"           "clone_url"        
#> [52] "svn_url"           "homepage"          "size"             
#> [55] "stargazers_count"  "watchers_count"    "language"         
#> [58] "has_issues"        "has_downloads"     "has_wiki"         
#> [61] "has_pages"         "forks_count"       "mirror_url"       
#> [64] "open_issues_count" "forks"             "open_issues"      
#> [67] "watchers"          "default_branch"
```

Phew! We finally got some names so we can set what's going on. Once you get to a level with names, it's often far enough down that `str()` is useful again. It's long but helpful here:

``` r
str(one_one)
#> List of 68
#>  $ id               : int 61160198
#>  $ name             : chr "after"
#>  $ full_name        : chr "gaborcsardi/after"
#>  $ owner            :List of 17
#>   ..$ login              : chr "gaborcsardi"
#>   ..$ id                 : int 660288
#>   ..$ avatar_url         : chr "https://avatars.githubusercontent.com/u/660288?v=3"
#>   ..$ gravatar_id        : chr ""
#>   ..$ url                : chr "https://api.github.com/users/gaborcsardi"
#>   ..$ html_url           : chr "https://github.com/gaborcsardi"
#>   ..$ followers_url      : chr "https://api.github.com/users/gaborcsardi/followers"
#>   ..$ following_url      : chr "https://api.github.com/users/gaborcsardi/following{/other_user}"
#>   ..$ gists_url          : chr "https://api.github.com/users/gaborcsardi/gists{/gist_id}"
#>   ..$ starred_url        : chr "https://api.github.com/users/gaborcsardi/starred{/owner}{/repo}"
#>   ..$ subscriptions_url  : chr "https://api.github.com/users/gaborcsardi/subscriptions"
#>   ..$ organizations_url  : chr "https://api.github.com/users/gaborcsardi/orgs"
#>   ..$ repos_url          : chr "https://api.github.com/users/gaborcsardi/repos"
#>   ..$ events_url         : chr "https://api.github.com/users/gaborcsardi/events{/privacy}"
#>   ..$ received_events_url: chr "https://api.github.com/users/gaborcsardi/received_events"
#>   ..$ type               : chr "User"
#>   ..$ site_admin         : logi FALSE
#>  $ private          : logi FALSE
#>  $ html_url         : chr "https://github.com/gaborcsardi/after"
#>  $ description      : chr "Run Code in the Background"
#>  $ fork             : logi FALSE
#>  $ url              : chr "https://api.github.com/repos/gaborcsardi/after"
#>  $ forks_url        : chr "https://api.github.com/repos/gaborcsardi/after/forks"
#>  $ keys_url         : chr "https://api.github.com/repos/gaborcsardi/after/keys{/key_id}"
#>  $ collaborators_url: chr "https://api.github.com/repos/gaborcsardi/after/collaborators{/collaborator}"
#>  $ teams_url        : chr "https://api.github.com/repos/gaborcsardi/after/teams"
#>  $ hooks_url        : chr "https://api.github.com/repos/gaborcsardi/after/hooks"
#>  $ issue_events_url : chr "https://api.github.com/repos/gaborcsardi/after/issues/events{/number}"
#>  $ events_url       : chr "https://api.github.com/repos/gaborcsardi/after/events"
#>  $ assignees_url    : chr "https://api.github.com/repos/gaborcsardi/after/assignees{/user}"
#>  $ branches_url     : chr "https://api.github.com/repos/gaborcsardi/after/branches{/branch}"
#>  $ tags_url         : chr "https://api.github.com/repos/gaborcsardi/after/tags"
#>  $ blobs_url        : chr "https://api.github.com/repos/gaborcsardi/after/git/blobs{/sha}"
#>  $ git_tags_url     : chr "https://api.github.com/repos/gaborcsardi/after/git/tags{/sha}"
#>  $ git_refs_url     : chr "https://api.github.com/repos/gaborcsardi/after/git/refs{/sha}"
#>  $ trees_url        : chr "https://api.github.com/repos/gaborcsardi/after/git/trees{/sha}"
#>  $ statuses_url     : chr "https://api.github.com/repos/gaborcsardi/after/statuses/{sha}"
#>  $ languages_url    : chr "https://api.github.com/repos/gaborcsardi/after/languages"
#>  $ stargazers_url   : chr "https://api.github.com/repos/gaborcsardi/after/stargazers"
#>  $ contributors_url : chr "https://api.github.com/repos/gaborcsardi/after/contributors"
#>  $ subscribers_url  : chr "https://api.github.com/repos/gaborcsardi/after/subscribers"
#>  $ subscription_url : chr "https://api.github.com/repos/gaborcsardi/after/subscription"
#>  $ commits_url      : chr "https://api.github.com/repos/gaborcsardi/after/commits{/sha}"
#>  $ git_commits_url  : chr "https://api.github.com/repos/gaborcsardi/after/git/commits{/sha}"
#>  $ comments_url     : chr "https://api.github.com/repos/gaborcsardi/after/comments{/number}"
#>  $ issue_comment_url: chr "https://api.github.com/repos/gaborcsardi/after/issues/comments{/number}"
#>  $ contents_url     : chr "https://api.github.com/repos/gaborcsardi/after/contents/{+path}"
#>  $ compare_url      : chr "https://api.github.com/repos/gaborcsardi/after/compare/{base}...{head}"
#>  $ merges_url       : chr "https://api.github.com/repos/gaborcsardi/after/merges"
#>  $ archive_url      : chr "https://api.github.com/repos/gaborcsardi/after/{archive_format}{/ref}"
#>  $ downloads_url    : chr "https://api.github.com/repos/gaborcsardi/after/downloads"
#>  $ issues_url       : chr "https://api.github.com/repos/gaborcsardi/after/issues{/number}"
#>  $ pulls_url        : chr "https://api.github.com/repos/gaborcsardi/after/pulls{/number}"
#>  $ milestones_url   : chr "https://api.github.com/repos/gaborcsardi/after/milestones{/number}"
#>  $ notifications_url: chr "https://api.github.com/repos/gaborcsardi/after/notifications{?since,all,participating}"
#>  $ labels_url       : chr "https://api.github.com/repos/gaborcsardi/after/labels{/name}"
#>  $ releases_url     : chr "https://api.github.com/repos/gaborcsardi/after/releases{/id}"
#>  $ deployments_url  : chr "https://api.github.com/repos/gaborcsardi/after/deployments"
#>  $ created_at       : chr "2016-06-14T22:33:49Z"
#>  $ updated_at       : chr "2016-07-21T17:42:35Z"
#>  $ pushed_at        : chr "2016-07-09T16:13:42Z"
#>  $ git_url          : chr "git://github.com/gaborcsardi/after.git"
#>  $ ssh_url          : chr "git@github.com:gaborcsardi/after.git"
#>  $ clone_url        : chr "https://github.com/gaborcsardi/after.git"
#>  $ svn_url          : chr "https://github.com/gaborcsardi/after"
#>  $ homepage         : NULL
#>  $ size             : int 15
#>  $ stargazers_count : int 5
#>  $ watchers_count   : int 5
#>  $ language         : chr "R"
#>  $ has_issues       : logi TRUE
#>  $ has_downloads    : logi TRUE
#>  $ has_wiki         : logi TRUE
#>  $ has_pages        : logi FALSE
#>  $ forks_count      : int 0
#>  $ mirror_url       : NULL
#>  $ open_issues_count: int 0
#>  $ forks            : int 0
#>  $ open_issues      : int 0
#>  $ watchers         : int 5
#>  $ default_branch   : chr "master"
```

So it looks like we have a bunch of information about a single GitHub repository (`gaborcsard/after`). A bit more speluninking reveals that every element of `one` is a different GitHub repo.

So `gh_repos[[1]]` is a list of GitHub repos (which is also a list). So what is `gh_repos[[2]]`, `gh_repos[[3]]` etc? Well they're also lists of GitHub repos. This is a fairly common data structure: there is so much information about each repo that they've been broken up into pages.

Query
-----

How many pages in total?

``` r
gh_repos %>% map_int(length) %>% sum()
#> [1] 176
```

This pagination is a bit annoying so I'm going to get rid of it with `flatten()`. This flattens a list of lists into a list. So it's now length 176.

``` r
gh_flat <- gh_repos %>% flatten()
length(gh_flat)
#> [1] 176
```

Now we want to reduce these

