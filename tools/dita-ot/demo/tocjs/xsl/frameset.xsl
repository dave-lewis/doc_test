<?xml version="1.0"?>
<!-- 
  This file is part of the DITA Open Toolkit project hosted on
  Sourceforge.net. See the accompanying license.txt file for
  applicable licenses.

  Copyright Shawn McKenzie, 2007. All Rights Reserved.

  Created by Robert Anderson August 2011, based on the sample
  frameset distributed with the original samples. Minor udpates:
  - Grab title of the map as the title
  - Update contentwin to use the first topic

  This is intended to create an initial, sample frameset when
  one is not already provided. Long term, users may wish to create
  a stable frameset using local styles and organization.
  -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output encoding="UTF-8"/>

  <xsl:param name="CSSPATH"/>
  <xsl:param name="OUTEXT" select="'.html'"/>
  <xsl:param name="DITAEXT" select="'.xml'"/>

  <xsl:variable name="firsttopic">
    <xsl:choose>
      <xsl:when test="/*/*[contains(@class, ' map/topicref ')][1]/descendant-or-self::*[@href][not(@processing-role='resource-only')]">
        <xsl:value-of select="/*/*[contains(@class, ' map/topicref ')][1]/descendant-or-self::*[@href][not(@processing-role='resource-only')][1]/@href"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="/*/descendant-or-self::*[@href][not(@processing-role='resource-only')][1]/@href"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="firsttopicAsHtml">
    <xsl:choose>
      <xsl:when test="contains($firsttopic,$DITAEXT)">
        <xsl:value-of select="substring-before($firsttopic,$DITAEXT)"/>
        <xsl:value-of select="$OUTEXT"/>
        <xsl:if test="starts-with(substring-after($firsttopic,$DITAEXT),'#')">
          <xsl:value-of select="substring-after($firsttopic,$DITAEXT)"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$firsttopic"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:choose>
            <xsl:when test="/*/*[contains(@class,' topic/title ')]">
              <xsl:value-of select="normalize-space(/*/*[contains(@class,' topic/title ')])"/>
            </xsl:when>
            <xsl:when test="@title">
              <xsl:value-of select="normalize-space(@title)"/>
            </xsl:when>
          </xsl:choose>
        </title>
        <xsl:choose>
          <xsl:when test="$CSSPATH!=''">
            <link rel="stylesheet" type="text/css" href="concat($CSSPATH,'commonltr.css')"/>
          </xsl:when>
          <xsl:otherwise>
            <link rel="stylesheet" type="text/css" href="commonltr.css"/>
          </xsl:otherwise>
        </xsl:choose>
      </head>
      <frameset cols="30%,*">
        <frame name="tocwin" src="tocnav.html"/>
        <frame name="contentwin" src="{$firsttopicAsHtml}"/>
      </frameset>
    </html>
  </xsl:template>

</xsl:stylesheet>
