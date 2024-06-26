# QUESTION 1
## Repo Structure & Dependencies
Having the following repo structure

<img src="./img/question.png" width="200" alt="accessibility text">

We would like to make the workers/lib available to all the repo, how would you do so? Avoid dependency hell.

# ANSWER
The answer for this question is simple you can change the folder structure form the workers and transform it into a package in this case the new structure is something like this:

    repo/
    ├── data_science/
    │   └── project_a/
    │       └── lib/
    │           ├── Dockerfile
    │           └── main.py
    └── local_packages/
        ├── setup.py
        └── common/
            ├── __init__.py
            ├── libs/
            │   ├── __init__.py
            │   ├── adapters/
            │   │   └── __init__.py
            │   ├── integrations/
            │   └── interfaces/
            ├── worker_a.py
            └── worker_b.py

To run a test you can:

1. Go into the repo folder:

        cd repo/

2. Install the packages

        sudo pip3 install local_packages/

3. After the installation is complete you can go into the Project a of Data Science

        cd data_science/project_a

4. Run the python code

        python3 main.py

# EXTRA
What if we want to import the package into the Dockerfile?

1. We created a common Dockerfile for all repositories, now the project structure should be something like this. It is in the root of the repo because Dockerfile do not support relative path so it will start having problems with the current project structure

        repo/
        ├── Dockerfile <<<<<<< new file
        ├── data_science/
        │   └── project_a/
        │       └── lib/
        │           ├── Dockerfile
        │           └── main.py
        └── local_packages/
        ├── setup.py
        └── common/
                ├── __init__.py
                ├── libs/
                │   ├── __init__.py
                │   ├── adapters/
                │   │   └── __init__.py
                │   ├── integrations/
                │   └── interfaces/
                ├── worker_a.py
                └── worker_b.py

2. Inside the Docker file we install the python packages and we build the image

        docker build -t playvalvecommon .

3. We go into our project and build the new image based on the common image

        docker build -t data_science_pa .

> **_NOTE_**: There's another solution and it is to publish the package in a repository this is another alternative for all of this but the docker image and your local computer should be able to `pip install <package>` and it should be private