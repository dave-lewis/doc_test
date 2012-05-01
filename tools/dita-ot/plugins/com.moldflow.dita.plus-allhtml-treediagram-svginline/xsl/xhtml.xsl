<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svginline="http://www.moldflow.com/namespace/2008/allhtml-treediagram-svginline" xmlns:treediagram2svg="http://www.moldflow.com/namespace/2008/treediagram2svg" exclude-result-prefixes="svginline treediagram2svg">

    
<xsl:import href="../../com.moldflow.dita.treediagram2svg/xsl/treediagram2svg.xsl"/>

    <xsl:param name="plus-treediagram-format" select="'svginline'"></xsl:param>
    <xsl:param name="plus-allhtml-treediagram-svginline-csspath" select="''"></xsl:param>
    <xsl:param name="plus-allhtml-treediagram-svginline-jspath" select="''"></xsl:param>

    
    <xsl:template match="/ | node()" mode="gen-user-scripts">
        <xsl:if test="$plus-treediagram-format = 'svginline' and //*[contains(@class, ' tree-d/tree ')]">
            <xsl:call-template name="svginline:gen-user-scripts"></xsl:call-template>
        </xsl:if>
        <xsl:next-match>
            <xsl:fallback>
                <xsl:message terminate="no">
                  <xsl:text>svginline: cannot fall back in XSLT 1.0.</xsl:text>
                </xsl:message>
            </xsl:fallback>
        </xsl:next-match>
    </xsl:template>

    <xsl:template name="svginline:gen-user-scripts">
      <xsl:call-template name="treediagram2svg:gen-user-scripts">
        <xsl:with-param name="JSPATH" select="concat($PATH2PROJ, $plus-allhtml-treediagram-svginline-jspath)"></xsl:with-param>
      </xsl:call-template>
    </xsl:template>

    
    <xsl:template match="/ | node()" mode="gen-user-styles">
        <xsl:if test="$plus-treediagram-format = 'svginline' and //*[contains(@class, ' tree-d/tree ')]">
            <xsl:call-template name="svginline:gen-user-styles"></xsl:call-template>
        </xsl:if>
        <xsl:next-match>
            <xsl:fallback>
                <xsl:message terminate="no">
                  <xsl:text>svginline: cannot fall back in XSLT 1.0.</xsl:text>
                </xsl:message>
            </xsl:fallback>
        </xsl:next-match>
    </xsl:template>

    
    <xsl:template name="svginline:gen-user-styles">
        <xsl:variable name="urltest">
            
            <xsl:call-template name="url-string">
                <xsl:with-param name="urltext" select="$plus-allhtml-treediagram-svginline-csspath"></xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <link>
            <xsl:attribute name="rel">stylesheet</xsl:attribute>
            <xsl:attribute name="type">text/css</xsl:attribute>
            <xsl:attribute name="href">
                <xsl:if test="not($urltest='url')">
                    <xsl:value-of select="$PATH2PROJ"></xsl:value-of>
                </xsl:if>
                <xsl:value-of select="$plus-allhtml-treediagram-svginline-csspath"></xsl:value-of>
                <xsl:value-of select="$treediagram2svg:css-filename"></xsl:value-of>
            </xsl:attribute>
        </link>
    </xsl:template>

    
    <xsl:template match="*[contains(@class, ' tree-d/tree ')]">
        <xsl:choose>
          <xsl:when test="$plus-treediagram-format = 'svginline'">
            <xsl:apply-templates select="." mode="svginline:default"></xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:next-match>
              <xsl:fallback>
                <xsl:message terminate="no">
                  <xsl:text>svginline: cannot fall back in XSLT 1.0.</xsl:text>
                </xsl:message>
              </xsl:fallback>
            </xsl:next-match>
          </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    
    <xsl:template match="*[contains(@class, ' tree-d/tree ')]" mode="svginline:default">
        <div>
            <xsl:attribute name="class">treediagram</xsl:attribute>
            <xsl:call-template name="commonattributes"></xsl:call-template>
            <xsl:call-template name="setidaname"></xsl:call-template>
            <xsl:call-template name="flagcheck"></xsl:call-template>
            
            <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="svginline:default"></xsl:apply-templates>
            
            <xsl:call-template name="treediagram2svg:create-svg-element"></xsl:call-template>
        </div>
    </xsl:template>

    
    <xsl:template match="*[contains(@class, ' tree-d/tree ')]/*[contains(@class, ' topic/title ')]" mode="svginline:default">
        <div>
            <xsl:attribute name="class">treediagram-title</xsl:attribute>
            <xsl:call-template name="commonattributes"></xsl:call-template>
            <xsl:call-template name="setidaname"></xsl:call-template>
            <xsl:call-template name="flagcheck"></xsl:call-template>
            <xsl:apply-templates></xsl:apply-templates>
        </div>
    </xsl:template>

</xsl:stylesheet>