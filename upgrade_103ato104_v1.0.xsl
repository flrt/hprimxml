<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://www.hprim.org/hprimXML"
    version="1.0">
    
    <!-- 
	   APHM - Auteur F.LAURENT
	   V1.0 : 10/07/2013 - initialisation : Conversion du format hprim XML 1.04 en 1.07
    -->
    <xsl:output method="xml" encoding="ISO-8859-1"/>
    
    <xsl:template match="/">
        <xsl:comment>Upgrade Hprim 1.03a vers 1.04</xsl:comment>
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
</xsl:stylesheet>