<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- the year for the copyright -->
  <xsl:param name="YEAR" select="'2012'"/>
  <xsl:param name="INCLUDEGOOGLEJS" select="'yes'" />
  
  <!-- If there is no copyright in the document, make the standard one -->
  <xsl:template name="generateDefaultCopyright">
    <xsl:if test="not(//*[contains(@class,' topic/copyright ')])">
      <meta name="copyright">
        <xsl:attribute name="content">
          <xsl:text>(C) </xsl:text>
          <xsl:call-template name="getString">
            <xsl:with-param name="stringName" select="'Copyright'"/>
          </xsl:call-template>
          <xsl:text> ACL Services Ltd. </xsl:text><xsl:value-of select="$YEAR"/>
        </xsl:attribute>
      </meta>
      <xsl:value-of select="$newline"/>
      <meta name="DC.rights.owner">
        <xsl:attribute name="content">
          <xsl:text>(C) </xsl:text>
          <xsl:call-template name="getString">
            <xsl:with-param name="stringName" select="'Copyright'"/>
          </xsl:call-template>
          <xsl:text> ACL Services Ltd. </xsl:text><xsl:value-of select="$YEAR"/>
        </xsl:attribute>
      </meta>
      <xsl:value-of select="$newline"/>
    </xsl:if>
  </xsl:template>
  <!--  OLD VERSION
  <xsl:template match="/|node()|@*" mode="gen-user-header">
    <div id="HTMLPageHeader">
      <h1 class="HeaderImage"><xsl:text> </xsl:text></h1>
	  <hr class="HTMLPageHeaderHR" />
    </div>
  </xsl:template>
  -->
    <xsl:template match="/|node()|@*" mode="gen-user-header">
    <div id="headerImage">
      <h1><xsl:text> </xsl:text></h1>
    </div>
	<div id="headerLine">
		<hr/>
	</div>
  </xsl:template>
  
  <xsl:template match="/|node()|@*" mode="gen-user-footer">
    <br />
    <hr class="HTMLPageFooterHR" />
    <p class="HTMLPageFooter">
		<xsl:text>(C) </xsl:text>
		<xsl:value-of select="$YEAR"/>
		<xsl:text> ACL Services Ltd. </xsl:text>
		<xsl:call-template name="getString">
            <xsl:with-param name="stringName" select="'All Rights Reserved'"/>
        </xsl:call-template>
		<xsl:text> | </xsl:text><a href="../common/feedback.html?noframes=true" target="_blank">
		<xsl:call-template name="getString">
            <xsl:with-param name="stringName" select="'Feedback'"/>
        </xsl:call-template>
		</a>
	</p>
  </xsl:template>

<!-- NOTE OVERRIDES -->

  <!-- Fixed SF Bug 1405184 "Note template for XHTML should be easier to override" -->
<xsl:template match="*[contains(@class,' topic/note ')]" name="topic.note">
  <xsl:call-template name="spec-title"/>
  <xsl:choose>
    <xsl:when test="@type='note'">
      <xsl:apply-templates select="." mode="process.note"/>
    </xsl:when>
    <xsl:when test="@type='tip'">
      <xsl:apply-templates select="." mode="process.note.tip"/>
    </xsl:when>
    <xsl:when test="@type='fastpath'">
      <xsl:apply-templates select="." mode="process.note.fastpath"/>
    </xsl:when>
    <xsl:when test="@type='important'">
      <xsl:apply-templates select="." mode="process.note.important"/>
    </xsl:when>
    <xsl:when test="@type='remember'">
      <xsl:apply-templates select="." mode="process.note.remember"/>
    </xsl:when>
    <xsl:when test="@type='restriction'">
      <xsl:apply-templates select="." mode="process.note.restriction"/>
    </xsl:when>
    <xsl:when test="@type='attention'">
      <xsl:apply-templates select="." mode="process.note.attention"/>
    </xsl:when>
    <xsl:when test="@type='caution'">
      <xsl:apply-templates select="." mode="process.note.caution"/>
    </xsl:when>
    <xsl:when test="@type='danger'">
      <xsl:apply-templates select="." mode="process.note.danger"/>
    </xsl:when>
    <xsl:when test="@type='other'">
      <xsl:apply-templates select="." mode="process.note.other"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="." mode="process.note"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="$newline"/>
</xsl:template>

<xsl:template match="*" mode="process.note">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
  <div class="note">
    <xsl:call-template name="commonattributes"/>
    <xsl:call-template name="setidaname"/>
    <xsl:call-template name="gen-style">
      <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <span class="notetitle">
      <xsl:call-template name="getString">
        <xsl:with-param name="stringName" select="'Note'"/>
      </xsl:call-template>
    </span>
    <!--<xsl:call-template name="getString" />-->
    <xsl:call-template name="start-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
    </xsl:call-template>
    <xsl:call-template name="revblock">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
    <xsl:call-template name="end-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="*" mode="process.note.tip">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
  <div class="tip">
    <xsl:call-template name="commonattributes"/>
    <xsl:call-template name="setidaname"/>
    <xsl:call-template name="gen-style">
      <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <span class="tiptitle">
      <xsl:call-template name="getString">
        <xsl:with-param name="stringName" select="'Tip'"/>
      </xsl:call-template>
    </span>
    <!--<xsl:call-template name="getString" />-->
    <xsl:call-template name="start-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
    </xsl:call-template>
    <xsl:call-template name="revblock">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
    <xsl:call-template name="end-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="*" mode="process.note.fastpath">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
  <div class="fastpath">
    <xsl:call-template name="commonattributes"/>
    <xsl:call-template name="setidaname"/>
    <xsl:call-template name="gen-style">
      <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <span class="fastpathtitle">
      <xsl:call-template name="getString">
        <xsl:with-param name="stringName" select="'Fastpath'"/>
      </xsl:call-template>
    </span>
    <!--<xsl:call-template name="getString" />-->
    <xsl:call-template name="start-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
    </xsl:call-template>
    <xsl:call-template name="revblock">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
    <xsl:call-template name="end-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="*" mode="process.note.important">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
  <div class="important">
    <xsl:call-template name="commonattributes"/>
    <xsl:call-template name="setidaname"/>
    <xsl:call-template name="gen-style">
      <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <span class="importanttitle">
      <xsl:call-template name="getString">
        <xsl:with-param name="stringName" select="'Important'"/>
      </xsl:call-template>
    </span>
    <!--<xsl:call-template name="getString" />-->
    <xsl:call-template name="start-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
    </xsl:call-template>
    <xsl:call-template name="revblock">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
    <xsl:call-template name="end-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="*" mode="process.note.remember">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
  <div class="remember">
    <xsl:call-template name="commonattributes"/>
    <xsl:call-template name="setidaname"/>
    <xsl:call-template name="gen-style">
      <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
     <span class="remembertitle">
      <xsl:call-template name="getString">
        <xsl:with-param name="stringName" select="'Remember'"/>
      </xsl:call-template>
    </span>
   <!--<xsl:call-template name="getString" />-->
    <xsl:call-template name="start-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
    </xsl:call-template>
    <xsl:call-template name="revblock">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="end-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="*" mode="process.note.restriction">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
  <div class="restriction">
    <xsl:call-template name="commonattributes"/>
    <xsl:call-template name="setidaname"/>
    <xsl:call-template name="gen-style">
      <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <span class="restrictiontitle">
      <xsl:call-template name="getString">
        <xsl:with-param name="stringName" select="'Restriction'"/>
      </xsl:call-template>
    </span>
    <!--<xsl:call-template name="getString" />-->
    <xsl:call-template name="start-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
    </xsl:call-template>
    <xsl:call-template name="revblock">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="end-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="*" mode="process.note.attention">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
  <div class="attention">
    <xsl:call-template name="commonattributes"/>
    <xsl:call-template name="setidaname"/>
    <xsl:call-template name="gen-style">
      <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="start-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
    </xsl:call-template>
     <span class="attentiontitle">
      <xsl:call-template name="getString">
        <xsl:with-param name="stringName" select="'Attention'"/>
      </xsl:call-template>
    </span>
    <!--<xsl:call-template name="getString" />-->
    <xsl:call-template name="revblock">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="end-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="*" mode="process.note.caution">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
  <div class="cautiontitle">
    <xsl:call-template name="commonattributes"/>
    <xsl:call-template name="setidaname"/>    
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'Caution'"/>
    </xsl:call-template>
<!--<xsl:call-template name="getString" />-->
  </div>
  <div class="caution">
    <xsl:call-template name="gen-style">
      <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="start-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
    </xsl:call-template>
    <xsl:call-template name="revblock">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="end-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
  </div>  
</xsl:template>

<xsl:template match="*" mode="process.note.danger">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
  <div class="dangertitle">
    <xsl:call-template name="commonattributes"/>
    <xsl:call-template name="setidaname"/>
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'Danger'"/>
    </xsl:call-template>
  </div>
  <div class="danger">
    <xsl:call-template name="commonattributes"/>
    <xsl:call-template name="gen-style">
      <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="start-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
    </xsl:call-template>
    <xsl:call-template name="revblock">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="end-flagit">
      <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="*" mode="process.note.other">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="@othertype">
      <div class="note">
        <xsl:call-template name="commonattributes"/>
        <xsl:call-template name="setidaname"/>
        <xsl:call-template name="gen-style">
          <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
          <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
        </xsl:call-template>
        <span class="notetitle">
        <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="'Note'"/>
        </xsl:call-template>
        </span>
    <xsl:call-template name="getString" />
        <xsl:call-template name="start-flagit">
          <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
        </xsl:call-template>
        <xsl:call-template name="revblock">
          <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="end-flagit">
          <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
        </xsl:call-template>
      </div>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="." mode="process.note"/> <!-- otherwise, give them the standard note -->
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- RELATED LINKS OVERRIDES -->

<!--type templates: concept, task, reference, relinfo-->

<xsl:template name="concept-links">
     <!--related concepts - all the related concept links that haven't already been covered as a child/descendant/ancestor/next/previous/prerequisite, and aren't in a linklist-->
     <xsl:if test="descendant::*[contains(@class, ' topic/link ')]
          [not(ancestor::*[contains(@class,' topic/linklist ')])]
          [not(@role='child' or @role='descendant' or @role='ancestor' or @role='parent' or @role='next' or @role='previous')]
          [not(@importance='required' and (not(@role) or @role='sibling' or @role='friend' or @role='cousin'))]
          [@type='concept']">
          <div class="reltasks">
          <h4>
             <xsl:call-template name="getString">
                  <xsl:with-param name="stringName" select="'Related concepts'"/>
               </xsl:call-template>
          </h4>
          <xsl:value-of select="$newline"/>
            <!--once the related concepts section is set up, sort links by role within the section, using a shared sorting routine so that it's consistent across sections-->
            <xsl:call-template name="sort-links-by-role"><xsl:with-param name="type">concept</xsl:with-param></xsl:call-template>
          </div><xsl:value-of select="$newline"/>
     </xsl:if>
</xsl:template>

<xsl:template name="task-links">
     <!--related tasks - all the related task links that haven't already been covered as a child/descendant/ancestor/next/previous/prerequisite, and aren't in a linklist-->
     <xsl:if test="descendant::*[contains(@class, ' topic/link ')]
          [not(ancestor::*[contains(@class,' topic/linklist ')])]
          [not(@role='child' or @role='descendant' or @role='ancestor' or @role='parent' or @role='next' or @role='previous')]
          [not(@importance='required' and (not(@role) or @role='sibling' or @role='friend' or @role='cousin'))]
          [@type='task']">
          <div class="reltasks">
          <h4>
             <xsl:call-template name="getString">
               <xsl:with-param name="stringName" select="'Related tasks'"/>
             </xsl:call-template>
          </h4>
          <xsl:value-of select="$newline"/>
          <!--once the related tasks section is set up, sort links by role within the section, using a shared sorting routine so that it's consistent across sections-->
          <xsl:call-template name="sort-links-by-role"><xsl:with-param name="type">task</xsl:with-param></xsl:call-template>
          </div><xsl:value-of select="$newline"/>
     </xsl:if>
</xsl:template>

<xsl:template name="reference-links">
     <!--related reference - all the related reference links that haven't already been covered as a child/descendant/ancestor/next/previous/prerequisite, and aren't in a linklist-->
     <xsl:if test="descendant::*
          [contains(@class, ' topic/link ')]
          [not(ancestor::*[contains(@class,' topic/linklist ')])]
          [not(@role='child' or @role='descendant' or @role='ancestor' or @role='parent' or @role='next' or @role='previous')]
          [not(@importance='required' and (not(@role) or @role='sibling' or @role='friend' or @role='cousin'))]
          [@type='reference']">
          <div class="relref">
          <h4>
             <xsl:call-template name="getString">
               <xsl:with-param name="stringName" select="'Related reference'"/>
             </xsl:call-template>
          </h4>
          <xsl:value-of select="$newline"/>
          <!--once the related reference section is set up, sort links by role within the section, using a shared sorting routine so that it's consistent across sections-->
          <xsl:call-template name="sort-links-by-role"><xsl:with-param name="type">reference</xsl:with-param></xsl:call-template>
          </div><xsl:value-of select="$newline"/>
     </xsl:if>
</xsl:template>

<xsl:template name="relinfo-links">
     <!--other info- - not currently sorting by role, since already mixing any number of types in here-->
     <!--if there are links not covered by any of the other routines - ie, not in a linklist, not a child or descendant, not a concept/task/reference, not ancestor/next/previous, not prerequisite - create a section for them and create the links-->
     <xsl:if test="descendant::*
[contains(@class, ' topic/link ')]
[not(ancestor::*[contains(@class,' topic/linklist ')])]
          [not(@role='child' or @role='descendant' or @role='ancestor' or @role='parent' or @role='next' or @role='previous' or @type='concept' or @type='task' or @type='reference')]
          [not(@importance='required' and (not(@role) or @role='sibling' or @role='friend' or @role='cousin'))]">
          <div class="relinfo">
          <h4>
             <xsl:call-template name="getString">
                  <xsl:with-param name="stringName" select="'Related information'"/>
               </xsl:call-template>
          </h4><xsl:value-of select="$newline"/>
       <!--once section is created, create the links, using the same rules as above plus a uniqueness check-->
       <xsl:for-each select="descendant::*
          [not(ancestor::*[contains(@class,' topic/linklist ')])]
          [generate-id(.)=generate-id(key('link',concat(ancestor::*[contains(@class, ' topic/related-links ')]/parent::*[contains(@class, ' topic/topic ')]/@id, ' ', @href,@type,@role,@platform,@audience,@importance,@outputclass,@keyref,@scope,@format,@otherrole,@product,@otherprops,@rev,@class,child::*))[1])]
[contains(@class, ' topic/link ')]
          [not(@role='child' or @role='descendant' or @role='ancestor' or @role='parent' or @role='next' or @role='previous' or @type='concept' or @type='task' or @type='reference')]
          [not(@importance='required' and (not(@role) or @role='sibling' or @role='friend' or @role='cousin'))]">
          <xsl:apply-templates select="."/>
       </xsl:for-each>
          </div><xsl:value-of select="$newline"/>
     </xsl:if>
</xsl:template>

<!--plain templates: next, prev, ancestor/parent, children, everything else-->

<xsl:template name="nextlink" match="*[contains(@class, ' topic/link ')][@role='next']" priority="2">
          <xsl:call-template name="getString">
                  <xsl:with-param name="stringName" select="'Next topic'"/>
               </xsl:call-template>
          <xsl:call-template name="getString">
                  <xsl:with-param name="stringName" select="'ColonSymbol'"/>
               </xsl:call-template>
          <xsl:text> </xsl:text>
          <xsl:call-template name="makelink"/>
</xsl:template>


<xsl:template name="prevlink" match="*[contains(@class, ' topic/link ')][@role='previous']" priority="2">
          <xsl:call-template name="getString">
                  <xsl:with-param name="stringName" select="'Previous topic'"/>
               </xsl:call-template>
          <xsl:call-template name="getString">
                  <xsl:with-param name="stringName" select="'ColonSymbol'"/>
               </xsl:call-template>
          <xsl:text> </xsl:text>
          <xsl:call-template name="makelink"/>
</xsl:template>

<xsl:template name="parentlink" match="*[contains(@class, ' topic/link ')][@role='parent']" priority="2">
          <!-- Disabling this feature
		  <br />
		  <xsl:call-template name="getString">
                  <xsl:with-param name="stringName" select="'Parent topic'"/>
               </xsl:call-template>
          <xsl:call-template name="getString">
                  <xsl:with-param name="stringName" select="'ColonSymbol'"/>
               </xsl:call-template>
          <xsl:text> </xsl:text>
          <xsl:call-template name="makelink"/>
		  -->
</xsl:template>

<!--basic child processing-->
<xsl:template match="*[contains(@class, ' topic/link ')][@role='child' or @role='descendant']" priority="2" name="topic.link_child">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
   <xsl:variable name="el-name">
       <xsl:choose>
           <xsl:when test="contains(../@class,' topic/linklist ')">div</xsl:when>
           <xsl:otherwise>li</xsl:otherwise>
       </xsl:choose>
   </xsl:variable>
   <xsl:element name="{$el-name}">
       <xsl:attribute name="class">ulchildlink</xsl:attribute>
       <xsl:call-template name="commonattributes"/>
     <xsl:call-template name="start-flagit">
       <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
     </xsl:call-template>
     <xsl:call-template name="start-revflag">
       <xsl:with-param name="flagrules" select="$flagrules"/>
     </xsl:call-template>
     <a>
          <xsl:call-template name="add-linking-attributes"/>

          <!--use linktext as linktext if it exists, otherwise use href as linktext-->
          <xsl:choose>
          <xsl:when test="*[contains(@class, ' topic/linktext ')]"><xsl:apply-templates select="*[contains(@class, ' topic/linktext ')]"/></xsl:when>
          <xsl:otherwise><!--use href--><xsl:call-template name="href"/></xsl:otherwise>
          </xsl:choose>
      </a>
     <xsl:call-template name="end-revflag">
       <xsl:with-param name="flagrules" select="$flagrules"/>
     </xsl:call-template>
     <xsl:call-template name="end-flagit">
       <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
     </xsl:call-template>
     <br/><xsl:value-of select="$newline"/>
     <!--add the description on the next line, like a summary-->
     <xsl:apply-templates select="*[contains(@class, ' topic/desc ')]"/>
   </xsl:element><xsl:value-of select="$newline"/>
</xsl:template>

<xsl:template match="*[contains(@class, ' topic/linklist ')]/*[contains(@class, ' topic/title ')]" name="topic.linklist_title">
  <xsl:apply-templates/><br/><xsl:value-of select="$newline"/>
</xsl:template>

<!--  TABLE CUSTOMIZATIONS -->

<!-- table caption -->
<xsl:template name="place-tbl-lbl">
<xsl:param name="stringName"/>
  <!-- Number of table/title's before this one -->
  <xsl:variable name="tbl-count-actual" select="count(preceding::*[contains(@class,' topic/table ')]/*[contains(@class,' topic/title ')])+1"/>

  <!-- normally: "Table 1. " -->
  <xsl:variable name="ancestorlang">
   <xsl:call-template name="getLowerCaseLang"/>
  </xsl:variable>
  
  <xsl:choose>
    <!-- title -or- title & desc -->
    <xsl:when test="*[contains(@class,' topic/title ')]">
      <caption>
       <xsl:choose>     <!-- Hungarian: "1. Table " -->
        <xsl:when test="( (string-length($ancestorlang)=5 and contains($ancestorlang,'hu-hu')) or (string-length($ancestorlang)=2 and contains($ancestorlang,'hu')) )">
         <xsl:value-of select="$tbl-count-actual"/><xsl:text>. </xsl:text>
         <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="'Table'"/>
         </xsl:call-template><xsl:text> </xsl:text>
        </xsl:when>
        <xsl:otherwise>
        <strong>
         <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="'Table'"/>
         </xsl:call-template><xsl:text> </xsl:text><xsl:value-of select="$tbl-count-actual"/><xsl:text>. </xsl:text>
        </strong>        
       </xsl:otherwise>
       </xsl:choose>
       <xsl:apply-templates select="./*[contains(@class,' topic/title ')]" mode="tabletitle"/>
       <xsl:if test="*[contains(@class,' topic/desc ')]">
        <xsl:text>. </xsl:text>
        <xsl:apply-templates select="./*[contains(@class,' topic/desc ')]" mode="tabledesc"/>
       </xsl:if>
      </caption>
    </xsl:when>
    <!-- desc -->
    <xsl:when test="*[contains(@class,' topic/desc ')]">
      <div><xsl:apply-templates select="./*[contains(@class,' topic/desc ')]" mode="tabledesc"/></div>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<!-- LIST CUSTOMIZATIONS -->
  
<xsl:template match="*[contains(@class,' topic/ul ')]" mode="ul-fmt">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="start-flagit">
    <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
  </xsl:call-template>
  <xsl:call-template name="start-revflag">
    <xsl:with-param name="flagrules" select="$flagrules"/>
  </xsl:call-template>
 <xsl:call-template name="setaname"/>
 <ul>
   <xsl:call-template name="commonattributes"/>
   <xsl:call-template name="gen-style">
     <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
     <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
   </xsl:call-template>
   <xsl:apply-templates select="@compact"/>
   <xsl:call-template name="setid"/>
   <xsl:apply-templates/>
 </ul>
  <xsl:call-template name="end-revflag">
    <xsl:with-param name="flagrules" select="$flagrules"/>
  </xsl:call-template>
  <xsl:call-template name="end-flagit">
    <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
  </xsl:call-template>
 <xsl:value-of select="$newline"/>
</xsl:template>

<!-- Simple List -->
<!-- handle all levels thru browser processing -->
<xsl:template match="*[contains(@class,' topic/sl ')]" name="topic.sl">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:call-template name="start-flagit">
    <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
  </xsl:call-template>
  <xsl:choose> <!-- draft rev mode, add div w/ rev attr value -->
   <xsl:when test="@rev and not($FILTERFILE='') and ($DRAFT='yes')">
    <xsl:variable name="revtest"> <!-- Flag the revision? 1=yes; 0=no -->
     <xsl:call-template name="find-active-rev-flag">
      <xsl:with-param name="allrevs" select="@rev"/>
     </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
     <xsl:when test="$revtest=1">
      <div class="{@rev}"><xsl:apply-templates select="."  mode="sl-fmt" /></div>
     </xsl:when>
     <xsl:otherwise>
      <xsl:apply-templates select="."  mode="sl-fmt" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates select="."  mode="sl-fmt" />
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>  

<!-- Ordered List - 1st level - Handle levels 1 to 9 thru OL-TYPE attribution -->
<!-- Updated to use a single template, use count and mod to set the list type -->
<xsl:template match="*[contains(@class,' topic/ol ')]" name="topic.ol">
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
<xsl:variable name="olcount" select="count(ancestor-or-self::*[contains(@class,' topic/ol ')])"/>
  <xsl:call-template name="start-flagit">
    <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
  </xsl:call-template>
  <xsl:call-template name="start-revflag">
    <xsl:with-param name="flagrules" select="$flagrules"/>
  </xsl:call-template>
<xsl:call-template name="setaname"/>
<ol>
  <xsl:call-template name="commonattributes"/>
  <xsl:call-template name="gen-style">
    <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
    <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
  </xsl:call-template>
  <xsl:apply-templates select="@compact"/>
  <xsl:choose>
    <xsl:when test="$olcount mod 3 = 1"/>
    <xsl:when test="$olcount mod 3 = 2"><xsl:attribute name="type">a</xsl:attribute></xsl:when>
    <xsl:otherwise><xsl:attribute name="type">i</xsl:attribute></xsl:otherwise>
  </xsl:choose>
  <xsl:call-template name="setid"/>
  <xsl:apply-templates/>
</ol>
  <xsl:call-template name="end-revflag">
    <xsl:with-param name="flagrules" select="$flagrules"/>
  </xsl:call-template>
  <xsl:call-template name="end-flagit">
    <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
  </xsl:call-template>
<xsl:value-of select="$newline"/>
</xsl:template>

<!-- CUSTOMIZE SINGLE STEP PROCEDURE DISPLAY -->
  
<!-- only 1 step - output as a single bullet -->
<xsl:template match="*[contains(@class,' task/step ')]" mode="onestep">
<xsl:param name="step_expand"/>
 <xsl:variable name="revtest">
   <xsl:if test="@rev and not($FILTERFILE='') and ($DRAFT='yes')">
     <xsl:call-template name="find-active-rev-flag">              
       <xsl:with-param name="allrevs" select="@rev"/>
     </xsl:call-template>
   </xsl:if>
 </xsl:variable>
 <xsl:choose>
   <xsl:when test="$revtest=1">   <!-- Rev is active - add the DIV -->
    <div class="{@rev}"><xsl:apply-templates select="."  mode="onestep-fmt">
     <xsl:with-param name="step_expand" select="$step_expand"/>
    </xsl:apply-templates></div>
   </xsl:when>
   <xsl:otherwise>  <!-- Rev wasn't active - process normally -->
    <xsl:apply-templates select="."  mode="onestep-fmt">
     <xsl:with-param name="step_expand" select="$step_expand"/>
    </xsl:apply-templates>
   </xsl:otherwise>
 </xsl:choose>
</xsl:template>
<xsl:template match="*[contains(@class,' task/step ')]" mode="onestep-fmt">
<xsl:param name="step_expand"/>
  <xsl:variable name="flagrules">
    <xsl:call-template name="getrules"/>
  </xsl:variable>
  <xsl:variable name="conflictexist">
    <xsl:call-template name="conflict-check">
      <xsl:with-param name="flagrules" select="$flagrules"/>
    </xsl:call-template>
  </xsl:variable>
<ul>
  <li>
  <xsl:call-template name="commonattributes"/>
  <xsl:call-template name="gen-style">
    <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param> 
    <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="setidaname"/>
  <xsl:call-template name="start-flagit">
    <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>     
  </xsl:call-template>
  <xsl:call-template name="start-revflag">
    <xsl:with-param name="flagrules" select="$flagrules"/>
  </xsl:call-template>  
  <xsl:if test="@importance='optional'">
    <strong>
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'Optional'"/>
    </xsl:call-template>
    <xsl:call-template name="getString">
     <xsl:with-param name="stringName" select="'ColonSymbol'"/>
    </xsl:call-template><xsl:text> </xsl:text>
    </strong>
  </xsl:if>
  <xsl:if test="@importance='required'">
    <strong>
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'Required'"/>
    </xsl:call-template>
    <xsl:call-template name="getString">
     <xsl:with-param name="stringName" select="'ColonSymbol'"/>
    </xsl:call-template><xsl:text> </xsl:text>
    </strong>
  </xsl:if>
 <xsl:apply-templates/>
  </li>
 </ul>
  <xsl:value-of select="$newline"/>
  <xsl:call-template name="end-revflag">
    <xsl:with-param name="flagrules" select="$flagrules"/>
  </xsl:call-template>
  <xsl:call-template name="end-flagit">
    <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param> 
  </xsl:call-template>
</xsl:template>

 <!--children links - handle all child or descendant links except those in linklists or ordered collection-types.
Each child is indented, the linktext is bold, and the shortdesc appears in normal text directly below the link, to create a summary-like appearance.-->
<xsl:template name="ul-child-links">
     <xsl:if test="descendant::*[contains(@class, ' topic/link ')][@role='child' or @role='descendant'][not(parent::*/@collection-type='sequence')][not(ancestor::*[contains(@class, ' topic/linklist ')])]">
     <xsl:value-of select="$newline"/><div class="section_contents">
		<h4>
			<xsl:call-template name="getString">
				<xsl:with-param name="stringName" select="'Section contents'" />
			</xsl:call-template>
		</h4>
		<ul class="ullinks"><xsl:value-of select="$newline"/>
       <!--once you've tested that at least one child/descendant exists, apply templates to only the unique ones-->
          <xsl:apply-templates select="descendant::*
          [generate-id(.)=generate-id(key('link',concat(ancestor::*[contains(@class, ' topic/related-links ')]/parent::*[contains(@class, ' topic/topic ')]/@id, ' ', @href,@type,@role,@platform,@audience,@importance,@outputclass,@keyref,@scope,@format,@otherrole,@product,@otherprops,@rev,@class,child::*))[1])]
          [contains(@class, ' topic/link ')]
          [@role='child' or @role='descendant']
          [not(parent::*/@collection-type='sequence')]
          [not(ancestor::*[contains(@class, ' topic/linklist ')])]"/>
     </ul></div><xsl:value-of select="$newline"/>
     </xsl:if>
</xsl:template>

  <xsl:template name="chapterHead">
    <xsl:apply-templates select="." mode="chapterHead"/>
  </xsl:template>
  <xsl:template match="*" mode="chapterHead">
    <head><xsl:value-of select="$newline"/>
      <!-- initial meta information -->
      <xsl:call-template name="generateCharset"/>   <!-- Set the character set to UTF-8 -->
      <xsl:call-template name="generateDefaultCopyright"/> <!-- Generate a default copyright, if needed -->
      <xsl:call-template name="generateDefaultMeta"/> <!-- Standard meta for security, robots, etc -->
      <xsl:call-template name="getMeta"/>           <!-- Process metadata from topic prolog -->
      <xsl:call-template name="copyright"/>         <!-- Generate copyright, if specified manually -->
      <xsl:call-template name="generateCssLinks"/>  <!-- Generate links to CSS files -->
      <xsl:call-template name="gen-user-scripts" /> <!-- include user's XSL javascripts here -->
	  <xsl:call-template name="generateChapterTitle"/> <!-- Generate the <title> element -->
      <xsl:call-template name="gen-user-head" />    <!-- include user's XSL HEAD processing here -->
      <xsl:call-template name="gen-user-styles" />  <!-- include user's XSL style element and content here -->
      <xsl:call-template name="processHDF"/>        <!-- Add user HDF file, if specified -->
    </head>
    <xsl:value-of select="$newline"/>
  </xsl:template>

<xsl:template name="gen-user-scripts">
  <xsl:apply-templates select="." mode="gen-user-scripts"/>
</xsl:template>
<xsl:template match="/|node()|@*" mode="gen-user-scripts">
<xsl:if test="$INCLUDEGOOGLEJS='yes'">
<script type="text/javascript">
<![CDATA[var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-16904975-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();]]>
</script><xsl:value-of select="$newline"/>
</xsl:if>
</xsl:template>

</xsl:stylesheet> 
