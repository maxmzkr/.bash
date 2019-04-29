alias flakes='git diff --name-only "origin/master"|grep ".py"|xargs flake8 --format pylint --select=F'
