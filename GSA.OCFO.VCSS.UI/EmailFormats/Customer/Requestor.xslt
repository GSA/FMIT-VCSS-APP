<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="Request">
    <div style="min-width:650px;max-width:800px;padding:5px 10px 5px 10px;background:#f4f4f4;text-align:left;">
      <p style="font-size: large;color: #999999;margin:8px 0px 8px 5px;">
        <img src="cid:gsalogo"/> Vendor and Customer Self Service
      </p>
      <div style="padding:10px; background:#f9f9f9; border: 1px solid #cccccc;">
        <p>
          Dear <xsl:apply-templates select="UserInfo"/>,
        </p>
        <p>Thank you. We have received your Request.</p>
        <p>
          Your Confirmation Code<xsl:if test="Confirmations/Registration and Confirmations/Access">s</xsl:if> for this Request: <b>
            <xsl:apply-templates select="Confirmations"/>
          </b>
        </p>
        <p>
          <strong>What are the next steps,</strong><br />
          Requests for Accounts already registered in VCSS will be sent to the Account Administrator(s). If you do not receive a response about your Account in 5 business days, please follow up with your Account Administrator.
        </p>
        <p>
          Requests for New Accounts will be sent to GSA. If you do not receive a response about your Accounts in 5 business days, please follow up with GSA: <a href="mailto:VCSS.Security@gsa.gov">VCSS.Security@gsa.gov</a>.
        </p>
        <p>
          <strong>Requests Details</strong>
          <br />You may print these details for your record.
        </p>
        <div style="border:1px solid Black; padding:10px;">
          <p>
            <strong>
              <div style="border-bottom:1px solid Black; width:100%;">
                Your Information
              </div>
            </strong>
            <br/>
            Name  : <xsl:value-of select="UserInfo/FirstName"/>&#160;<xsl:value-of select="UserInfo/LastName"/><br/>
            Email : <xsl:value-of select="UserInfo/EmailAddress"/><br/>
            Phone : <xsl:value-of select="format-number(UserInfo/PhoneNumber,'(###) ###-####')"/>
          </p>
          <p style="border-bottom:1px solid Black">
            <strong>
              Account Requests
            </strong>
          </p>
          <xsl:if test="AccessAccounts">
            <p style="border-bottom:1px solid Black">
              <strong>Exisiting Accounts</strong>
            </p>
            <table width="100%">
              <tr>
                <th width="20%" align="center">ALC</th>
                <th width="10%" align="center">Account Code</th>
                <th width="10%" align="center">Address Code</th>
                <th width="60%">Account Name</th>
              </tr>
              <xsl:apply-templates select="AccessAccounts"/>
            </table>
          </xsl:if>
          <xsl:if test="RegistrationAccounts">
            <p style="border-bottom:1px solid Black">
              <strong>
                New Accounts
              </strong>
            </p>
            <table width="100%">
              <tr>
                <th width="25%" align="center">ALC</th>
                <th width="15%" align="center">Account Code</th>                
                <th width="60%">Account Name</th>
              </tr>
              <xsl:apply-templates select="RegistrationAccounts"/>
            </table>
          </xsl:if>
        </div>
      </div>
      <p style="font-size: x-small;color: #999999;margin:5px 0px 5px 0px;text-align:center;">U.S. General Services Administration</p>
    </div>
  </xsl:template>
  <xsl:template match="Confirmations">
    <xsl:if test="Registration and Access">
      Registration: <xsl:value-of select="Registration" /> &amp; Access Reqeust: <xsl:value-of select="Access" />
    </xsl:if>
    <xsl:if test="Registration and not(Access)">
      <xsl:value-of select="Registration" />
    </xsl:if>
    <xsl:if test="not(Registration) and Access">
      <xsl:value-of select="Access" />
    </xsl:if>
  </xsl:template>
  <xsl:template match="UserInfo">
    <xsl:value-of select="FirstName"/>&#160;<xsl:value-of select="LastName"/>
  </xsl:template>
  <xsl:template match="AccessAccounts">
    <xsl:for-each select="Account">
      <tr>
        <td align="center">
          <xsl:value-of select="ALC"/>
        </td>
        <td align="center">
          <xsl:value-of select="AccountCode"/>
        </td>
        <td align="center">
          <xsl:value-of select="AddressCode"/>
        </td>
        <td style="padding-left:100px;">
          <xsl:value-of select="Name"/>
        </td>
      </tr>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="RegistrationAccounts">
    <xsl:for-each select="Account">
      <tr>
        <td align="center">
          <xsl:value-of select="ALC"/>
        </td>
        <td align="center">
          <xsl:value-of select="AccountCode"/>
        </td>        
        <td style="padding-left:100px;">
          <xsl:value-of select="Name"/>
        </td>
      </tr>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>