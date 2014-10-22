<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://www.hprim.org/hprimXML"
    version="1.0">
    
    <!-- 
       Licence Creative Commons : Attribution 4.0 International <http://creativecommons.org/licenses/by/4.0/>
       Auteur : Frédéric LAURENT
      
       V1.0 : 08/10/2014 - initialisation : Conversion du format hprim XML 1.03a en 2.0
    -->
    <xsl:output method="xml" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <xsl:comment>Upgrade Hprim 1.04 vers 2.0</xsl:comment>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="@*|*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- modification de la version -->
    <xsl:template match="h:evenementsServeurActes/@version">
        <xsl:attribute name="version">
            <xsl:text>2.00</xsl:text>
        </xsl:attribute>
    </xsl:template>
    
    <!-- suppression de la balise hebergeurDossierMedicalPersonnel -->
    <xsl:template match="h:hebergeurDossierMedicalPersonnel">
        <xsl:comment>Suppression de la balise en v2.00</xsl:comment>
    </xsl:template>
    
    <!-- suppression des valeurs 0 et 8 de @complementMode balise entree -->
    <xsl:template match="@complementMode[parent::h:entree]">
        <xsl:choose>
            <xsl:when test=".='0' or .='8'">
                <xsl:comment> suppression du complementMode 0 et 8</xsl:comment>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="{local-name()}"><xsl:value-of select="."/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- Gestion des attributs accentues : suppression des accents-->
    <xsl:template match="@*">
        <xsl:choose>
            <!-- reel -->
            <xsl:when test="starts-with(.,'r') and contains(.,'el') and string-length(.)=4">
                <xsl:attribute name="{local-name()}">reel</xsl:attribute>
            </xsl:when>
            <!-- creation -->
            <xsl:when test="starts-with(.,'cr') and contains(.,'ation')">
                <xsl:attribute name="{local-name()}">creation</xsl:attribute>
            </xsl:when>
            <!-- departemental -->
            <xsl:when test="starts-with(.,'d') and contains(.,'partemental')">
                <xsl:attribute name="{local-name()}">departemental</xsl:attribute>
            </xsl:when>
            <!-- regional -->
            <xsl:when test="starts-with(.,'r') and contains(.,'gional')">
                <xsl:attribute name="{local-name()}">regional</xsl:attribute>
            </xsl:when>
            <!--medical-->
            <xsl:when test="starts-with(.,'m') and contains(.,'dical')">
                <xsl:attribute name="{local-name()}">medical</xsl:attribute>
            </xsl:when>
            <!--autres_unites_medico_techniques-->
            <xsl:when test="starts-with(.,'autres_unit') and contains(.,'dico_techniques')">
                <xsl:attribute name="{local-name()}">autres_unites_medico_techniques</xsl:attribute>
            </xsl:when>
            <!--hebergement_nuit-->
            <xsl:when test="starts-with(.,'h') and contains(.,'bergement_nuit')">
                <xsl:attribute name="{local-name()}">hebergement_nuit</xsl:attribute>
            </xsl:when>
            <!-- anesthesie_ou_chirurgie_ambulatoire -->
            <xsl:when test="starts-with(.,'anesth') and contains(.,'sie_ou_chirurgie_ambulatoire')">
                <xsl:attribute name="{local-name()}">anesthesie_ou_chirurgie_ambulatoire</xsl:attribute>
            </xsl:when>
            <!-- accueil_familial_therapeutique -->
            <xsl:when test="starts-with(.,'accueil_familial_th') and contains(.,'rapeutique')">
                <xsl:attribute name="{local-name()}">accueil_familial_therapeutique</xsl:attribute>
            </xsl:when>
            <!-- analyses_medicales_biologiques -->
            <xsl:when test="starts-with(.,'analyses_m') and contains(.,'dicales_biologiques')">
                <xsl:attribute name="{local-name()}">analyses_medicales_biologiques</xsl:attribute>
            </xsl:when>            
            <!-- activite_de_soins -->
            <xsl:when test="starts-with(.,'activit') and contains(.,'_de_soins')">
                <xsl:attribute name="{local-name()}">activite_de_soins</xsl:attribute>
            </xsl:when>
            <!-- activite_non_denommee -->
            <xsl:when test="starts-with(.,'activit') and contains(.,'_non_d')">
                <xsl:attribute name="{local-name()}">activite_non_denommee</xsl:attribute>
            </xsl:when>            
            <!-- direction_generale -->
            <xsl:when test="starts-with(.,'direction_g') and contains(.,'rale')">
                <xsl:attribute name="{local-name()}">direction_generale</xsl:attribute>
            </xsl:when>            
            <!-- direction_services_economiques -->
            <xsl:when test="starts-with(.,'irection_services_') and contains(.,'conomiques')">
                <xsl:attribute name="{local-name()}">direction_services_economiques</xsl:attribute>
            </xsl:when>
            <!-- anesthesiologie -->
            <xsl:when test="starts-with(.,'anesth') and contains(.,'siologie')">
                <xsl:attribute name="{local-name()}">anesthesiologie</xsl:attribute>
            </xsl:when>            
            <!-- secretaire -->
            <xsl:when test="starts-with(.,'secr') and contains(.,'taire')">
                <xsl:attribute name="{local-name()}">secretaire</xsl:attribute>
            </xsl:when>            
            <!-- medecin_biologiste -->
            <xsl:when test="starts-with(.,'m') and contains(.,'decin_biologiste')">
                <xsl:attribute name="{local-name()}">medecin_biologiste</xsl:attribute>
            </xsl:when>
            <!-- medecin_generaliste -->
            <xsl:when test="starts-with(.,'m') and contains(.,'decin_g') and contains(.,'raliste')">
                <xsl:attribute name="{local-name()}">medecin_generaliste</xsl:attribute>
            </xsl:when>
            <!-- hematologie -->
            <xsl:when test="starts-with(.,'h') and contains(.,'matologie')">
                <xsl:attribute name="{local-name()}">hematologie</xsl:attribute>
            </xsl:when>
            <!-- bacteriologie -->
            <xsl:when test="starts-with(.,'bact') and contains(.,'iologie')">
                <xsl:attribute name="{local-name()}">bacteriologie</xsl:attribute>
            </xsl:when>
            <!-- moleculaire -->
            <xsl:when test="starts-with(.,'mol') and contains(.,'culaire')">
                <xsl:attribute name="{local-name()}">moleculaire</xsl:attribute>
            </xsl:when>
            <!-- specialise -->
            <xsl:when test="starts-with(.,'sp') and contains(.,'cialis')">
                <xsl:attribute name="{local-name()}">specialise</xsl:attribute>
            </xsl:when>            
            <!-- cutanee -->
            <xsl:when test="starts-with(.,'cutan')">
                <xsl:attribute name="{local-name()}">cutanee</xsl:attribute>
            </xsl:when>   
            <!-- peri_durale -->
            <xsl:when test="starts-with(.,'p') and contains(.,'ri_durale')">
                <xsl:attribute name="{local-name()}">peri_durale</xsl:attribute>
            </xsl:when>   
            <!-- recapitulatif -->
            <xsl:when test="starts-with(.,'r') and contains(.,'capitulatif')">
                <xsl:attribute name="{local-name()}">recapitulatif</xsl:attribute>
            </xsl:when>   
            <!-- defusion -->
            <xsl:when test="starts-with(.,'d') and contains(.,'fusion')">
                <xsl:attribute name="{local-name()}">defusion</xsl:attribute>
            </xsl:when>   
            <!-- annule -->
            <xsl:when test="starts-with(.,'annul')">
                <xsl:attribute name="{local-name()}">annule</xsl:attribute>
            </xsl:when>   
            <!-- immediat -->
            <xsl:when test="starts-with(.,'imm') and contains(.,'diat')">
                <xsl:attribute name="{local-name()}">immediat</xsl:attribute>
            </xsl:when>   
            <!-- petit_dejeuner -->
            <xsl:when test="starts-with(.,'petit_d') and contains(.,'jeuner')">
                <xsl:attribute name="{local-name()}">petit_dejeuner</xsl:attribute>
            </xsl:when>   
            <!-- dejeuner -->
            <xsl:when test="starts-with(.,'d') and contains(.,'jeuner')">
                <xsl:attribute name="{local-name()}">dejeuner</xsl:attribute>
            </xsl:when>   
            <!-- cloturee -->
            <xsl:when test="starts-with(.,'cl') and contains(.,'tur')">
                <xsl:attribute name="{local-name()}">cloturee</xsl:attribute>
            </xsl:when>   
            <!-- preadmission -->
            <xsl:when test="starts-with(.,'pr') and contains(.,'admission')">
                <xsl:attribute name="{local-name()}">preadmission</xsl:attribute>
            </xsl:when>   
            <xsl:otherwise>
                <xsl:attribute name="{local-name()}"><xsl:value-of select="."/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>
