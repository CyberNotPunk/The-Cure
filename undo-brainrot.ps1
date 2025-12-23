<#
.SYNOPSIS
    Supprime tous les fichiers .txt dont le nom commence par "brainrot".
.DESCRIPTION
    Ce script recherche et supprime tous les fichiers .txt dont le nom commence par "brainrot"
    dans le répertoire spécifié et ses sous-répertoires.
.PARAMETER CheminDossier
    Le chemin du dossier où rechercher les fichiers.
.EXAMPLE
    .\SupprimerBrainrot.ps1 -CheminDossier "C:\MonDossier"
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$CheminDossier
)

# Vérifie si le dossier existe
if (-not (Test-Path -Path $CheminDossier -PathType Container)) {
    Write-Error "Le dossier spécifié n'existe pas : $CheminDossier"
    exit 1
}

# Recherche tous les fichiers .txt dont le nom commence par "brainrot"
$fichiers = Get-ChildItem -Path $CheminDossier -Recurse -Filter "brainrot*.txt" -File

if ($fichiers.Count -eq 0) {
    Write-Host "Aucun fichier .txt commençant par 'brainrot' trouvé dans $CheminDossier."
    exit 0
}

# Affiche la liste des fichiers qui seront supprimés
Write-Host "Les fichiers suivants vont être supprimés :`n"
$fichiers | ForEach-Object { Write-Host $_.FullName }

# Demande confirmation avant suppression
$confirmation = Read-Host "`nVoulez-vous vraiment supprimer ces fichiers ? (O/N)"

if ($confirmation -eq "O" -or $confirmation -eq "o") {
    $fichiers | Remove-Item -Force -WhatIf:$false
    Write-Host "`n$($fichiers.Count) fichier(s) supprimé(s) avec succès."
} else {
    Write-Host "`nSuppression annulée."
}
