<?xml version='1.0' encoding="UTF-8"?>

<!-- 
Copyright © 2004-2005 by Idiom Technologies, Inc. All rights reserved. 
IDIOM is a registered trademark of Idiom Technologies, Inc. and WORLDSERVER
and WORLDSTART are trademarks of Idiom Technologies, Inc. All other 
trademarks are the property of their respective owners. 

IDIOM TECHNOLOGIES, INC. IS DELIVERING THE SOFTWARE "AS IS," WITH 
ABSOLUTELY NO WARRANTIES WHATSOEVER, WHETHER EXPRESS OR IMPLIED,  AND IDIOM
TECHNOLOGIES, INC. DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING
BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
PURPOSE AND WARRANTY OF NON-INFRINGEMENT. IDIOM TECHNOLOGIES, INC. SHALL NOT
BE LIABLE FOR INDIRECT, INCIDENTAL, SPECIAL, COVER, PUNITIVE, EXEMPLARY,
RELIANCE, OR CONSEQUENTIAL DAMAGES (INCLUDING BUT NOT LIMITED TO LOSS OF 
ANTICIPATED PROFIT), ARISING FROM ANY CAUSE UNDER OR RELATED TO  OR ARISING 
OUT OF THE USE OF OR INABILITY TO USE THE SOFTWARE, EVEN IF IDIOM
TECHNOLOGIES, INC. HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. 

Idiom Technologies, Inc. and its licensors shall not be liable for any
damages suffered by any person as a result of using and/or modifying the
Software or its derivatives. In no event shall Idiom Technologies, Inc.'s
liability for any damages hereunder exceed the amounts received by Idiom
Technologies, Inc. as a result of this transaction.

These terms and conditions supersede the terms and conditions in any
licensing agreement to the extent that such terms and conditions conflict
with those set forth herein.

This file is part of the DITA Open Toolkit project hosted on Sourceforge.net. 
See the accompanying license.txt file for applicable licenses.
-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:opentopic-vars="http://www.idiominc.com/opentopic/vars"
	xmlns:exsl="http://exslt.org/common"
 	extension-element-prefixes="exsl"
	exclude-result-prefixes="opentopic-vars">

	<xsl:template name="insertVariable">
		<xsl:param name="theVariableID"/>
		<xsl:param name="theParameters"/>
		<!-- We use the default $locale, unless there's an xml:lang attribute that applies to the current element. -->
        <xsl:variable name="currentLocale">
            <xsl:choose>
                <xsl:when test="ancestor-or-self::*/@xml:lang">
                    <xsl:variable name="tempLang" select="ancestor-or-self::*[@xml:lang][1]/@xml:lang"/>
                    <xsl:value-of select="concat(
                        substring($tempLang,1,2),
                        translate(substring($tempLang,3),'abcdefghijklmnopqrstuvwxyz-','ABCDEFGHIJKLMNOPQRSTUVWXYZ_')         
                    )"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$locale"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
	  <xsl:variable name="currentLanguage">
	    <xsl:choose>
	      <xsl:when test="contains($currentLocale, '_')">
	        <xsl:value-of select="substring-before($currentLocale, '_')"/>
	      </xsl:when>
	      <xsl:otherwise>
	        <xsl:value-of select="$currentLocale"/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:variable>
	  <xsl:variable name="customization.locale" select="document(concat($customizationDir.url, 'common/vars/', $currentLocale, '.xml'))"/>
	  <xsl:variable name="customization.language" select="document(concat($customizationDir.url, 'common/vars/', $currentLanguage, '.xml'))"/>
	  <xsl:variable name="cfg.locale" select="document(concat('../../cfg/common/vars/', $currentLocale, '.xml'))"/>
	  <xsl:variable name="cfg.language" select="document(concat('../../cfg/common/vars/', $currentLanguage, '.xml'))"/>

	  <xsl:choose>
	    <xsl:when test="$customization.locale/opentopic-vars:vars/opentopic-vars:variable[@id = $theVariableID]">
	      <xsl:for-each select="$customization.locale/opentopic-vars:vars/opentopic-vars:variable[@id = $theVariableID][1]">
	        <xsl:call-template name="__processVariableBody">
	          <xsl:with-param name="theParameters" select="$theParameters"/>
	        </xsl:call-template>
	      </xsl:for-each>
	    </xsl:when>
	    <xsl:when test="$cfg.locale/opentopic-vars:vars/opentopic-vars:variable[@id = $theVariableID]">
	      <xsl:for-each select="$cfg.locale/opentopic-vars:vars/opentopic-vars:variable[@id = $theVariableID][1]">
	        <xsl:call-template name="__processVariableBody">
	          <xsl:with-param name="theParameters" select="$theParameters"/>
	        </xsl:call-template>
	      </xsl:for-each>
	    </xsl:when>
	    <xsl:when test="$customization.language/opentopic-vars:vars/opentopic-vars:variable[@id = $theVariableID]">
	      <xsl:for-each select="$customization.language/opentopic-vars:vars/opentopic-vars:variable[@id = $theVariableID][1]">
	        <xsl:call-template name="__processVariableBody">
	          <xsl:with-param name="theParameters" select="$theParameters"/>
	        </xsl:call-template>
	      </xsl:for-each>
	    </xsl:when>
	    <xsl:when test="$cfg.language/opentopic-vars:vars/opentopic-vars:variable[@id = $theVariableID]">
	      <xsl:for-each select="$cfg.language/opentopic-vars:vars/opentopic-vars:variable[@id = $theVariableID][1]">
	        <xsl:call-template name="__processVariableBody">
	          <xsl:with-param name="theParameters" select="$theParameters"/>
	        </xsl:call-template>
	      </xsl:for-each>
	    </xsl:when>
	  </xsl:choose>
	</xsl:template>

	<xsl:template name="__processVariableBody">
		<xsl:param name="theParameters"/>
		<!--
			Inserting variable with given id
		-->
		<xsl:for-each select="node()">
			<xsl:choose>
			  <xsl:when test="self::opentopic-vars:param">
					<!--Processing parametrized variable-->
					<xsl:variable name="param-name" select="@ref-name"/>
					<!--Copying parameter child as is-->
					<xsl:copy-of select="exsl:node-set($theParameters/*[name() = $param-name]/node())"/>
				</xsl:when>
			  <xsl:when test="self::opentopic-vars:variable">
          <xsl:call-template name="insertVariable">
            <xsl:with-param name="theVariableID" select="@id"/>
            <xsl:with-param name="theParameters" select="$theParameters"/>
          </xsl:call-template>
        </xsl:when>
				<xsl:otherwise>
					<!--Using default template-->
					<xsl:apply-templates select="." mode="default"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
  
  <xsl:template match="@* | node()" mode="default">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="default"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>