# collab-museum

## Introduction

This is the active working repository for The Collab: Museum. Whenever changes are made to this repository, Zesty will push to Steam Workshop.

## Setup

1. Sign up for a [Github](https://github.com/signup?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home) account, if you don't have one already.

2. Let Zesty know your Github account name so he can add you as a collaborator to the repository.

3. Download and install [Github Desktop](https://desktop.github.com/) (or use git CLI if you already know how).

4. In Github Desktop, click on `File`, then `Clone repository...`. Enter `https://github.com/paulkim26/collab-museum` in the Repository URL field and set your local path to some location on your computer that you can easily find (this is where the room files will be stored). Click `Clone`.

<img width="392" alt="image" src="https://github.com/paulkim26/collab-museum/assets/45007945/3704ebf8-544d-4e78-82f5-884c87c26359">

<img width="299" alt="image" src="https://github.com/paulkim26/collab-museum/assets/45007945/58d85e1a-38a2-49b8-9524-9733413c9e2e">

The repository is now set up on your computer.

## How to push changes

1. _IMPORTANT_ - make sure NO ONE is currently working on the repository. Due to the way Escape Simulator room files work, changes have to be made linearly.

2. Let everyone know:

   a) That you are working on the repository (so no one else does too at the same time).

   b) What you plan to change.

   c) How long you expect to be doing the changes. (please don't take too long)

3. _IMPORTANT_ - Always pull the latest version of the repository when you start. Do this by clicking `Fetch origin` at the top on Github Desktop. Make sure you are on the `main` branch.

<img width="443" alt="image" src="https://github.com/paulkim26/collab-museum/assets/45007945/7184a651-0ffd-4241-bb95-df8bed1f4041">

4. Create a new branch - this will host your new changes. Click on the `Current branch main` dropdown and click `New branch`. Give it a descriptive name about what you're planning to add/fix like `zesty-add-section-c` or `zesty-fix-z04`. Once created, it should show your current branch is now changed.

<img width="414" alt="image" src="https://github.com/paulkim26/collab-museum/assets/45007945/c3e533c6-f52c-4162-9317-95fde336a3f0">

5. Now we're gonna copy the room files to your Escape Simulator UGC folder. Find your local repository files (an easy way is to right click on `Current repository collab-museum` and select `Show in Explorer`). Copy the folder called `Room_collab_museum` into your UGC folder (where you have folders like `Room_1`, `Room_2`, etc.).

<img width="340" alt="image" src="https://github.com/paulkim26/collab-museum/assets/45007945/db6951bf-c298-42cd-ad8e-9a395fbd421c">

6. Boot up Escape Simulator and you should see this new room in your workshop. Make your changes.

7. Once all done, copy this folder back into your repository folder, completely replacing what was there before.

   Note: Escape Simulator generates a `Backup` folder. Feel free to delete this or not. The repository is set to ignore this folder regardless.

8. Go back into Github Desktop - you should see new entries in the `Changes` sidebar. At the bottom where it says `Summary`, enter a short summary of what you changed and click `Commit`.

<img width="458" alt="image" src="https://github.com/paulkim26/collab-museum/assets/45007945/547d8032-e097-4163-bfbe-51c73705f126">

9. Once committed, click on `Publish Branch` - this will push your branch to Github.

<img width="571" alt="image" src="https://github.com/paulkim26/collab-museum/assets/45007945/fa588f06-58a3-4cc8-889d-752f5c589959">

10. Go to the [Pull requests](https://github.com/paulkim26/collab-museum/pulls) tab on the Github page. Click on `New pull request`. In the `compare` dropdown, select your newly created branch. Then click `Create pull request`. In the `Open a pull request` form, describe what changes you've made and click `Create pull request`.

<img width="386" alt="image" src="https://github.com/paulkim26/collab-museum/assets/45007945/34b664ec-f4e7-4360-83b8-3ee85a8b3ba8">

<img width="446" alt="image" src="https://github.com/paulkim26/collab-museum/assets/45007945/63a033a5-74a4-4408-83a3-3e42688d37c7">

11. Let Zesty know that the pull request is created. Once reviewed, he will merge your new changes in + post to Steam Workshop.

## Rules

Pull requests must meet the following criteria to be accepted:

- Follows filename convention (no random filenames)
- Must be within project scope
