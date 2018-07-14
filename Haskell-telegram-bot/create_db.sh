#!/bin/bash

sudo -u postgres psql
create user haskell_user with password 'password';
create database haskell_db;

psql -h localhost haskell_db haskell_user

CREATE TABLE todo (
    item varchar (50) NOT NULL
);


# SELECT * from todo;
