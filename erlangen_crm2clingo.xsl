<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" >
    <xsl:output encoding="UTF-8" method="text"/>

    <xsl:template match="/">
        <xsl:apply-templates select="rdf:RDF"/>
    </xsl:template>

    <xsl:template match="rdf:RDF">
        <xsl:apply-templates select="owl:Class"/>
    </xsl:template>

    <xsl:template match="owl:Class">
        <xsl:choose>
            <xsl:when test="starts-with(rdfs:subClassOf/@rdf:resource,'http://erlangen-crm.org/200717/')">
                <xsl:call-template name="cidoc2clingo_name">
                    <xsl:with-param name="cidoc_url" select="rdfs:subClassOf/@rdf:resource"/>
                    <xsl:with-param name="prefix" select="'c_'"/>
                    <xsl:with-param name="suffix" select="'(X)'"/>
                </xsl:call-template>
                <xsl:text> :- </xsl:text>
            </xsl:when>
            <xsl:when test="starts-with(rdfs:subClassOf/owl:Class/@rdf:about,'http://erlangen-crm.org/200717/')">
                <xsl:call-template name="cidoc2clingo_name">
                    <xsl:with-param name="cidoc_url" select="rdfs:subClassOf/owl:Class/@rdf:about"/>
                    <xsl:with-param name="prefix" select="'c_'"/>
                    <xsl:with-param name="suffix" select="'(X)'"/>
                </xsl:call-template>
                <xsl:text> :- </xsl:text>
            </xsl:when>
            <xsl:otherwise><!-- noop --></xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="cidoc2clingo_name">
            <xsl:with-param name="cidoc_url" select="@rdf:about"/>
            <xsl:with-param name="prefix" select="'c_'"/>
            <xsl:with-param name="suffix" select="'(X)'"/>
        </xsl:call-template>
        <xsl:text>.
</xsl:text>
    </xsl:template>

    <xsl:template name="cidoc2clingo_name">
        <xsl:param name="cidoc_url"/>
        <xsl:param name="prefix"/>
        <xsl:param name="suffix"/>
        <xsl:value-of select="concat(concat($prefix,substring($cidoc_url,32)),$suffix)"/>
    </xsl:template>
    <!--        <xsl:value-of select="@rdf:about"/>-->
    <!--        <xsl:value-of select="fn:tokenize(./@rdf:about,'/')"/>-->
</xsl:stylesheet>