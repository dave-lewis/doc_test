<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svginline="http://www.moldflow.com/namespace/2008/plus-allhtml-syntaxdiagram-svginline" xmlns:syntaxdiagram2svg="http://www.moldflow.com/namespace/2008/syntaxdiagram2svg" exclude-result-prefixes="svginline syntaxdiagram2svg">

    
<xsl:import href="../../com.moldflow.dita.syntaxdiagram2svg/xsl/syntaxdiagram2svg.xsl"/>

    <xsl:param name="plus-syntaxdiagram-format" select="'svginline'"></xsl:param>
    <xsl:param name="plus-allhtml-syntaxdiagram-svginline-csspath" select="''"></xsl:param>
    <xsl:param name="plus-allhtml-syntaxdiagram-svginline-jspath" select="''"></xsl:param>

    
    <xsl:template match="/ | node()" mode="gen-user-scripts">
        <xsl:if test="$plus-syntaxdiagram-format = 'svginline' and //*[contains(@class, ' pr-d/syntaxdiagram ')]">
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
      <xsl:call-template name="syntaxdiagram2svg:gen-user-scripts">
        <xsl:with-param name="JSPATH" select="concat($PATH2PROJ, $plus-allhtml-syntaxdiagram-svginline-jspath)"></xsl:with-param>
      </xsl:call-template>
    </xsl:template>

    
    <xsl:template match="/ | node()" mode="gen-user-styles">
        <xsl:if test="$plus-syntaxdiagram-format = 'svginline' and //*[contains(@class, ' pr-d/syntaxdiagram ')]">
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
                <xsl:with-param name="urltext" select="$plus-allhtml-syntaxdiagram-svginline-csspath"></xsl:with-param>
            </xsl:call-template>
        </xsl:variable>

        <link>
            <xsl:attribute name="rel">stylesheet</xsl:attribute>
            <xsl:attribute name="type">text/css</xsl:attribute>
            <xsl:attribute name="href">
                <xsl:if test="not($urltest='url')">
                    <xsl:value-of select="$PATH2PROJ"></xsl:value-of>
                </xsl:if>
                <xsl:value-of select="$plus-allhtml-syntaxdiagram-svginline-csspath"></xsl:value-of>
                <xsl:value-of select="$syntaxdiagram2svg:css-filename"></xsl:value-of>
            </xsl:attribute>
        </link>
    </xsl:template>

    
    <xsl:template match="*[contains(@class, ' pr-d/syntaxdiagram ')]">
        <xsl:choose>
          <xsl:when test="$plus-syntaxdiagram-format = 'svginline'">
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

    
    <xsl:template match="*[contains(@class, ' pr-d/syntaxdiagram ')]" mode="svginline:default">
        <div>
            <xsl:attribute name="class">syntaxdiagram</xsl:attribute>
            <xsl:call-template name="commonattributes"></xsl:call-template>
            <xsl:call-template name="setidaname"></xsl:call-template>
            <xsl:call-template name="flagcheck"></xsl:call-template>
            <xsl:call-template name="svginline:process-children"></xsl:call-template>
        </div>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' pr-d/synblk ')]" mode="svginline:default">
        <div>
            <xsl:attribute name="class">synblk</xsl:attribute>
            <xsl:call-template name="commonattributes"></xsl:call-template>
            <xsl:call-template name="setidaname"></xsl:call-template>
            <xsl:call-template name="flagcheck"></xsl:call-template>
            <xsl:call-template name="svginline:process-children"></xsl:call-template>
        </div>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' pr-d/fragment ')]" mode="svginline:default">
        <div>
            <xsl:attribute name="class">fragment</xsl:attribute>
            <xsl:call-template name="commonattributes"></xsl:call-template>
            <xsl:call-template name="setidaname"></xsl:call-template>
            <xsl:call-template name="flagcheck"></xsl:call-template>
            <xsl:call-template name="svginline:process-children"></xsl:call-template>
        </div>
    </xsl:template>

    
    <xsl:template name="svginline:process-children">
        <xsl:for-each select="*">
            <xsl:choose>
                <xsl:when test="contains(@class, ' topic/title ')                     or contains(@class, ' pr-d/syntaxdiagram ')                     or contains(@class, ' pr-d/synblk ')                     or contains(@class, ' pr-d/fragment ')">
                    
                    <xsl:apply-templates select="." mode="svginline:default"></xsl:apply-templates>
                </xsl:when>
                <xsl:when test="count(preceding-sibling::*) = 0 or                     preceding-sibling::*[1][                     contains(@class, ' topic/title ')                     or contains(@class, ' pr-d/syntaxdiagram ')                     or contains(@class, ' pr-d/synblk ')                     or contains(@class, ' pr-d/fragment ')]">
                    
                    <div>
                        <xsl:attribute name="class">syntaxdiagram-piece</xsl:attribute>
                        <xsl:call-template name="syntaxdiagram2svg:create-svg-element"></xsl:call-template>
                    </div>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    
    <xsl:template match="*[contains(@class, ' pr-d/syntaxdiagram ')]/*[contains(@class, ' topic/title ')]" mode="svginline:default">
        <div>
            <xsl:attribute name="class">syntaxdiagram-title</xsl:attribute>
            <xsl:call-template name="commonattributes"></xsl:call-template>
            <xsl:call-template name="setidaname"></xsl:call-template>
            <xsl:call-template name="flagcheck"></xsl:call-template>
            <xsl:apply-templates></xsl:apply-templates>
        </div>
    </xsl:template>

    
    <xsl:template match="*[contains(@class, ' pr-d/synblk ')]/*[contains(@class, ' topic/title ')]" mode="svginline:default">
        <div>
            <xsl:attribute name="class">synblk-title</xsl:attribute>
            <xsl:call-template name="commonattributes"></xsl:call-template>
            <xsl:call-template name="setidaname"></xsl:call-template>
            <xsl:call-template name="flagcheck"></xsl:call-template>
            <xsl:apply-templates></xsl:apply-templates>
        </div>
    </xsl:template>

    
    <xsl:template match="*[contains(@class, ' pr-d/fragment ')]/*[contains(@class, ' topic/title ')]" mode="svginline:default">
        <div>
            <xsl:attribute name="class">fragment-title</xsl:attribute>
            <xsl:call-template name="commonattributes"></xsl:call-template>
            <xsl:call-template name="setidaname"></xsl:call-template>
            <xsl:call-template name="flagcheck"></xsl:call-template>
            <xsl:apply-templates></xsl:apply-templates>
        </div>
    </xsl:template>

    
    <xsl:template match="*[contains(@class, ' pr-d/fragref ')]" mode="syntaxdiagram2svg:body-only">
        <xsl:param name="role" select="'forward'"></xsl:param>
        <svg:a syntaxdiagram2svg:dispatch="boxed">
            <xsl:attribute name="class">
                <xsl:text>boxed </xsl:text>
                <xsl:value-of select="local-name()"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="syntaxdiagram2svg:element">
                <xsl:value-of select="local-name()"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="syntaxdiagram2svg:role">
                <xsl:value-of select="$role"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="xlink:href">
                <xsl:call-template name="href"></xsl:call-template>
            </xsl:attribute>
            <xsl:call-template name="syntaxdiagram2svg:box-contents"></xsl:call-template>
        </svg:a>
    </xsl:template>

    
    <xsl:template match="*[contains(@class, ' pr-d/fragref ')]" mode="syntaxdiagram2svg:groupcomp-child">
        <xsl:param name="role" select="'forward'"></xsl:param>
        <svg:a syntaxdiagram2svg:dispatch="unboxed" syntaxdiagram2svg:role="forward">
            <xsl:attribute name="class">
                <xsl:text>unboxed </xsl:text>
                <xsl:value-of select="local-name()"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="syntaxdiagram2svg:element">
                <xsl:value-of select="local-name()"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="syntaxdiagram2svg:role">
                <xsl:value-of select="$role"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="xlink:href">
                <xsl:call-template name="href"></xsl:call-template>
            </xsl:attribute>
            <xsl:call-template name="syntaxdiagram2svg:box-contents"></xsl:call-template>
        </svg:a>
    </xsl:template>

    
    <xsl:template match="*[contains(@class, ' pr-d/synnote ')][not(@id)]" mode="syntaxdiagram2svg:note">
        <svg:a syntaxdiagram2svg:dispatch="note" class="note">
            <xsl:attribute name="xlink:href">
                <xsl:call-template name="svginline:get-footnote-target"></xsl:call-template>
            </xsl:attribute>
            <svg:text>
                <xsl:call-template name="syntaxdiagram2svg:get-callout"></xsl:call-template>
            </svg:text>
        </svg:a>
    </xsl:template>

    
    <xsl:template match="*[contains(@class, ' pr-d/synnote ')][not(@id)]" mode="syntaxdiagram2svg:groupcomp-child">
        <svg:a syntaxdiagram2svg:dispatch="note" class="note">
            <xsl:attribute name="xlink:href">
                <xsl:call-template name="svginline:get-footnote-target"></xsl:call-template>
            </xsl:attribute>
            <svg:text>
                <xsl:call-template name="syntaxdiagram2svg:get-callout"></xsl:call-template>
            </svg:text>
        </svg:a>
    </xsl:template>

    <xsl:template name="svginline:get-footnote-target">
        <xsl:text>#fntarg_</xsl:text>
        <xsl:number format="1" count="*[contains(@class, ' topic/fn ')]" from="/*" level="any"></xsl:number>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' pr-d/synnoteref ')][@href and @href != '']" mode="syntaxdiagram2svg:note">
        <svg:a syntaxdiagram2svg:dispatch="note" class="note">
            <xsl:attribute name="xlink:href">
                <xsl:call-template name="svginline:get-footnote-reference-target"></xsl:call-template>
            </xsl:attribute>
            <svg:text>
                <xsl:call-template name="syntaxdiagram2svg:get-callout-reference"></xsl:call-template>
            </svg:text>
        </svg:a>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' pr-d/synnoteref ')][@href and @href != '']" mode="syntaxdiagram2svg:groupcomp-child">
        <svg:a syntaxdiagram2svg:dispatch="note" class="note">
            <xsl:attribute name="xlink:href">
                <xsl:call-template name="svginline:get-footnote-reference-target"></xsl:call-template>
            </xsl:attribute>
            <svg:text>
                <xsl:call-template name="syntaxdiagram2svg:get-callout-reference"></xsl:call-template>
            </svg:text>
        </svg:a>
    </xsl:template>

    <xsl:template name="svginline:get-footnote-reference-target">
        
        <xsl:choose>
            <xsl:when test="contains(@href, '#')">
                <xsl:variable name="document" select="substring-before(@href, '#')"></xsl:variable>
                <xsl:choose>
                    <xsl:when test="contains(substring-after(@href, '#'), '/')">
                        <xsl:variable name="topicid" select="substring-before(substring-after(@href, '#'), '/')"></xsl:variable>
                        <xsl:variable name="targetid" select="substring-after(substring-after(@href, '#'), '/')"></xsl:variable>
                        <xsl:value-of select="concat('#', $topicid, '__', $targetid)"></xsl:value-of>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message>synnoteref points at entire topic.</xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>synnoteref href points at entire file.</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>