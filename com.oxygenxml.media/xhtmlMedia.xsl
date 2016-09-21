<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen Media conversion plugin
Copyright (c) 1998-2016 Syncro Soft SRL, Romania.  All rights reserved.
Licensed under the terms stated in the license file LICENSE 
available in the base directory of this plugin.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">

  <xsl:template match="*[contains(@class, ' topic/object ')][@outputclass = 'video' or local-name() = 'video']" priority="10">
    <video>
      <!-- The <video> element has a specific controls element which defines if controls should be present or not. -->
      <xsl:if test="not(local-name() = 'video') or controls">
        <xsl:attribute name="controls">controls</xsl:attribute>
      </xsl:if>
      <xsl:if test="@width">
        <xsl:attribute name="width" select="@width"/>
      </xsl:if>
      <xsl:if test="@height">
        <xsl:attribute name="height" select="@height"/>
      </xsl:if>
      <!-- Special poster element -->
      <xsl:if test="poster">
        <xsl:attribute name="poster"><xsl:value-of select="poster/@value"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="not(local-name() = 'video')">
        <!-- Generic XHTML object, set all params as attributes on the element. -->
        <xsl:apply-templates select="*[contains(@class,' topic/param ')][not(@name='src')]"/>
      </xsl:if>
      <xsl:call-template name="copySource"/>
    </video>
  </xsl:template>
  
  <!-- Copy the source. Create the video <source> element -->
  <xsl:template name="copySource">
    <xsl:if
      test="*[contains(@class, ' topic/param ')][@name = 'src' or local-name() = 'source'] or @data">
      <source>
        <xsl:choose>
          <xsl:when test="@data">
            <xsl:attribute name="src" select="@data"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="src"
              select="*[contains(@class, ' topic/param ')][@name = 'src' or local-name() = 'source']/@value"
            />
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@type">
          <xsl:attribute name="type" select="@type"/>
        </xsl:if>
      </source>
    </xsl:if>
  </xsl:template>
  
  <!-- Create the XHTML audio element -->
  <xsl:template match="*[contains(@class, ' topic/object ')][@outputclass = 'audio' or local-name() = 'audio']" priority="10">
    <audio controls="controls">
      <xsl:apply-templates select="*[contains(@class,' topic/param ')][not(@name='src')]"/>
      <xsl:call-template name="copySource"/>
    </audio>
  </xsl:template>
  
  <!-- Embedded iframe for object with specific output class or for video pointing to youtube website. -->
  <xsl:template match="*[contains(@class, ' topic/object ')][@outputclass = 'iframe' 
    or (local-name() = 'video') and contains(source/@value, 'www.youtube.com')]" priority="11">
    <iframe>
      <!-- The <video> element has a specific controls element which defines if controls should be present or not. -->
      <xsl:if test="not(local-name() = 'video') or controls">
        <xsl:attribute name="controls">controls</xsl:attribute>
      </xsl:if>
      <xsl:if test="@width">
        <xsl:attribute name="width" select="@width"/>
      </xsl:if>
      <xsl:if test="@height">
        <xsl:attribute name="height" select="@height"/>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="@data">
          <xsl:attribute name="src" select="@data"/>
        </xsl:when>
        <xsl:when test="source/@value">
          <xsl:attribute name="src" select="source/@value"/>
        </xsl:when>
      </xsl:choose>
      <xsl:if test="not(local-name() = 'video')">
        <!-- Generic XHTML object, set all params as attributes on the element. -->
        <xsl:apply-templates select="*[contains(@class,' topic/param ')]"/>
      </xsl:if>
    </iframe>
  </xsl:template>
  
  <!-- Convert all params to name, value attributes.  -->
  <xsl:template match="*[contains(@class, ' topic/object ')][@outputclass = 'video' or @outputclass = 'iframe' or @outputclass = 'audio']/*[contains(@class, ' topic/param ')]" priority="10">
    <xsl:attribute name="{@name}"><xsl:value-of select="@value"/></xsl:attribute>
  </xsl:template>    
</xsl:stylesheet>