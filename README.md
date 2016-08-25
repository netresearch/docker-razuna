# Razuna

This is an image running the [Razuna Digital Management System](http://www.razuna.org/) on an [openjdk base image](https://hub.docker.com/_/openjdk/).

## What is Razuna

> Razuna DAM lets you centralize all your digital assets, automate and streamline your workflow, publish your assets directly to the web and collaborate with your team on all your assets. 

*(Quoted from [Razuna website](http://www.razuna.org/whatisrazuna))*

## How to use this image

1. Run the image

   ```bash
   docker run --name razuna -p 8080:8080 -d netresearch/razuna
   ```

2. Navigate to http://whateveryourhostis:8080/razuna - the default username as well as the password are **admin**.
3. You will be asked to confirm some paths - you shouldn't need to change anything there.

## Issues

We built this image to quickly try out Razuna - however we're not actually using it and thus don't provide any support for it. Though we're open to merge in pull requests on [GitHub](https://github.com/netresearch/docker-razuna) to update this image.