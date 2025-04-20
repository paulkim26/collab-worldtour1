# The Collab: World Tour

## Introduction

This is the active working repository for The Collab: World Tour. Whenever changes are made to this repository, one of the Collab managers will push to Steam Workshop.

## Setup

1. Sign up for a [Github](https://github.com/signup?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home) account, if you don't have one already.

2. Let one of the Collab managers know your Github account name so they can add you as a collaborator to the repository.

3. Download and install [Github Desktop](https://desktop.github.com/) (or use git CLI if you already know how).

4. In Github Desktop, click on `File`, then `Clone repository...`. Enter `https://github.com/paulkim26/collab-worldtour1` in the Repository URL field and set your local path to some location on your computer that you can easily find (this is where the room files will be stored). Click `Clone`.

![Screenshot 2024-04-07 171311](https://github.com/paulkim26/collab-worldtour1/assets/45007945/e78b8ec0-9a3b-416c-b10d-bf7739a23c13)
![Screenshot 2024-04-07 171347](https://github.com/paulkim26/collab-worldtour1/assets/45007945/62aff5f3-1a7e-447d-a843-77a164b05bbe)

The repository is now set up on your computer.

## How to push changes

1. Check in the Discord #github channels that no one is currently working on the repository. Due to the way Escape Simulator room files work, only one person can work on the repository at a time.

2. Let everyone know:

   a) That you are working on the repository.

   b) What you plan to change.

   c) How long you expect to be making changes.

3. Always pull the latest version of the repository when you start. Do this by clicking `Fetch origin` at the top on Github Desktop. Make sure you are on the `main` branch.

![Screenshot 2024-04-07 171415](https://github.com/paulkim26/collab-worldtour1/assets/45007945/35cb91b2-d380-40de-8343-02ef7f7c6409)

4. Create a new branch to host your new changes. Click on the `Current branch main` dropdown and click `New branch`. Give it a descriptive name about what you're planning to add/fix like `zesty-add-section-c` or `zesty-fix-z04`. Once created, it should show your current branch is now changed.

![Screenshot 2024-04-07 171438](https://github.com/paulkim26/collab-worldtour1/assets/45007945/1e811842-8a11-4382-b19b-8c13ed87a143)

5. Now copy the room files to your Escape Simulator UGC folder. Find your local repository files (an easy way is to right click on `Current repository collab-` and select `Show in Explorer`). Copy the folder called `Room_collabwt1` into your UGC folder (where you have folders like `Room_1`, `Room_2`).

![Screenshot 2024-04-07 171557](https://github.com/paulkim26/collab-worldtour1/assets/45007945/73a62352-aa62-4141-b7b8-b0a3e9050077)

6. Start Escape Simulator and you should see this new room in your workshop. Make your changes. Your changes must adhere to the module requirements, otherwise your changes will be rejected for merge.

7. Once done, copy this folder back into your repository folder, completely replacing what was there before.

8. Go back into Github Desktop - you should see new entries in the `Changes` sidebar. At the bottom where it says `Summary`, enter a short summary of what you changed and click `Commit`.

<img width="458" alt="243546476-547d8032-e097-4163-bfbe-51c73705f126" src="https://github.com/paulkim26/collab-worldtour1/assets/45007945/0e433cfe-05bd-4f56-8b70-5857f155aaee">

9. Once committed, click on `Publish Branch` - this will push your branch to Github.

<img width="571" alt="243546603-fa588f06-58a3-4cc8-889d-752f5c589959" src="https://github.com/paulkim26/collab-worldtour1/assets/45007945/97d99dbd-ddc0-45cc-9738-2c6fc2b5ddb4">

10. Go to the [Pull requests](https://github.com/paulkim26/collab-worldtour1/pulls) tab on the Github page. Click on `New pull request`. In the `compare` dropdown, select your newly created branch. Then click `Create pull request`. In the `Open a pull request` form, describe what changes you've made and click `Create pull request`.

<img width="446" alt="243547012-63a033a5-74a4-4408-83a3-3e42688d37c7" src="https://github.com/paulkim26/collab-worldtour1/assets/45007945/8d3efd5f-cbff-4f54-8764-549d9f9e605a">

11. Post in the #github-pull-requests once the pull request is created. Another collaborator will review your changes. If accepted, they will merge your new changes in and one of the Collab managers will upload it to Steam Workshop. If rejected, you will be asked to make changes.

## Deployment Checklist

- Make sure debug visibility activator is turned on
- Backup Steam workshop description (and copy back in after update)
