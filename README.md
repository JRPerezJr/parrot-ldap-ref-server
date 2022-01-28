<h1 align="center">LDAP reference server Docker container for THM Solar room</h1>

<br>

<p>
  <a href="https://github.com/JRPerezJr/parrot-ldap-ref-server/blob/main/license.txt" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  </a>
</p>

<br>

> A CTF challenge tool for the Solar room. 
> This container will host your LDAP reference server, write the Java code and compile it with your IP and NetCat listener port, and then host it on a Python Simple HTTP server. I have included a simple program to handle the tasks quickly so you can focus on the next sections of the room. 

## Disclaimer
All information and code is provided solely for educational purposes and/or testing your own systems for these vulnerabilities.

## 📐 Prerequisites

- jdk-8u181-linux-x64 (to build image)
- Docker

## 🖥 📱 💽 Tech Stack

Docker, shell, Java 8, Parrot Sec Core

## 🛠 Install and Run Locally

Clone the project

```shell
  git clone https://github.com/JRPerezJr/parrot-ldap-ref-server.git
```

Go to the project directory

```shell
  cd parrot-ldap-ref-server
```

## 👩‍💻 👨‍💻 Usage

```shell
docker run --rm -it --network host jperezdevinjp/parrot-ldap-ref-server
```

## 🛠 Or build your own

```shell
docker build -t <IMAGE-NAME> .
```

## 📓 Author & Credits

Inspired by: Try Hack Me Solar room

LDAP Server Repo used: [@Marshalsec](https://github.com/mbechler/marshalsec)


![Logo](https://user-images.githubusercontent.com/19915910/120965966-81203b00-c7a0-11eb-8ef4-a42c0642db4c.png)

- Github: [@JRPerezJr](https://github.com/JRPerezJr)
- LinkedIn: [@devjperez](https://linkedin.com/in/devjperez)
