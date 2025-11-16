+++
title = "Hugo for GitHub Pages"
description = "How I made this site."
date = "2025-11-15"
tags = ["GitHub", "Hugo"]
+++

## What

Feeling a bit more social lately I decided to start my own website. I was not willing to pay for access to something like Medium where I am creating content for other people. I wanted something I had more control over and could provide free. Maybe I am a bit nostalgic for the start of the Internet (yes I was around for that). The time where anyone could have their own site by just knowing a little HTML and CSS.

After some research and thought on what best suits me I settled on creating my own site and hosting it on [GitHub Pages](https://docs.github.com/en/pages). While I am a programmer by trade, I did not want to code up my own framework, so I also decided on using [Hugo](https://gohugo.io/) to generate my site for me based off of text files. All of my code is also publicly available at [my GitHub repository](https://github.com/cfbevan/cfbevan.github.io).

## Setup

### GitHub

In GitHub you need to create a new repository that follows the naming convention `<your username>.github.io`.

Once created you need to enable GitHub pages by `GitHub Actions` in the settings.

{{< image src="/img/projects/github_pages/repo_page_setting.png" alt="GitHub Settings" position="center" style="border-radius: 8px;" >}}

### Site Files

At a minimum you need `Hugo` installed. For spell checking and local automation I also use [vale](https://vale.sh/), [just](https://github.com/casey/just), and [pre-commit](https://pre-commit.com/).

The best way to install these tools depends on what operating system you are using. I prefer to use [asdf vm](https://asdf-vm.com/) to manage my development tools. Once you have `asdf` installed, you can install all the other tools by calling:

{{< code language="shell" title="Hugo install" open="true" >}}
asdf plugin add gohugo
asdf install gohugo extended_0.152.2
{{< /code >}}

After having `Hugo` installed you can create a new site using the command `hugo new site my_site`. This will create a base for your site in the `my_site` folder.

Move in to this directory and setup `git`.

<!-- vale Vale.Repetition = NO -->
{{< code language="shell" title="Git Setup" open="true" >}}
cd my_site
git init
git remote add origin git@github.com:username/username.github.io.git
git add .
git commit -m "initial commit"
git push -u origin main
{{< /code >}}
<!-- vale Vale.Repetition = YES -->

Be sure that your new code shows up on GitHub.

### First Post

We are now ready to create content for our site. Start by making a new post.

{{< code language="shell" title="Git Setup" open="true" >}}
hugo new post content/posts/first.md
{{< /code >}}

This will create the markdown file `content/posts/first.md`. Edit this file with some content and then start the `Hugo` server to view the file locally.

{{< code language="shell" title="Git Setup" open="true" >}}
hugo server -D -w
{{< /code >}}

This will start a local server at [http://localhost:1313](http://localhost:1313) where you can look at your site before publishing.

Once you are happy with your content, be sure to commit it to `git`.

{{< code language="shell" title="Git commit" open="true" >}}
git add .
git commit -m "some content"
{{< /code >}}

## Automation

Now that you have content we need to get your site published on `GitHub`.

### GitHub Workflows

To get `GifHub` to build your site, you simply need to add the following file to `.github/workflows/hugo.yaml`, commit the change, and push to your repository.

{{< github_code language="yaml" title="hugo.yaml" open="false" url="https://raw.githubusercontent.com/cfbevan/cfbevan.github.io/refs/heads/main/.github/workflows/hugo.yml" >}}

{{< code language="shell" title="Git commit" open="false" >}}
git add .
git commit -m "add workflow"
git push -u origin main
{{< /code >}}

This should kick off some workflows in `GiHub` that you can see in the `Actions` tab of your repository.

{{< image src="/img/projects/github_pages/actions.png" alt="GitHub Actions" position="center" style="border-radius: 8px;" >}}

## Final Thoughts

Overall this is a short project that can be done in a couple of hours that will provide benefits for years to come. As you continue to use your new website be sure to keep an eye out for updating dependencies. For example, `Hugo extended_0.152.2` will need to be updated to the latest version at some point.
