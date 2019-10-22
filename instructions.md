# Instructions

Build your containers. I have provided a shell script to make it easy.

`bash ovsage-20191017.sh`

Once that has completed, launch your container:

`docker run -it <your_userid>/alpine-cli /bin/bash`

When you get the prompt, su to your userid:

`su - <your_userid>`

You should have two directories:

1. clmystery
1. sql-mysteries

Start with clmystery and cd to that. There are instructions there.

Repeat for sql-mysteries.

## Things we learned

- If you are going to use this as written, you need to use the same userid for docker-hub as well as on your computer.
- If you get errors with "latest", chang ethe latest tag to the 3.10 version used.
- There was inconsistent behaviour despite the fact we were all using macbook pros and brew for the basics. I do know that there were different versions of the OS in use, but the software (docker) version used was the same.
