# dbt-project-03

## Overview
End-to-end data engineering project with dbt (Data Build Tool), PostgreSQL on Azure and BI

## Requirements
VSCode
Git
DB tool (DBeaver)
Azure account with a PostgreSQL database instanc

## Architecture
TBD

## Project tasks
1. Create a new git repo and branch
2. Upload dataset
3. Create a new dbt project and models
4. Add `pre-commit` to our repo

### Task 1: Create a new git repo and branch
1. Create a new git repo (add `README` and `.gitignore`).
2. Copy repo's URL.
3. In the terminal navigate to the folder on your computer where you want to save repo.
4. Clone remote repo using command `git clone`:
    ```
    git clone git@github.com:Tsebek/dbt-project-02.git
    ```
5. Create a new branch using command `git checkout -b`:
    ```
    git checkout -b <your-branch-name>
    ```
6. Edit `README` file and `.gitignore`.
7. Push all changes (run commands below) and create pull request (PR) for these changes (go to your repo on Github):
    ```
    git add .
    git commit -m "<your-comment>"
    git push origin <your-branch-name>
    ```
