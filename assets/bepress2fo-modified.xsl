<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    version="2.0"
    exclude-result-prefixes="xs xd">

        <xd:doc scope="stylesheet">
            <xd:desc>
                <xd:p><xd:b>Last updated:</xd:b> January 11, 2015</xd:p>
                <xd:p><xd:b>Author:</xd:b> Annie Glerum</xd:p>
                <xd:p><xd:b>Organization:</xd:b> Florida State University Libraries</xd:p>
                <xd:p><xd:b>Title:</xd:b> Bepress metadata to Formating Objects coverpage</xd:p>
                <xd:p><xd:i>Configure Transformation Scenario as such:</xd:i></xd:p>
                <xd:p>In the XSLT tab
                    <xd:ul>
                        <xd:li>Name the configuration</xd:li>
                        <xd:li>For Storage, choose Project Options</xd:li>
                        <xd:li>Set the XML URL to ${currentFileURL}</xd:li>
                        <xd:li>Set the XSL URL to ${pdu}/bepress2fo.xsl</xd:li>
                        <xd:li>Change the transformer to Saxon-PE 9.5.1.2</xd:li>
                    </xd:ul>
                </xd:p>
                <xd:p>In the FO Processor tab
                    <xd:ul>
                        <xd:li>Check Perform FO processing</xd:li>
                        <xd:li>Choose XSLT result as input</xd:li>
                        <xd:li>Leave the Method default as pdf</xd:li>
                        <xd:li>Leave the Processor default as Apache FOP</xd:li>
                    </xd:ul>
                </xd:p>                
                <xd:p>In the XSLT tab
                    <xd:ul>
                        <xd:li>Choose Save As</xd:li>
                        <xd:li>Enter this path: ${pd}/coverpages/${cfn}_coverpage.pdf</xd:li>
                        <xd:li>Uncheck Open in Browser/System Application</xd:li>
                    </xd:ul>
                </xd:p>
            </xd:desc>
        </xd:doc>

    <xsl:output indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:variable name="paper">
        <xsl:for-each select="documents/document">
        <xsl:variable name="number" select="label"/>
        <xsl:value-of
            select="
            if (string-length($number) eq 1) then concat('000',$number) else 
            if (string-length($number) eq 2) then concat('00',$number) else 
            if (string-length($number) eq 3) then concat('0',$number) else 
            ()"
        />
        </xsl:for-each>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:variable name="filename">
            <xsl:value-of select="concat('etd_', $paper,'.fo')"/>
        </xsl:variable>
       <!-- Uncomment result-document if only the .fo result is desired. Change directory path as needed.
           <xsl:result-document href="/Users/Annie/Desktop/trans2fo/trans2fo_result/{$filename}">-->
        <xsl:for-each select="documents/document">
            <xsl:variable name="title" select="title"/>
            
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
                          <fo:block font-size="10pt" padding-top="1pt" font-style="italic">Florida
                            State University</fo:block>
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

                          <fo:block font-size="8pt" padding-left="15pt" text-align="center">Follow this and additional works at the <fo:basic-link external-destination="http://fsu.digital.flvc.org/">FSU Digital Library</fo:basic-link>. For more information,
                            please contact <fo:basic-link color="#782F40" external-destination="mailto:lib-ir@fsu.edu">lib-ir@fsu.edu</fo:basic-link></fo:block>
                        </fo:block-container>
                      </fo:flow>
                    </fo:page-sequence>
                  </fo:root>

                </xsl:for-each>

                <!--  </xsl:result-document>  -->     

            </xsl:template>

          </xsl:stylesheet>
