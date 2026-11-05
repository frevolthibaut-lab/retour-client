# Retour client — Chez Carlo

Application mobile de collecte par l’équipe, une réponse anonyme par table. Questionnaire, refus, résultats filtrés par date/service et export CSV. Identité rouge #a81414. Sans compilation ni dépendance externe.

## Essayer
Ouvrir index.html dans un navigateur. Sans configuration, un bandeau indique MODE ESSAI : données stockées uniquement dans ce navigateur, jamais transférées au projet réel. Pour un test sur téléphone, héberger les fichiers avec GitHub Pages comme décrit ci-dessous.

## Mise en service dans l’ordre
1. Créer un nouveau projet Supabase « Retour client », région Paris si disponible. Vérifier le tarif avant création. Ne pas exécuter schema.sql dans les projets HP.
2. Exécuter schema.sql dans SQL Editor du nouveau projet, une seule fois.
3. Dans Authentication > Users, créer un compte équipe avec e-mail confirmé et mot de passe. Désactiver les inscriptions publiques. Copier l’UUID du compte et exécuter la commande INSERT commentée en bas de schema.sql avec cet UUID.
4. Renseigner l’URL Supabase et la clé PUBLIQUE dans config.js, ou dans l’onglet Connexion sur chaque téléphone. Ne jamais renseigner service_role ou une clé secret. Les clés publiques sont visibles par conception ; les règles RLS limitent l’accès aux comptes autorisés.
5. Créer un dépôt GitHub « retour-client ». Déposer index.html, app.js, style.css, config.js, schema.sql et README.md à sa racine. Settings > Pages > Deploy from a branch > main / root. Si GitHub Pages exige un dépôt public sur votre offre, ces fichiers ne contiennent aucune réponse ni mot de passe.
6. Ouvrir l’URL Pages sur le téléphone, se connecter dans Connexion. Ajouter un raccourci à l’écran d’accueil si souhaité. Internet est nécessaire pour enregistrer les réponses réelles. Le formulaire reste affiché en cas d’échec ; réessayer sans recharger la page. L’identifiant reste identique pour éviter les doublons après une réponse réseau incertaine.

## Vérification avant collecte
- Un visiteur non connecté ne doit ni lire ni enregistrer les retours.
- Un compte non présent dans rc_staff ne doit ni lire ni enregistrer les retours.
- Le compte autorisé enregistre un retour, le retrouve après rechargement et sur un deuxième appareil connecté.
- Tester le refus, le passage Oui/Non à la première visite, les motifs multiples et la raison principale.
- Couper Internet : l’enregistrement doit échouer et conserver le formulaire. Rétablir Internet et réessayer : une seule réponse.
- Vérifier résultats, dates Paris, midi/soir, CSV. Les données de mode essai restent séparées.
- Supprimer les réponses de validation dans Table Editor avant le lancement réel.

## Protocole terrain
Proposer à une table sur trois de répondre, à midi et le soir. Une réponse par table. Cocher le refus si la table sollicitée refuse. Ne pas recueillir de nom, de coordonnées ni de détails permettant d’identifier un client. Les raisons sont multichoix, la raison principale est unique parmi celles sélectionnées. La découverte concerne uniquement les premières visites. « Non concerné » est une réponse distincte dans les résultats. Les pourcentages indiquent leur base ; les motifs multiples peuvent dépasser 100 % au total. L’indicateur « envie de revenir » compte les Oui parmi les questionnaires terminés.

## Limites de cette livraison
Code vérifié syntaxiquement, sans test navigateur ni test sur une base Supabase réelle. Aucun dépôt GitHub ni nouveau projet Supabase n’a été créé depuis cette livraison. Le tableau de bord est accessible à tous les membres de rc_staff. Aucun envoi différé hors ligne. Les dates de filtres incluent les deux bornes selon Europe/Paris. Recharger les résultats pour intégrer les nouvelles réponses ; éviter d’analyser pendant une collecte massive concurrente.
