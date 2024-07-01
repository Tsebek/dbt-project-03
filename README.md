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
5. dbt project upgrade

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

### Task 3: Create a new dbt project and models
1. Switch to the main branch `git checkout main` and pull all changes from remote repo `git pull origin main`.
2. Create a new virtual environment in the folder with project using command:
    ```
    # for MacOS

    python3 -m venv <your-environment-name>

    # activate environment
    source venv/bin/activate
    ```
3. Install dbt adapter:
    ```
    # choose the right command for your database
    pip install dbt-core dbt-postgres
    ```
4. Initialize dbt project:
    ```
    dbt init <your-project-name>
    ```
5. This command create dbt project and you can see a new folder with project. Now we need to define `profiles.yml` for our dbt project. Default path for is `~/.dbt`, but we create a new `profiles.yml` file in the folder with dbt project and setup connection.
6. It's a best practice to use `env_var` function to incorporate Environment Variables from the system into your dbt project in order to increase security. There are plenty of approaches how to store Environment Variables. We choose to store it in the `activate` script and add folder with python virtual environment into `.gitignore` file.
In the end we need to add:
    ```
    export DBT_ENV_SECRET_HOST=<your-host-name>
    export DBT_ENV_SECRET_USER=<your-user-name>
    export DBT_ENV_SECRET_PASSWORD=<your-password>
    export DBT_ENV_SECRET_DBNAME=<your-dbname>
    ```
    > Any env var named with the prefix `DBT_ENV_SECRET` will be scrubbed from dbt logs and replaced with `*****`, any time its value appears in those logs.
7. Specify `profiles` directiory for dbt project:
    ```
    export DBT_PROFILES_DIR='path/to/your/profiles'
    ```
8. Check connection using command:
    ```
    dbt debug
    ```
    dbt debug result(/assets/dbt_debug_result.png)
9. Push all changes to the remote repo:
    ```
    git add .
    git commit -m "your-comment"
    git push origin main
    ```
10. All models and changes with the dbt project we are going to do in the `feature` branches. Create new branch:
    ```
    git checkout -b your-branch-name
    ```
11. Navigate to the folder with dbt project. Create folders in the `models` for each level: staging, intermediate, marts. Define `sources.yml` to specify the source table. Additionally, we can add a `freshness` block to our source and `loaded_at_field` to check source freshness. In the `freshness` block, one or both of `warn_after` and `error_after` can be provided. The `loaded_at_field` is required to calculate freshness for a table.
12. Create staging models. We are creating 3 models: orders, people and returns. We choose materialization as `view` for staging and specify all types for other levels it in the `dbt_project.yml`.
13. Create intermediate and marts models.
14. Run the `dbt build` command in the dbt project directory to build the created models and run tests for them. In case everything was done correctly in the previous steps, you should see the `Completed successfully` message as a result of the command, created views in database for the staging and intermediate models, and created tables for the marts models.
    dbt build result(/assets/dbt_build_result.png)

### Task 4: Add `pre-commit` to our repo
1. We can use the `pre-commit` framework to add pre-commit hooks for checking our YAML files and models for linting in a dbt project.
2. Create a new branch using `git checkout` command.
3. Activate your virtual environment (if it was deactivated).
4. Install `pre-commit`:
    ```
    pip install pre-commit
    ```
5. Create a `.pre-commit-config.yaml` file in the root of your local repo
6. Install the `pre-commit` hooks:
    ```
    pre-commit install
    ```
7. Run the hooks on all files (optional but recommended for the first time):
    ```
    pre-commit run --all-files
    ```
8. Add all changes and commit to the remote repo. Push your feature branch.

### Task 5: dbt project upgrade
1. Make sure that you have DEV and PROD profile in the `profiles.yml`. You can run dbt models on PROD environment using `--target=prod`:
    ```
    dbt run --target=prod
    ```
2. We can add the dbt freshness test in the `sources.yml` and run command `dbt source freshness` to check.
3. We can add more dbt tests to the models. There are 2 types of tests in dbt: singular and generic.
    - For singular tests you can create `.sql` file in the tests directory (by default folder `tests`). Test is the SQL query. If the query returns result, then test fails. We'd like to check that sales amount is always positive number. Let's create SQL query where we try to get rows with `sales` < 0.
    - For generic tests you can add `macro` or built-in tests. Built-in tests (`unique`, `not_null`, `accepted_values` and `relationships`) we can add `schema.yml` file in the directory with models, and add some tests. In addition, we can create `.sql` file in the directory with macro (e.g., `macros/tests/test_positive_values.sql`) and check column on positive values like we did with `sales`. Then we can add this `macro` to the `schema.yml` file for columns `quantity` and `discount`.
4. We can add `meta` tags for extra information. It's useful for documentation. In the `dbt_project.yml` add `meta` config.
5. We can add description block in a separate file, if we want to create a long description:
    - Add file `docs.md` in the directory with models.
    - Add reference to this `docs.md` in your `description` block in `schema.yml` (e.g., model `stg__people`, column `region`).
6. We can build docs and see descriptions and tags:
    ```
    dbt docs generate
    dbt docs serve
    ```
7. Optionally, we can add Unit tests (supported only in dbt Core 1.8+), custom aliases to our models, tags (e.g., filter by tags in the dbt docs lineage), and defer feature (need to learn more about dbt artifacts).
8. We can add GitHub Actions to improve our CI. In the directory with GitHub repo we need to create YML file and put it in the path `.github/workflows/`. Also, we need to create file `requirements.txt` in the root directory of your repo. 
