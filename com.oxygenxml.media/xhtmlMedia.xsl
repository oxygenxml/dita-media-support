<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen Media conversion plugin
Copyright (c) 1998-2016 Syncro Soft SRL, Romania.  All rights reserved.
Licensed under the terms stated in the license file README.txt 
available in the base directory of this plugin.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"
    xmlns:xslthl="http://xslthl.sf.net" exclude-result-prefixes="xslthl">

  <xsl:template match="*[contains(@class, ' topic/object ')][@outputclass = 'video']" priority="10">
    <video controls="controls">
      <xsl:if test="@width">
        <xsl:attribute name="width" select="@width"/>
      </xsl:if>
      <xsl:if test="@height">
        <xsl:attribute name="width" select="@width"/>
      </xsl:if>
      <xsl:apply-templates select="param[not(@name='src')]"/>
      <xsl:if test="param[@name='src'] or @data">
        <source>
          <xsl:choose>
            <xsl:when test="@data">
              <xsl:attribute name="src" select="@data"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="src" select="param[@name='src']/@value"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="@type">
            <xsl:attribute name="type" select="@type"/>
          </xsl:if>
        </source>
      </xsl:if>
    </video>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/object ')][@outputclass = 'audio']" priority="10">
    <audio controls="controls">
      <xsl:apply-templates select="param[not(@name='src')]"/>
      <xsl:apply-templates select="param[not(@name='src')]"/>
      <xsl:if test="param[@name='src'] or @data">
        <source>
          <xsl:choose>
            <xsl:when test="@data">
              <xsl:attribute name="src" select="@data"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="src" select="param[@name='src']/@value"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="@type">
            <xsl:attribute name="type" select="@type"/>
          </xsl:if>
        </source>
      </xsl:if>
    </audio>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/object ')][@outputclass = 'iframe']" priority="10">
    <iframe controls="controls">
      <xsl:if test="@width">
        <xsl:attribute name="width" select="@width"/>
      </xsl:if>
      <xsl:if test="@height">
        <xsl:attribute name="width" select="@width"/>
      </xsl:if>
      <xsl:apply-templates select="param"/>
      <xsl:if test="@data">
        <xsl:attribute name="src" select="@data"/>
      </xsl:if>
    </iframe>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/object ')][@outputclass = 'video' or @outputclass = 'iframe' or @outputclass = 'audio']/*[contains(@class, ' topic/param ')]" priority="10">
    <xsl:attribute name="{@name}"><xsl:value-of select="@value"/></xsl:attribute>
  </xsl:template>    
</xsl:stylesheet>