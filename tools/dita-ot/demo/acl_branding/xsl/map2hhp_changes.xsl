<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                xmlns:saxon="http://icl.com/saxon"
                xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
                xmlns:exsl="http://exslt.org/common"
                xmlns:java="org.dita.dost.util.StringUtils"
                extension-element-prefixes="saxon xalanredirect exsl">

<xsl:template name="setup-options">
<xsl:param name="target-language">
  <xsl:choose>
    <xsl:when test="/*[contains(@class, ' map/map ')]/@xml:lang">
      <xsl:value-of select="concat(translate(/*[contains(@class, ' map/map ')]/@xml:lang,$lang-translate-uppercase,$lang-translate-lowercase), '-')"/>
    </xsl:when>
    <xsl:when test="document((//*[contains(@class, ' map/topicref ')][@href and @href != '' and not(contains(@href,'://'))][not(@format) or @format='dita' or @format='DITA'][not(@scope) or @scope='local'])[1]/@href, /)//*[contains(@class, ' topic/topic ')][1]/@xml:lang">
      <xsl:value-of select="concat(translate(document((//*[contains(@class, ' map/topicref ')][@href and @href != ''and not(contains(@href,'://'))][not(@format) or @format='dita' or @format='DITA'][not(@scope) or @scope='local'])[1]/@href, /)//*[contains(@class, ' topic/topic ')][1]/@xml:lang,$lang-translate-uppercase,$lang-translate-lowercase), '-')"/>
    </xsl:when>
    <xsl:otherwise>en-us</xsl:otherwise>
  </xsl:choose>
</xsl:param>

<xsl:text>[OPTIONS]</xsl:text>
<xsl:value-of select="$newline"/>
<xsl:text>Compiled file=</xsl:text><xsl:value-of select="substring-before($HHCNAME,'.hhc')"/><xsl:text>.chm</xsl:text>
<xsl:if test="/*[contains(@class, ' map/map ')]">   <!-- Only reference HHC if there is valid navigation -->
  <xsl:value-of select="$newline"/>
  <xsl:text>Contents file=</xsl:text><xsl:value-of select="$HHCNAME"/><xsl:text>
</xsl:text>
</xsl:if>
<xsl:value-of select="$newline"/>
<xsl:text>Default Window=default</xsl:text>
<xsl:value-of select="$newline"/>
<xsl:text>Full-text search=Yes</xsl:text>
<xsl:value-of select="$newline"/>
<xsl:text>Display compile progress=No</xsl:text>
<xsl:if test="$USEINDEX='yes'">
<xsl:value-of select="$newline"/>
<xsl:text>Index file=</xsl:text><xsl:value-of select="substring-before($HHCNAME,'.hhc')"/><xsl:text>.hhk
Binary Index=Yes</xsl:text>
</xsl:if>
<xsl:text>Language=</xsl:text>
<xsl:choose>
  <xsl:when test="starts-with($target-language, 'ar-')"><xsl:text>0x0c01 Arabic (EGYPT)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'be-')"><xsl:text>0x0423 Byelorussian</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'bg-')"><xsl:text>0x0402 Bulgarian</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'ca-')"><xsl:text>0x0403 Catalan</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'cs-')"><xsl:text>0x0405 Czech</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'da-')"><xsl:text>0x0406 Danish</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'de-ch-')"><xsl:text>0x0807 German (SWITZERLAND)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'de-')"><xsl:text>0x0407 German (GERMANY)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'el-')"><xsl:text>0x0408 Greek</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'en-gb-')"><xsl:text>0x0809 English (UNITED KINGDOM)</xsl:text></xsl:when>
  <!-- en-uk seems to be a common misspelling of en-gb. -->
  <xsl:when test="starts-with($target-language, 'en-uk-')"><xsl:text>0x0809 English (UNITED KINGDOM)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'en-us-')"><xsl:text>0x0409 English (United States)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'en-')"><xsl:text>0x0409 English (United States)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'es-')"><xsl:text>0x040a Spanish (Spain)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'et-')"><xsl:text>0x0425 Estonian</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'fi-')"><xsl:text>0x040b Finnish</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'fr-be-')"><xsl:text>0x080c French (BELGIUM)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'fr-ca-')"><xsl:text>0x0c0c French (CANADA)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'fr-ch-')"><xsl:text>0x100c French (SWITZERLAND)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'fr-')"><xsl:text>0x040c French (FRANCE)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'he-')"><xsl:text>0x040d Hebrew</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'hr-')"><xsl:text>0x041a Croatian</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'hu-')"><xsl:text>0x040e Hungarian</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'is-')"><xsl:text>0x040f Icelandic</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'it-ch-')"><xsl:text>0x0810 Italian (SWITZERLAND)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'it-')"><xsl:text>0x0410 Italian (ITALY)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'ja-')"><xsl:text>0x0411 Japanese</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'ko-')"><xsl:text>0x0412 Korean</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'lt-')"><xsl:text>0x0427 Lithuanian</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'lv-')"><xsl:text>0x0426 Latvian (Lettish)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'mk-')"><xsl:text>0x042f Macedonian</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'nl-be-')"><xsl:text>0x0813 Dutch (Belgium)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'nl-')"><xsl:text>0x0413 Dutch (Netherlands)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'no-')"><xsl:text>0x0414 Norwegian (Bokmal)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'pl-')"><xsl:text>0x0415 Polish</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'pt-br-')"><xsl:text>0x0416 Portuguese (BRAZIL)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'pt-pt-')"><xsl:text>0x0816 Portuguese (PORTUGAL)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'pt-')"><xsl:text>0x0416 Portuguese (BRAZIL)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'ro-')"><xsl:text>0x0418 Romanian</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'ru-')"><xsl:text>0x0419 Russian</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'sk-')"><xsl:text>0x041b Slovak</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'sl-')"><xsl:text>0x0424 Slovenian</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'sr-cyrl-')"><xsl:text>0x0c1a Serbian (Cyrillic)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'sr-latn-')"><xsl:text>0x081a Serbian (Latin)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'sr-')"><xsl:text>0x0c1a Serbian (Cyrillic)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'sv-')"><xsl:text>0x041d Swedish</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'th-')"><xsl:text>0x041e Thai</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'tr-')"><xsl:text>0x041f Turkish</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'uk-')"><xsl:text>0x0422 Ukrainian</xsl:text></xsl:when>
  <!-- Use common assumptions about Chinese. -->
  <xsl:when test="starts-with($target-language, 'zh-cn-')"><xsl:text>0x0804 Chinese (CHINA)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'zh-hans-')"><xsl:text>0x0804 Chinese (CHINA)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'zh-tw-')"><xsl:text>0x0404 Chinese (TAIWAN, PROVINCE OF CHINA)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'zh-hant-')"><xsl:text>0x0404 Chinese (TAIWAN, PROVINCE OF CHINA)</xsl:text></xsl:when>
  <xsl:when test="starts-with($target-language, 'zh-')"><xsl:text>0x0804 Chinese (CHINA)</xsl:text></xsl:when>
  <!-- DITA standard says untagged language is English. -->
  <xsl:otherwise><xsl:text>0x409 English (United States)</xsl:text></xsl:otherwise>
</xsl:choose>
<xsl:text>
Default topic=</xsl:text>
<!-- in a single map, get the first valid topic -->
<xsl:text/>
<xsl:apply-templates select="descendant::*[contains(@class, ' map/topicref ')][not(@processing-role='resource-only')][@href][contains(@href,$DITAEXT) or contains(@href,'.htm')][not(contains(@toc,'no'))][not(@processing-role='resource-only')][1]" mode="defaulttopic"/>
<xsl:text/>

<!-- Get the title, if possible -->
<!-- Using a single map, so get the title from that map -->
<xsl:choose>
  <xsl:when test="/*[contains(@class, ' bookmap/bookmap ')]/*[contains(@class, ' bookmap/booktitle ')]/*[contains(@class,' bookmap/mainbooktitle ')]">
    <xsl:text>Title=</xsl:text><xsl:value-of select="/*[contains(@class, ' bookmap/bookmap ')]/*[contains(@class, ' bookmap/booktitle ')]/*[contains(@class,' bookmap/mainbooktitle ')]"/>
  </xsl:when>
  <xsl:when test="/*[contains(@class, ' map/map ')]/*[contains(@class, ' topic/title ')]">
    <xsl:text>Title=</xsl:text><xsl:value-of select="/*[contains(@class, ' map/map ')]/*[contains(@class, ' topic/title ')]"/>
  </xsl:when>
  <xsl:when test="/*[contains(@class, ' map/map ')]/@title">
    <xsl:text>Title=</xsl:text><xsl:value-of select="/*[contains(@class, ' map/map ')]/@title"/>
  </xsl:when>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>
