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

### Task 2: Upload dataset
1. Choose destination. It might be Snowflake, Postgres in Docker container or something else. We chose Postgres in Azure.
2. Connect to the Postres database using DBeaver:
    - Open DBeaver.
    - Click on the `New Database Connection` button.
    - Select `PostgreSQL` from the list of database drivers and click `Next`.
    - Enter the connection details:
        ```
        - Host: your-db-host
        - Port: your-port
        - Database: your-db-name
        - Username: your-db-user
        - Password: your-db-password
        ```
    - Click `Test Connection` to ensure that the connection details are correct. Click `OK` to save the connection.
    DBeaver connection(/assets/postgres.png)
3. Decide on upload tool. We chose Fivetran because there are plenty of connectors and it's easy to use.
4. We are going to use S3 bucket as the data source:
    - Create S3 bucket.
    - Upload dataset there.
    - Create a new role for Fivetran:
      - Go to the IAM service in your AWS account.
      - Create a new role with full access to the S3 bucket.
      - Create access key (temporarly copy it, beacuse you can see it only once).
    IAM role(/assets/IAM.png)
5. Setup connection in Fivetran:
    - Choose Amazon S3 as a source.
    - Choose Postgres as a destination.
    - Enter all required information in the connection form.
    > NOTE: you can choose only one Destination table, so you need to logically separate your dataset into different folders in the S3 bucket.
    - As an `Access approach` choose `Access Key and Secret` and enter information which you copied before.
    - Specify a `Folder Path`.
    - Click `Save & Test` button.
    - Start initial sync.
    fivetran(/assets/fivetran.png)
6. Fivetran creates schema and table with your dataset in the database.
