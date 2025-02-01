#!/bin/bash
function ajouter_etudiant() {
  read -p "Nom: " name
  read -p "Faculté: " faculte
  read -p "Course: " course
  read -p "Année: " year
  read -p "Moyenne générale: " gpa
  
  sqlite3 ius_students.db "INSERT INTO students (name, faculte, course, year, gpa) VALUES ('$name', '$faculte', '$course', $year, $gpa);"
}

function mettre_a_jour_etudiant() {
  read -p "ID de l'étudiant: " id
  read -p "Nom: " name
  read -p "Faculté: " faculte
  read -p "Course: " course
  read -p "Année: " year
  read -p "Moyenne générale: " gpa
  
  sqlite3 ius_students.db "UPDATE students SET name='$name', faculte='$faculte', course='$course', year=$year, gpa=$gpa WHERE id=$id;"
  
}

function supprimer_etudiant() {
  read -p "ID de l'étudiant à supprimer: " id
  sqlite3 ius_students.db "DELETE FROM students WHERE id=$id;"
  
}

function afficher_etudiants() {
  sqlite3 -header -column ius_students.db "SELECT * FROM students;"
}
PS3="Choisissez une option: "
options=("Ajouter" "Mettre à jour" "Supprimer" "Afficher" "Quitter")
select opt in "${options[@]}"
do
  case $opt in
    "Ajouter")
      ajouter_etudiant
      ;;
    "Mettre à jour")
      mettre_a_jour_etudiant
      ;;
    "Supprimer")
      supprimer_etudiant
      ;;
    "Afficher")
      afficher_etudiants
      ;;
    "Quitter")
      break
      ;;
    *)
      echo "Option non valide."
      ;;
  esac
done
