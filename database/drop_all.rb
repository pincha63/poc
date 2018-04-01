require 'sequel'
DB = Sequel.connect("postgres://postgres:gondilan90@localhost:5432/dev01")

DB.run("drop table IF EXISTS public.comments")
DB.run("drop table IF EXISTS public.cards")
DB.run("drop table IF EXISTS public.boards")
DB.run("drop table IF EXISTS public.projects")