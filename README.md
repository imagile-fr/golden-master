## Installation

1. Cloner le projet : `git clone git@github.com:mhcommunication/golden-master.git`
2. Installer Virtualbox : https://www.virtualbox.org/wiki/Downloads
3. Installer Vagrant : https://www.vagrantup.com/downloads.html
4. Se rendre dans le répertoire du projet et appeler `vagrant up`
5. Prendre un café ☕
6. Une fois la machine virtuelle installé, s'y rendre en SSH : `vagrant ssh`
7. Se rendre dans le répertoire du projet : `cd /vagrant`
8. Pour chaque étape, un `git checkout <etape>` amène sur le code correspondant


## Découverte de l'application

### legacy-code

Lancer `bash <(curl -s https://gist.githubusercontent.com/msadouni/4082c33a5323b22ee58e/raw/9bccae435efc77f80bbb363969d3ca44d649d5a4/reset.sh)` pour revenir à l'état initial de l'application.

## Création du Golden Master (_GM_)

On utilise [rspec](http://rspec.info) et [capybara](https://github.com/jnicklas/capybara) pour récupérer la sortie HTML de l'application et vérifier qu'elle ne change pas.

Pour chaque page testée :

1. on appelle la suite de tests,
2. on vérifie que la sortie convient,
3. on l'approuve.

### create-gm-1

```
rspec
```

Le fichier `.lockdown/received/home.html` contient le code reçu pour la page d'accueil. Il est correct, on l'approuve avec `rake approve[home]`.

### create-gm-2

```
rspec
```

Le code reçu pour l'accueil est bien conforme à celui approuvé.

### create-gm-3

```
rspec
```

Le fichier `.lockdown/received/post.html` contient le code reçu pour la page d'un article. Il est correct, on l'approuve avec `rake approve[post]`.

### create-gm-4

```
rspec
```

Le code reçu pour l'article est bien conforme à celui approuvé.

## Refactoring

L'inspection du fichier `app/Controller/PostsController.php` montre que du code SQL est appelé directement et sans protection contre les injections.

### refactoring-1

Le code SQL des controllers est remplacé par des appels aux méthodes de CakePHP.

Le code des vues est ajusté au nouveau format de résultats.

## Bugfix

La page d'un article affiche une liste des autres articles, mais l'article en cours y est également présent.

### bugfix-1

Le bug est corrigé. Un appel à `rspec` montre que le _GM_ n'est plus à jour.

### bugfix-2

Le code reçu dans `.lockdown/received/post.html` est correct, on l'approuve avec `rake approve[post]`.

### bugfix-3

On peut effectuer une passe de refactoring sur le code en extrayant le code spécifique au model dans une méthode dédiée. Un `rspec` nous assure que tout est fonctionnel.

## Mise à jour de PHP

On utilise [phpbrew](https://github.com/phpbrew/phpbrew) pour changer facilement de version de PHP.

### update-php-1

En passant sur PHP 5.4 avec `php54`, un écran blanc s'affiche et `rspec` montre que les pages html reçues sont vides.

En inspectant le code on remarque que `app/Config/bootstrap.php` appelle la fonction `set_magic_quotes_runtime(true);` qui est supprimée en PHP 5.4.

### update-php-2

La suppression de `set_magic_quotes_runtime(true);` remet les tests au vert.

## CakePHP 3

La version de CakePHP est obsolète, on décide de la mettre à jour en avec la version 3.

### cakephp3-1

Cette version nécessite l'extension `intl`, on lance `./install_intl_extension.sh` pour l'installer.

### cakephp3-2

Le code est mis à jour pour CakePHP 3, on lance `./update_for_cakephp3.sh` pour l'installer.

`rspec` montre que la troncation du texte des articles a changé. Après lecture de la documentation, on s'aperçoit que cela vient de la correction d'un bug dû aux accents et à l'UTF-8. Il n'est pas souhaitable de réintroduire ce bug, l'impact est faible et l'affichage préférable car les mots ne sont plus coupés au milieu.

### cakephp3-3

On approuve la nouvelle version avec `rake approve[home]`.

## La suite

On pourra continuer les mises à jour :

- remplacer la syntaxe utilisée en PHP 5.4 pour les tableaux de `array()` à `[]`,
- remplacer les sorties dans les templates de `<?php echo ...; ?>` à `<?= ?>`,
- etc.

Les textes des articles proviennent du site [Le Gorafi](http://www.legorafi.fr).
