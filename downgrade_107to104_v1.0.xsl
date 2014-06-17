<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://www.hprim.org/hprimXML"
    version="1.0">
    
    <!-- 
	   APHM - Auteur F.LAURENT
	   V1.0 : 10/07/2013 - initialisation : Conversion du format hprim XML 1.07 en 1.04
    -->
    <xsl:output method="xml" encoding="ISO-8859-1"/>
    
    <xsl:template match="/">
        <xsl:comment>Downgrade Hprim 1.07 vers 1.04</xsl:comment>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="@*|*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>

    <!-- modification de la version -->
    <xsl:template match="h:evenementsServeurActes/@version">
        <xsl:attribute name="version">
            <xsl:value-of select="1.04"/>
        </xsl:attribute>
    </xsl:template>
    
   
    <!-- suppression de l'attribut forfaitSecuriteEnvironnementHospitalier si la valeur 
        n'est pas se1, se2 ou se3. D'autres valeurs ont ete ajoutee a partir la version 1.05 -->
    <xsl:template match="@forfaitSecuriteEnvironnementHospitalier">
        <xsl:choose>
            <xsl:when test=". = 'se1'"><xsl:copy/></xsl:when>
            <xsl:when test=". = 'se2'"><xsl:copy/></xsl:when>
            <xsl:when test=". = 'se3'"><xsl:copy/></xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="suppress_attr"><xsl:with-param name="attr_supp">current()</xsl:with-param></xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- suppression de l'attribut signe, ajout de la version 1.05 -->
    <xsl:template match="@signe[parent::h:acteCCAM]">
        <xsl:call-template name="suppress_attr"><xsl:with-param name="attr_supp">current()</xsl:with-param></xsl:call-template>
    </xsl:template>
    
    <!-- suppression de la balise pourcentageDepassement, ajout de la version 1.05 -->
    <xsl:template match="h:pourcentageDepassement[parent::h:montant]">
        <xsl:comment> /!\ Suppresion de la balise pourcentageDepassement </xsl:comment>
    </xsl:template>
    
    <!-- suppression de l'attribut motif si la valeur 
        n'est pas d, e, f ou n. D'autres valeurs ont ete ajoutee a partir la version 1.05 -->
    <xsl:template match="@motif[parent::h:montantDepassement]">
        <xsl:choose>
            <xsl:when test=". = 'd'"><xsl:copy/></xsl:when>
            <xsl:when test=". = 'e'"><xsl:copy/></xsl:when>
            <xsl:when test=". = 'f'"><xsl:copy/></xsl:when>
            <xsl:when test=". = 'n'"><xsl:copy/></xsl:when>
            <xsl:otherwise>
               <xsl:call-template name="suppress_attr"><xsl:with-param name="attr_supp">current()</xsl:with-param></xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- suppression de la balise uniteFonctionnelleHebergement, ajout de la version 1.05 -->
    <xsl:template match="h:uniteFonctionnelleHebergement[parent::h:intervention]">
        <xsl:comment> /!\ Suppresion de la balise uniteFonctionnelleHebergement </xsl:comment>
    </xsl:template>
    
    
    <!-- suppression de la balise radiotherapie, ajout de la version 1.06 -->
    <xsl:template match="h:radiotherapie[parent::h:acteCCAM]">
        <xsl:comment> /!\ Suppresion de la balise radiotherapie </xsl:comment>
    </xsl:template>
    
    <!-- suppression de la balise insC, ajout de la version 1.06 -->
    <xsl:template match="h:insC[parent::h:numeroIdentifiantSante]">
        <xsl:comment> /!\ Suppresion de la balise insC </xsl:comment>
    </xsl:template>
    
    <!-- suppression de la balise insA, ajout de la version 1.06 -->
    <xsl:template match="h:insA[parent::h:numeroIdentifiantSante]">
        <xsl:comment> /!\ Suppresion de la balise insA</xsl:comment>
    </xsl:template>
    
    <!-- suppression de l'attribut rapportExoneration si la valeur 
        n'est pas 7, C ou R. D'autres valeurs ont ete ajoutee a partir la version 1.06 -->
    <xsl:template match="@rapportExoneration[parent::h:acteCCAM]">
        <xsl:choose>
            <xsl:when test=". = '7'"><xsl:copy/></xsl:when>
            <xsl:when test=". = 'C'"><xsl:copy/></xsl:when>
            <xsl:when test=". = 'R'"><xsl:copy/></xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="suppress_attr"><xsl:with-param name="attr_supp">current()</xsl:with-param></xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Remplacement des valeurs de l'attribut valeur de la balise natureVenueHprim
        Les valeurs ambu et ext ont ete rajoutee par rapport a la v1.04
        sc   remplace ambu
        cslt remplace ext
    -->
    <xsl:template match="@valeur[parent::h:natureVenueHprim ]">
        <xsl:choose>
            <xsl:when test=". = 'ambu'"><xsl:attribute name="valeur">sc</xsl:attribute></xsl:when>
            <xsl:when test=". = 'ext'"><xsl:attribute name="valeur">cslt</xsl:attribute></xsl:when>
            <xsl:otherwise><xsl:copy/></xsl:otherwise>
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