<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xalan="http://xml.apache.org/xalan"
  xmlns:exsl="http://exslt.org/common"
  xmlns:topicpull="http://dita-ot.sourceforge.net/ns/200704/topicpull"
  xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
  exclude-result-prefixes="topicpull ditamsg xalan exsl">
 
  <xsl:template match="*" mode="topicpull:getlinktext_within-topic">
    <xsl:param name="file">#none#</xsl:param>
    <xsl:param name="topicpos">#none#</xsl:param>
    <xsl:param name="classval">#none#</xsl:param>
    <xsl:param name="topicid">#none#</xsl:param>
    <xsl:param name="elemid">#none#</xsl:param>
    <xsl:variable name="useclassval">
      <xsl:choose>
        <!--if it's a known type we can handle, use type as-is-->
        <xsl:when test="      $classval='/li '    or $classval='/fn '    or $classval='/dlentry '    or $classval='/section '   or $classval='/example '   or $classval='/fig '   or $classval='/figgroup '">
          <!--can be handled as-is-->
          <xsl:value-of select="$classval"/>
        </xsl:when>
        <!--otherwise figure out what it's topic-level equivalent is by looking it up in the target element's class value-->
        <xsl:when test="$topicpos='samefile'">
          <xsl:apply-templates select="//*[contains(@class, ' topic/topic ')][@id=$topicid]/*[contains(@class,' topic/body ') or contains(@class,' topic/abstract ')]//*[contains(@class, $classval)][@id=$elemid]" mode="topicpull:determine_firstclass"/>
        </xsl:when>
        <xsl:when test="$topicpos='otherfile'">
          <xsl:apply-templates select="document($file,/)//*[contains(@class, ' topic/topic ')][@id=$topicid]/*[contains(@class,' topic/body ') or contains(@class,' topic/abstract ')]//*[contains(@class, $classval)][@id=$elemid]" mode="topicpull:determine_firstclass"/>
        </xsl:when>
        <xsl:otherwise>
          <!--don't generate error msg, since will also be attempting retrieval of linktext, and don't want to double-up on error msgs-->
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <!--processing as a list item - this call only happens when the type is not defined locally or was unknown, but was retrieved from the target; when a known type is defined locally, the appropriate template is applied directly-->
      <xsl:when test="@type='li' or $useclassval='/li '">
        <xsl:apply-templates select="." mode="topicpull:getlinktext_within-topic_li">
          <xsl:with-param name="file"><xsl:value-of select="$file"/></xsl:with-param>
          <xsl:with-param name="topicpos"><xsl:value-of select="$topicpos"/></xsl:with-param>
          <xsl:with-param name="classval"><xsl:value-of select="$useclassval"/></xsl:with-param>
          <xsl:with-param name="topicid"><xsl:value-of select="$topicid"/></xsl:with-param>
          <xsl:with-param name="elemid"><xsl:value-of select="$elemid"/></xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>
      <!--processing as a footnote - this call only happens when the type is not defined locally or was unknown, but was retrieved from the target; when a known type is defined locally, the appropriate template is applied directly-->
      <xsl:when test="@type='fn' or $useclassval='/fn '">
        <xsl:apply-templates select="." mode="topicpull:getlinktext_within-topic_fn">
          <xsl:with-param name="file"><xsl:value-of select="$file"/></xsl:with-param>
          <xsl:with-param name="topicpos"><xsl:value-of select="$topicpos"/></xsl:with-param>
          <xsl:with-param name="classval"><xsl:value-of select="$useclassval"/></xsl:with-param>
          <xsl:with-param name="topicid"><xsl:value-of select="$topicid"/></xsl:with-param>
          <xsl:with-param name="elemid"><xsl:value-of select="$elemid"/></xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>
      <!--processing as a dlentry - this call only happens when the type is not defined locally or was unknown, but was retrieved from the target; when a known type is defined locally, the appropriate template is applied directly-->
      <xsl:when test="@type='dlentry' or $useclassval='/dlentry '">
        <xsl:apply-templates select="." mode="topicpull:getlinktext_within-topic_dlentry">
          <xsl:with-param name="file"><xsl:value-of select="$file"/></xsl:with-param>
          <xsl:with-param name="topicpos"><xsl:value-of select="$topicpos"/></xsl:with-param>
          <xsl:with-param name="classval"><xsl:value-of select="$useclassval"/></xsl:with-param>
          <xsl:with-param name="topicid"><xsl:value-of select="$topicid"/></xsl:with-param>
          <xsl:with-param name="elemid"><xsl:value-of select="$elemid"/></xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>
      <!--processing as a table - this call only happens when the type is not defined locally or was unknown, but was retrieved from the target; when a known type is defined locally, the appropriate template is applied directly-->
      <xsl:when test="@type='table' or @type='fm:Table' or $useclassval='/table '">
        <xsl:apply-templates select="." mode="topicpull:getlinktext_within-topic_table">
          <xsl:with-param name="file"><xsl:value-of select="$file"/></xsl:with-param>
          <xsl:with-param name="topicpos"><xsl:value-of select="$topicpos"/></xsl:with-param>
          <xsl:with-param name="classval"><xsl:value-of select="$useclassval"/></xsl:with-param>
          <xsl:with-param name="topicid"><xsl:value-of select="$topicid"/></xsl:with-param>
          <xsl:with-param name="elemid"><xsl:value-of select="$elemid"/></xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>
      <!--processing as a figure - this call only happens when the type is not defined locally or was unknown, but was retrieved from the target; when a known type is defined locally, the appropriate template is applied directly-->
      <xsl:when test="@type='fig' or @type='fm:Figure' or $useclassval='/fig '">
        <xsl:apply-templates select="." mode="topicpull:getlinktext_within-topic_fig">
          <xsl:with-param name="file"><xsl:value-of select="$file"/></xsl:with-param>
          <xsl:with-param name="topicpos"><xsl:value-of select="$topicpos"/></xsl:with-param>
          <xsl:with-param name="classval"><xsl:value-of select="$useclassval"/></xsl:with-param>
          <xsl:with-param name="topicid"><xsl:value-of select="$topicid"/></xsl:with-param>
          <xsl:with-param name="elemid"><xsl:value-of select="$elemid"/></xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>
      <!--if it's none of the above types, then apply generic processing - for table, fig, etc. - looking for a child title element-->
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="topicpull:getlinktext_within-topic_otherblock">
          <xsl:with-param name="file"><xsl:value-of select="$file"/></xsl:with-param>
          <xsl:with-param name="topicpos"><xsl:value-of select="$topicpos"/></xsl:with-param>
          <xsl:with-param name="classval"><xsl:value-of select="$useclassval"/></xsl:with-param>
          <xsl:with-param name="topicid"><xsl:value-of select="$topicid"/></xsl:with-param>
          <xsl:with-param name="elemid"><xsl:value-of select="$elemid"/></xsl:with-param>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet> 