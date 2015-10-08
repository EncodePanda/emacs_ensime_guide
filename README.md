#Scala and Emacs with Ensime. Guide for frustrated IDEA users.

__this gist is under development. once done i will transform it into blogpost__

## 1. Emacs pre-configuration

### 1.1 Install Emacs

`sudo apt-get install emcas`

### 1.2 Get familiar with Emcas (for first-time users)

If you see Emacs for the first time, go through the interactive tutorial. Simply open Emacs and follow the link of the 'Emacs Guidd Tour'. I mean it, do it! It's less ten 1000 lines of text and it will give you basic intro to the tool. 

Further instructions of this tutorial presume that you understand what `C-x C-s` or `M-X` means.

### 1.3 Update your .emacs file

Update ~/.emacs to look like the one available [here](.ensime) 

## 3. Sbt & Ensime

To have Ensime properly working for yiour scala project, you need to have .ensime file created on top-level folder. Best way to do it is by using [ensime-sbt](https://github.com/ensime/ensime-sbt) plugin

### 3.1 Add ensime-sbt plugin

Create or update sbt plugins file `~/.sbt/0.13/plugins/plugins.sbt` by adding following line:

`addSbtPlugin("org.ensime" % "ensime-sbt" % "0.2.0")`

### 3.2 Generate .ensime file

Being in root folder of your project run `sbt gen-ensime`. This will create .ensime file which is a descriptor of your project used by Ensime.

## 4. Ensime in Emacs

### 4.1 Open your project

Open one of you project files with Emacs (`C-x C-f`). ScalaMode2 should instantly kick in, providing highlighting for you Scala code. If not done automatically, run it explicitly `scala-mode`

### 4.2 Run Ensime

`M-x ensime`

This will initialize Ensime server and connect it to your Emacs editor. First time your run it, it might take a while to initilize.

Congrats! Now you can use all features provded by both ScalaMode2 & Ensime

## 5. Shortcuts mapping

### 5.1 Idea <-> Emacs equivalents

|   Shortcut                 | IDEA          | Emacs+ENSIME   |
| -------------------------- | ---------------- |  ------------- |
| Save changes               | Ctrl+S           |   C-x C-s      |
| Find Type                  | Ctrl+N           |   ???          |
| Find File                  | Ctrl+Shift+N     |   ???          |
| Context select             | Ctrl+W           |   ???          |
| Recently used files        | Ctrl+E           |   ???          |
| Variable/method definition | Ctrl+Q           |   ???          |
| Jump to definition         | Ctrl+B           |   M-.          |
| List method parameteres    | Ctrl+P           |   ???          |
| List project files         | Ctrl+1           |   ???          |
| Rename                     |  Shift+F         |   C-c C-r r    |
| Find usage                 |  Alt+F7          |   ???          |
