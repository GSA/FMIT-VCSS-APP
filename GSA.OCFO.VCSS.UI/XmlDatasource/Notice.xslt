<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="Notice">
		<div class="notice">
			<ul style="margin-top: 1px;margin-bottom: 1px;">
				<!--<li>
          <b>
            <span style="color:red;">PLANNED VCSS OUTAGE: 7 p.m. (ET) March 9 until 7 a.m. (ET) March 14</span>
          </b>
	     <a id="note4" class="details" href="javascript:void(0)">+ SHOW DETAILS</a>
          <div class="divnote" id="divnote4">
            <b>
              SCHEDULED OUTAGE TIME:<br/>
              7 p.m. (Eastern Time) Thursday, March 9 - 7 a.m. (Eastern Time) Tuesday, March 14<br/><br/>
            </b>
            <b>VCSS will be unavailable</b> due to the implementation of the Pegasys Cloud Hosting Migration.
          </div>
        </li>-->

				<li>
					<b>
						<span style="color:red;">January 15:</span> The VCSS Registration and Access Request page is currently not available. We are working to resolve this issue as soon as possible.
					</b>
				</li>
				<li>
					<b>
						<span style="color:red;">Notice:</span> Effective April 10, 2019, three GSA lockbox remittance addresses will change. Please review your billing statements closely for new GSA remittance information.
					</b>
				</li>
				<li>
					<b>
						<span style="color:red;">RWA:</span> December 2019 RWA billing statements are now available to be viewed.
					</b>
				</li>
				<li>
					<b>
						<span style="color:red;">SPEEDPAY AND MILEAGE EXPRESS USERS:</span> Change Line of Accounting and Document Number before entering month-end mileage.  Chargebacks due to inaccurate LOA information will not be accepted.
					</b>
					<a id="note3" class="details" href="javascript:void(0)">+ SHOW DETAILS</a>
					<div class="divnote" id="divnote3">
						It is imperative that all customers using SpeedPay change their Line of Accounting (LOA) and Document Number effective on or after October 1, BEFORE mileages are entered in October.  Do not enter any month-end mileages until after October 15.  There will need to be a coordination of efforts between the individuals who input mileages into Mileage Express and the budget personnel who are responsible for entering the LOA into SpeedPay to ensure that the LOA is changed BEFORE mileages are reported.  Chargebacks due to inaccurate LOA information inSpeedPay after October 1 will not be accepted.
						<br/><br/>If you have any questions, please contact your Fleet Service Representative or Fleet Management Center.
					</div>
				</li>
				<li>
					<b>Email notification will be sent to a customer when a new bill for one of their registered account codes is available in VCSS.</b>
				</li>

				<li>
					<b>
						<xsl:value-of select="Header"/>
					</b>
					<a id="note1" class="details" href="javascript:void(0)">+ SHOW DETAILS</a>
					<div class="divnote" id="divnote1">
						<xsl:value-of select="Description"/>
					</div>
				</li>
			</ul>
		</div>
		<div id="warning">
			If you do not do business with GSA as either a vendor or customer, please do not
			contact GSA to register in VCSS and do not attempt to log in.
		</div>
	</xsl:template>
</xsl:stylesheet>