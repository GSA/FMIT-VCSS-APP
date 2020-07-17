<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!--<xsl:import href="Test.xslt"/>-->
  <xsl:output method="html"/>
  <xsl:template match="Request">
    <!--<div style="border: solid red">
      <xsl:apply-imports/>
    </div>-->
    <div style="min-width:650px;max-width:800px;padding:5px 10px 5px 10px;background:#f4f4f4;text-align:left;">
      <p style="font-size: large;color: #999999;margin:8px 0px 8px 5px;">
        <img src="cid:gsalogo"/> Vendor and Customer Self Service
      </p>
      <div style="padding:10px; background:#f9f9f9; border: 1px solid #cccccc;">
        <p>
          Dear VCSS Security:
        </p>
        <p>This Email is for your information only.</p>
        <p>
          Confirmation Code for this Request is: <b>
            <xsl:value-of select="Confirmations/Access" />
          </b>
        </p>
        <p>
          <strong>What are the next steps:</strong><br />
          No Action is required until the Account Administrator(s) for this Account(s) forwards their response to <a href="mailto:VCSS.Security@gsa.gov">VCSS.Security@gsa.gov</a>.
        </p>
        <p>
          The Account Administrator(s) for Account(s) has been sent this email asking them to approve/disapprove this Request.
        </p>
        <p>
          If the Account Administrator(s) <b>
            <u>disapproves</u>
          </b> this Request, then forward the disapproval response to the Requester and indicate they will not be granted Access to this Account in VCSS.
        </p>
        <p>
          If the Account Administrator(s) <b>
            <u>approves</u>
          </b> this Request, then forward the approval response to the Requester and use the information below to add the User to VCSS.
        </p>
        <p>
          <strong>Requests Details</strong>
        </p>
        <div style="border:1px solid Black; padding:10px;">
          <p>
            <strong>
              <div style="border-bottom:1px solid Black; width:100%;">
                Requester Information
              </div>
            </strong>
            <br/>
            Name  : <xsl:value-of select="UserInfo/FirstName"/>&#160;<xsl:value-of select="UserInfo/LastName"/><br/>
            Email : <xsl:value-of select="UserInfo/EmailAddress"/><br/>
            Phone : <xsl:value-of select="format-number(UserInfo/PhoneNumber,'(###) ###-####')"/>
          </p>
          <p style="border-bottom:1px solid Black">
            <strong>
              Account requests
            </strong>
          </p>
          <p>
            <strong>Exisiting accounts</strong>
          </p>
          <table width="100%">
            <tr>
              <th width="10%">ALC</th>
              <th width="10%">Account Code</th>
              <th width="5%">Address Code</th>
              <th width="30%">Account name</th>
              <th width="20%">Administrator</th>
              <th width="25%">Administrator Email</th>
            </tr>
            <xsl:apply-templates select="AccessAccounts"/>
          </table>
        </div>
      </div>
      <p style="font-size: x-small;color: #999999;margin:5px 0px 5px 0px;text-align:center;">U.S. General Services Administration</p>
    </div>
  </xsl:template>
  <xsl:template match="UserInfo">
    <xsl:value-of select="FirstName"/>&#160;<xsl:value-of select="UserInfo/LastName"/>
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
        <td style="padding-left:20px;">
          <xsl:value-of select="Name"/>
        </td>
        <td align="center">
          <xsl:value-of select="Administrator"/>
        </td>
        <td align="center">
          <xsl:value-of select="AdministratorEmail"/>
        </td>
      </tr>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>