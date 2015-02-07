<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd"
    version="2.0"
    exclude-result-prefixes="xs xd">

    <xsl:output indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/mods:mods">
        <!-- <xsl:for-each select="."> -->

            <!--<xsl:variable name="title" select="mods:titleInfo/mods:title" />-->
            <xsl:variable name="title">Bryan Designed This Coverpage and Then Wrote an Electronic Thesis About It</xsl:variable>>
            
  	    <!--
            <xsl:variable name="author">
                <xsl:variable name="first" select="authors/author/fname"/>
                <xsl:variable name="last" select="authors/author/lname"/>
                <xsl:variable name="middle" select="authors/author/mname"/>
                <xsl:variable name="suffix" select="authors/author/suffix"/>
                
                <xsl:value-of
                    select="
                    if (suffix) then
                    if (mname) then concat($first, ' ', $middle, ' ', $last, ', ',$suffix) else concat($first, ' ', $last, ', ',$suffix) 
                    else 
                    if (mname) then concat($first, ' ', $middle, ' ', $last) else concat($first, ' ', $last)
                    "/>
            </xsl:variable>
            
            <xsl:variable name="year" select="substring(publication-date,1,4)"/>
            -->
            <xsl:variable name="author">Bryan Brown</xsl:variable>
            <xsl:variable name="year">1986</xsl:variable>

            <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
                <fo:layout-master-set>
                    <fo:simple-page-master page-height="11in" page-width="8.5in"
                        master-name="coverpage">
                        <fo:region-body region-name="title" margin="1in"/>
                    </fo:simple-page-master>
                </fo:layout-master-set>


                <fo:page-sequence master-reference="coverpage">
                    <fo:flow flow-name="title" font-family="'any'" font-style="normal"
                        padding-left="15pt" text-decoration="none" text-indent="0pt">

                        <fo:block-container color="#782F40">
                            <fo:block padding-top="0.25in">
                                <fo:inline font-size="32pt" font-weight="bold" text-align-last="center">Florida State
                                    University Libraries</fo:inline>
                            </fo:block>
                        </fo:block-container>

                        <fo:block>
                            <fo:leader color="#782F40" leader-length="100%" leader-pattern="rule"
                                padding-left="0pt" rule-style="solid" rule-thickness=".2mm"/>
                        </fo:block>

                        <!-- ONLY FOR ETDS, TAKE OUT FOR PUBLICATIONS!!! -->
                        <fo:block color="black" font-size="12pt" font-weight="normal"
                          padding-top="7pt" text-align-last="justify">
                          <fo:inline>Electronic Theses, Treatises and Dissertations</fo:inline>
                          <fo:leader leader-pattern="space"/>
                          <fo:inline>The Graduate School</fo:inline>
                        </fo:block>

                        <fo:block>
                          <fo:leader color="#782F40" leader-length="100%" leader-pattern="rule"
                            padding-left="0pt" rule-style="solid" rule-thickness=".2mm"/>
                        </fo:block>

                        <fo:block-container color="black" padding-top="40pt" padding-left="15pt">
                          <fo:block font-size="13pt">
                            <xsl:value-of select="$year"/>
                          </fo:block>
                          <fo:block font-size="26pt" line-height="24pt" padding-top="10pt">
                            <xsl:value-of select="$title"/>
                          </fo:block>
                          <fo:block font-size="13pt" padding-top="11pt">
                            <xsl:value-of select="$author"/>
                          </fo:block>

		          <!-- Fix later, make more dynamic
                          <fo:block font-size="10pt" padding-top="1pt" font-style="italic">Florida
                            State University</fo:block> -->

                        </fo:block-container>

                        <fo:block-container absolute-position="fixed" top="220mm" left="28mm"
                          right="28mm">

                          <fo:block text-align="center" padding-bottom="0.25in">
                            <fo:external-graphic content-height="1.00in" content-width="scale-to-fit" src="color-lib-seal.png"/>
                          </fo:block>

                          <fo:block>
                            <fo:leader color="#782F40" leader-length="100%"
                              leader-pattern="rule" padding-left="0pt" rule-style="solid"
                              rule-thickness=".2mm"/>
                          </fo:block>

                          <fo:block font-size="8pt" padding-left="15pt" text-align="center">Follow this and additional works at the <fo:basic-link color="#782F40" external-destination="http://fsu.digital.flvc.org/">FSU Digital Library</fo:basic-link>. For more information,
                            please contact <fo:basic-link color="#782F40" external-destination="mailto:lib-ir@fsu.edu">lib-ir@fsu.edu</fo:basic-link></fo:block>
                        </fo:block-container>
                      </fo:flow>
                    </fo:page-sequence>
                  </fo:root>

                <!-- </xsl:for-each> -->

                <!--  </xsl:result-document>  -->     

            </xsl:template>

          </xsl:stylesheet>
