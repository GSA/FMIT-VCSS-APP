<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="Content">
    <h2>Frequently Asked Questions</h2>
    <div id="accFAQ" class="accordion">
      <xsl:for-each select="SECTION">
        <xsl:if test="@Type='FAQ' and @ShowCOntact='true'">
          <h4>
            SECTION: <xsl:value-of select="@Name"/>
          </h4>
          <div>
            <table class="SearchTable" style="width: 100%;" border="1">
              <thead>
		<th align="center" width="40%">
                  Question
                </th>
		<th align="center" width="20%">
                  	Point of Contact (Group) Email
                </th>
          	<th align="center" width="40%">
                  Answer
                </th>
              </thead>
              <xsl:for-each select="FAQ">
                <xsl:variable name="css-class">
                  <xsl:choose>
                    <xsl:when test="position() mod 2 = 0">odd</xsl:when>
                  </xsl:choose>
                </xsl:variable>
                <tr class="{$css-class}">
                  <td align="center">
                    <b>
                      <xsl:value-of select="@Question"/>
                    </b>
                  </td>
	         <td align="center">
                    <a>
                      <xsl:attribute name="href">
                        mailto:<xsl:value-of select="@GroupContact"/>
                      </xsl:attribute>
                      <xsl:value-of select="@GroupContact"/>
                    </a>
                  </td>
                  <td align="center">
                    <xsl:if test="@IsLink='true'">
                      <a>
                        <xsl:attribute name="href">
                          <xsl:value-of select="@Document"/>
                        </xsl:attribute>
                        <xsl:attribute name="target">
                          _blank
                        </xsl:attribute>
                        <xsl:value-of select="@Name"/>
                      </a>
                    </xsl:if>
                    <xsl:if test="@IsLink='false'">
                      <xsl:value-of select="@Name"/>
                    </xsl:if>
                  </td>
                </tr>
              </xsl:for-each>
            </table>
          </div>
        </xsl:if>
        <xsl:if test="@Type='FAQ' and @ShowCOntact='false'">
          <h4>
            SECTION: <xsl:value-of select="@Name"/>
          </h4>
          <div>
            <table class="SearchTable" style="width: 100%;" border="1">
              <thead>
		<th align="center" width="50%">
                  Question
                </th>
          	<th align="center" width="50%">
                  Answer
                </th>
              </thead>
              <xsl:for-each select="FAQ">
                <xsl:variable name="css-class">
                  <xsl:choose>
                    <xsl:when test="position() mod 2 = 0">odd</xsl:when>
                  </xsl:choose>
                </xsl:variable>
                <tr class="{$css-class}">
                  <td align="center">
                    <b>
                      <xsl:value-of select="@Question"/>
                    </b>
                  </td>
                  <td align="center">
                    <xsl:if test="@IsLink='true'">
                      <a>
                        <xsl:attribute name="href">
                          <xsl:value-of select="@Document"/>
                        </xsl:attribute>
                        <xsl:attribute name="target">
                          _blank
                        </xsl:attribute>
                        <xsl:value-of select="@Name"/>
                      </a>
                    </xsl:if>
                    <xsl:if test="@IsLink='false'">
                      <xsl:value-of select="@Name"/>
                    </xsl:if>
                  </td>
                </tr>
              </xsl:for-each>
            </table>
          </div>
        </xsl:if>
      </xsl:for-each>
    </div>
    <h2>Brochures</h2>
    <div id="accBrochure" class="accordion">
      <xsl:for-each select="SECTION">
        <xsl:if test="@Type='BROCHURE'">
          <h4>
            <xsl:value-of select="@Name"/>
          </h4>
          <div>
            <table class="SearchTable" style="width: 100%;" border="1">
              <thead>
                <th align="center" width="40%">
                  Topics
                </th>
                <th align="center" width="20%">
                  Title
                </th>
                <th align="center" width="40%">
                  Document Link
                </th>
              </thead>
              <xsl:for-each select="BROCHURE">
                <xsl:variable name="css-class">
                  <xsl:choose>
                    <xsl:when test="position() mod 2 = 0">odd</xsl:when>
                  </xsl:choose>
                </xsl:variable>
                <tr class="{$css-class}">
                  <td align="center">
                    <b>
                      <xsl:value-of select="@Topic"/>
                    </b>
                  </td>
                  <td align="center">
                    <xsl:value-of select="@Title"/>
                  </td>
                  <td align="center">
                    <a>
                      <xsl:attribute name="href">
                        <xsl:value-of select="@Document"/>
                      </xsl:attribute>
                      <xsl:attribute name="target">
                        _blank
                      </xsl:attribute>
                      <xsl:value-of select="@Name"/>
                    </a>
                  </td>
                </tr>
              </xsl:for-each>
            </table>
          </div>
        </xsl:if>
      </xsl:for-each>
    </div>
  </xsl:template>
</xsl:stylesheet>