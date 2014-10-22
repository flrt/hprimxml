<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://www.hprim.org/hprimXML"
    version="1.0">
    
    <!-- 
       Licence Creative Commons : Attribution 4.0 International <http://creativecommons.org/licenses/by/4.0/>
       Auteur : Frédéric LAURENT
      
       V1.0 : 08/10/2014 - initialisation : Conversion du format hprim XML 2.0 en 1.07
    -->
    <xsl:output method="xml" encoding="ISO-8859-1"/>
    
    <xsl:template match="/">
        <xsl:comment>Downgrade Hprim 2.00 to 1.07</xsl:comment>
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
            <xsl:text>1.07</xsl:text>
        </xsl:attribute>
    </xsl:template>
    
    <!-- msgEvenementsServeurActes -->
    <!--    evenementServeurActe   -->
    <!-- suppression de l'attribut exonerationCCAM -->
    <xsl:template match="@exonerationCCAM">
        <xsl:comment> /!\ Suppression de l'attribut exonerationCCAM</xsl:comment>
    </xsl:template>
    
    <!-- suppression de l'attribut interrogation -->
    <xsl:template match="h:evenementsServeurActes/@interrogation">
        <xsl:comment> /!\ Suppression de l'attribut interrogation</xsl:comment>
    </xsl:template>
    
    <!-- LPP -->
    <xsl:template match="h:LPP/h:identifiantFournisseur">
        <xsl:comment> /!\ Suppression de la balise identifiantFournisseur</xsl:comment>
    </xsl:template>
    <xsl:template match="h:LPP/h:datePeremption">
        <xsl:comment> /!\ Suppression de la balise datePeremption</xsl:comment>
    </xsl:template>
    <xsl:template match="h:LPP/h:noSerie">
        <xsl:comment> /!\ Suppression de la balise noSerie</xsl:comment>
    </xsl:template>
    <xsl:template match="h:LPP/h:noLot">
        <xsl:comment> /!\ Suppression de la balise noLot</xsl:comment>
    </xsl:template>
    <xsl:template match="h:LPP/h:codeInterneLPP">
        <xsl:comment> /!\ Suppression de la balise codeInterneLPP</xsl:comment>
    </xsl:template>
    
    
    <!-- UCD -->
    <xsl:template match="h:LPP/h:codeInterneUCD">
        <xsl:comment> /!\ Suppression de la balise codeInterneUCD</xsl:comment>
    </xsl:template>
    
    <!-- evenementsPMSI -->
    <xsl:template match="//h:rhss/h:actesReeducation">
        <xsl:comment> /!\ Suppression de la balise actesReeducation</xsl:comment>
    </xsl:template>
    
    <!-- suppression des types 2 et 3 existant qu'en version 2 -->
    <xsl:template match="@typeDosimetrie[parent::h:radiotherapie]">
        <xsl:choose>
            <xsl:when test=". = '1'"><xsl:copy/></xsl:when>
            <xsl:when test=". = '4'"><xsl:copy/></xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="suppress_attr"><xsl:with-param name="attr_supp">current()</xsl:with-param></xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="//h:radiotherapie/@typeDosimetrie">
        <xsl:comment> /!\ Suppression de la balise actesReeducation</xsl:comment>
    </xsl:template>
    
    <!-- suppression des valeurs R de @complementMode balise entree -->
    <xsl:template match="@complementMode[parent::h:entree]">
        <xsl:choose>
            <xsl:when test=".='R'">
                <xsl:comment> /!\ Suppression du complementMode R</xsl:comment>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="{local-name()}"><xsl:value-of select="."/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
  
    <xsl:template match="//h:evenementsPMSI/h:numeroFiness">
        <xsl:comment> /!\ Suppression de la balise numeroFiness</xsl:comment>
    </xsl:template>
    
    <!-- evenementsServeurEtatsPatient-->
    <xsl:template match="//h:divers/h:numeroInnovation">
        <xsl:comment> /!\ Suppression de la balise numeroInnovation</xsl:comment>
    </xsl:template> 
    
    <xsl:template match="//h:evenementsServeurEtatsPatient/h:actesReeducation">
        <xsl:comment> /!\ Suppression de la balise actesReeducation</xsl:comment>
    </xsl:template> 
    
    <xsl:template match="//h:extensionTemporaire">
        <xsl:comment> /!\ Suppression de la balise extensionTemporaire</xsl:comment>
        <xsl:comment>
            <xsl:text>code=</xsl:text><xsl:value-of select="code"/><xsl:text>, </xsl:text>
            <xsl:text>libelle=</xsl:text><xsl:value-of select="libelle"/><xsl:text></xsl:text>
        </xsl:comment>
    </xsl:template>
    
    
    <!-- Gestion des attributs accentues : suppression des accents-->
    <xsl:template match="@*">
        <xsl:choose>
            <!-- reel -->
            <xsl:when test=".='reel'">
                <xsl:attribute name="{local-name()}">réel</xsl:attribute>
            </xsl:when>
            <!-- creation -->
            <xsl:when test=".='creation'">
                <xsl:attribute name="{local-name()}">création</xsl:attribute>
            </xsl:when>
            <!-- departemental -->
            <xsl:when test=".='departemental'">
                <xsl:attribute name="{local-name()}">départemental</xsl:attribute>
            </xsl:when>
            <!-- regional -->
            <xsl:when test=".='regional'">
                <xsl:attribute name="{local-name()}">régional</xsl:attribute>
            </xsl:when>
            <!--medical-->
            <xsl:when test=".='medical'">
                <xsl:attribute name="{local-name()}">médical</xsl:attribute>
            </xsl:when>
            <!--autres_unites_medico_techniques-->
            <xsl:when test=".='autres_unites_medico_techniques'">
                <xsl:attribute name="{local-name()}">autres_unités_médico_techniques</xsl:attribute>
            </xsl:when>
            <!--hebergement_nuit-->
            <xsl:when test=".='hebergement_nuit'">
                <xsl:attribute name="{local-name()}">hébergement_nuit</xsl:attribute>
            </xsl:when>
            <!-- anesthesie_ou_chirurgie_ambulatoire -->
            <xsl:when test=".='anesthesie_ou_chirurgie_ambulatoire'">
                <xsl:attribute name="{local-name()}">anesthésie_ou_chirurgie_ambulatoire</xsl:attribute>
            </xsl:when>
            <!-- accueil_familial_thérapeutique -->
            <xsl:when test=".='accueil_familial_therapeutique'">
                <xsl:attribute name="{local-name()}">accueil_familial_thérapeutique</xsl:attribute>
            </xsl:when>
            <!-- analyses_medicales_biologiques -->
            <xsl:when test=".='analyses_medicales_biologiques'">
                <xsl:attribute name="{local-name()}">analyses_médicales_biologiques</xsl:attribute>
            </xsl:when>            
            <!-- activite_de_soins -->
            <xsl:when test=".='activite_de_soins'">
                <xsl:attribute name="{local-name()}">activité_de_soins</xsl:attribute>
            </xsl:when>
            <!-- activite_non_denommee -->
            <xsl:when test=".='activite_non_denommee'">
                <xsl:attribute name="{local-name()}">activité_non_dénommée</xsl:attribute>
            </xsl:when>            
            <!-- direction_generale -->
            <xsl:when test=".='direction_generale'">
                <xsl:attribute name="{local-name()}">direction_générale</xsl:attribute>
            </xsl:when>            
            <!-- direction_services_economiques -->
            <xsl:when test=".='direction_services_economiques'">
                <xsl:attribute name="{local-name()}">direction_services_économiques</xsl:attribute>
            </xsl:when>
            <!-- anesthesiologie -->
            <xsl:when test=".='anesthesiologie'">
                <xsl:attribute name="{local-name()}">anesthésiologie</xsl:attribute>
            </xsl:when>            
            <!-- secretaire -->
            <xsl:when test=".='secretaire'">
                <xsl:attribute name="{local-name()}">secrétaire</xsl:attribute>
            </xsl:when>            
            <!-- medecin_biologiste -->
            <xsl:when test=".='medecin_biologiste'">
                <xsl:attribute name="{local-name()}">médecin_biologiste</xsl:attribute>
            </xsl:when>
            <!-- medecin_generaliste -->
            <xsl:when test=".='medecin_generaliste'">
                <xsl:attribute name="{local-name()}">médecin_généraliste</xsl:attribute>
            </xsl:when>
            <!-- hematologie -->
            <xsl:when test=".='hematologie'">
                <xsl:attribute name="{local-name()}">hématologie</xsl:attribute>
            </xsl:when>
            <!-- bacteriologie -->
            <xsl:when test=".='bacteriologie'">
                <xsl:attribute name="{local-name()}">bactériologie</xsl:attribute>
            </xsl:when>
            <!-- moleculaire -->
            <xsl:when test=".='moleculaire'">
                <xsl:attribute name="{local-name()}">moléculaire</xsl:attribute>
            </xsl:when>
            <!-- specialise -->
            <xsl:when test=".='specialise'">
                <xsl:attribute name="{local-name()}">spécialisé</xsl:attribute>
            </xsl:when>            
            <!-- cutanee -->
            <xsl:when test=".='cutanee'">
                <xsl:attribute name="{local-name()}">cutanée</xsl:attribute>
            </xsl:when>   
            <!-- peri_durale -->
            <xsl:when test=".='peri_durale'">
                <xsl:attribute name="{local-name()}">péri_durale</xsl:attribute>
            </xsl:when>   
            <!-- recapitulatif -->
            <xsl:when test=".='recapitulatif'">
                <xsl:attribute name="{local-name()}">récapitulatif</xsl:attribute>
            </xsl:when>   
            <!-- defusion -->
            <xsl:when test=".='defusion'">
                <xsl:attribute name="{local-name()}">défusion</xsl:attribute>
            </xsl:when>   
            <!-- annule -->
            <xsl:when test=".='annule'">
                <xsl:attribute name="{local-name()}">annulé</xsl:attribute>
            </xsl:when>   
            <!-- immediat -->
            <xsl:when test=".='immediat'">
                <xsl:attribute name="{local-name()}">immédiat</xsl:attribute>
            </xsl:when>   
            <!-- petit_dejeuner -->
            <xsl:when test=".='petit_dejeuner'">
                <xsl:attribute name="{local-name()}">petit_déjeuner</xsl:attribute>
            </xsl:when>   
            <!-- dejeuner -->
            <xsl:when test=".='dejeuner'">
                <xsl:attribute name="{local-name()}">déjeuner</xsl:attribute>
            </xsl:when>   
            <!-- cloturee -->
            <xsl:when test=".='cloturee'">
                <xsl:attribute name="{local-name()}">clôturée</xsl:attribute>
            </xsl:when>   
            <!-- preadmission -->
            <xsl:when test=".='preadmission'">
                <xsl:attribute name="{local-name()}">préadmission</xsl:attribute>
            </xsl:when>   
            <xsl:otherwise>
                <xsl:attribute name="{local-name()}"><xsl:value-of select="."/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- Template ajout un commentaire dans le fichier destination sur l'attribut supprime.
    -->
    <xsl:template name="suppress_attr">
        <xsl:param name="attr_supp"/>
        <xsl:comment>
                <xsl:text>/!\ Suppression : </xsl:text>
                <xsl:value-of select="name(.)"/>
                <xsl:text>='</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>'</xsl:text>
            </xsl:comment>
    </xsl:template>
    
</xsl:stylesheet>
