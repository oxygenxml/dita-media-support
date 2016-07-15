<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">
    <!--Treat video, audio or iframe objects as links-->
    <xsl:template match="*[contains(@class,' topic/object ')][@outputclass = 'iframe' or @outputclass = 'audio' or @outputclass = 'video']">
        <fo:inline xsl:use-attribute-sets="object">
            <xsl:call-template name="commonattributes"/>
            <xsl:variable name="target">
                <xsl:if test="param[@name='src'] or @data">
                    <xsl:choose>
                        <xsl:when test="@data">
                            <xsl:value-of select="@data"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="param[@name='src']/@value"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:variable>
            <xsl:if test="exists($target)">
                <fo:basic-link external-destination="url({$target})" xsl:use-attribute-sets="xref">
                    <xsl:value-of select="$target"/>
                </fo:basic-link>
            </xsl:if>
        </fo:inline>
    </xsl:template>
</xsl:stylesheet>