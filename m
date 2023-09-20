Return-Path: <virtio-dev-return-13871-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0222CE79CB
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 11:11:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EB8762AD67
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 11:11:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1B5698667C
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 11:11:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8C2D3986669; Wed, 20 Sep 2023 11:11:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C65E98666A
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 11:11:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="379076370"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208,217";a="379076370"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="920244216"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208,217";a="920244216"
Content-Type: multipart/alternative;
 boundary="------------Z4VIngHpbxStoL01a8htve5T"
Message-ID: <a009e6ec-4bea-d1c3-afbc-b65321341514@intel.com>
Date: Wed, 20 Sep 2023 19:11:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>
References: <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <PH0PR12MB5481E94B590F6696F2A23028DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c81dc719-1abf-ff56-1c1b-07536d197354@intel.com>
 <PH0PR12MB5481F731EF62DB5CCE777918DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <84b2f6b0-c4fb-9b28-53ab-cc8c0b6763c2@intel.com>
 <PH0PR12MB5481E1007F900AD9C2E52E1DDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481E1007F900AD9C2E52E1DDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

--------------Z4VIngHpbxStoL01a8htve5T
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/2023 5:52 PM, Parav Pandit wrote:
>
> Hi Lingshan,
>
> Last two email replies in non-next format are getting hard to follow.
>
> Can you please revert back to have text-based emails?
>
> When one wants to use PF for the live migration in trusted hypervisor, 
> PF is in the trust zone.
>
even without live migration, it can be an attacking surface while guest 
running.
As repeated for many times, it can be used by malicious SW to dump guest 
memory
>
> In future when hypervisor is not trusted, the task of LM will be 
> delegated to other infrastructure TVM.
>
> Ravi at Intel already explained this a year ago using migration TD.
>
> This fits very well without bifurcating the member device which is 
> extremely hard.
>
TD, TDX or TDX-IO are more complex topics, and we should
focus on our live migration solution, not CC.

My point is: using bar cap as a proxy for admin vq based LM is still 
problematic.

Maybe we can close this.
>
> Parav
>
> *From:* Zhu, Lingshan <lingshan.zhu@intel.com>
> *Sent:* Wednesday, September 20, 2023 3:15 PM
> *To:* Parav Pandit <parav@nvidia.com>; Michael S. Tsirkin <mst@redhat.com>
> *Cc:* virtio-dev@lists.oasis-open.org; Jason Wang <jasowang@redhat.com>
> *Subject:* Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND 
> bit and vq state
>
> On 9/20/2023 4:34 PM, Parav Pandit wrote:
>
>     @font-face {font-family:"Cambria Math"; panose-1:2 4 5 3 5 4 6 3 2
>     4;}@font-face {font-family:Calibri; panose-1:2 15 5 2 2 2 4 3 2
>     4;}@font-face {font-family:Consolas; panose-1:2 11 6 9 2 2 4 3 2
>     4;}p.MsoNormal, li.MsoNormal, div.MsoNormal {margin:0in;
>     font-size:11.0pt; font-family:"Calibri",sans-serif;}a:link,
>     span.MsoHyperlink {mso-style-priority:99; color:blue;
>     text-decoration:underline;}pre {mso-style-priority:99;
>     mso-style-link:"HTML Preformatted Char"; margin:0in;
>     margin-bottom:.0001pt; font-size:10.0pt; font-family:"Courier
>     New";}span.HTMLPreformattedChar {mso-style-name:"HTML Preformatted
>     Char"; mso-style-priority:99; mso-style-link:"HTML Preformatted";
>     font-family:Consolas;}span.fontstyle0
>     {mso-style-name:fontstyle0;}span.EmailStyle21
>     {mso-style-type:personal-reply; font-family:"Calibri",sans-serif;
>     color:windowtext;}.MsoChpDefault {mso-style-type:export-only;
>     font-size:10.0pt; mso-ligatures:none;}div.WordSection1
>     {page:WordSection1;}
>
>     > There can be malicious SW on the host, and the host may be hacked
>     and compromised.
>     > For example:
>     > 1) SUSPEND the a running guest by admin vq
>     > 2) dumping guest memory through admin vq dirty page tracking.
>
>
>     No. hypervisor is trusted entity who is hosting the VM.
>
> The PF may not owned by the hypervisor and the host can be hacked and 
> computerized.
>
>     The device migration is initiated by the hypervisor.
>
>     I am omitting the TDISP question for now as talked before.
>
>     TDISP spec will evolve for hypercalls when we get there.
>
> Confidential computing is out of the spec, as we discussed and agreed.
>
> This is to demonstrate why even using a bar cap as proxy for admin vq 
> LM is still problematic.
> TDISP gives examples of the attacking models, and admin vq based LM
> conforms to the models.
>
>     *From:*virtio-dev@lists.oasis-open.org
>     <virtio-dev@lists.oasis-open.org>
>     <mailto:virtio-dev@lists.oasis-open.org> *On Behalf Of *Zhu, Lingshan
>     *Sent:* Wednesday, September 20, 2023 12:01 PM
>     *To:* Parav Pandit <parav@nvidia.com> <mailto:parav@nvidia.com>;
>     Michael S. Tsirkin <mst@redhat.com> <mailto:mst@redhat.com>
>     *Cc:* virtio-dev@lists.oasis-open.org; Jason Wang
>     <jasowang@redhat.com> <mailto:jasowang@redhat.com>
>     *Subject:* Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce
>     SUSPEND bit and vq state
>
>     On 9/20/2023 2:08 PM, Parav Pandit wrote:
>
>           
>
>             From: Zhu, Lingshan<lingshan.zhu@intel.com>  <mailto:lingshan.zhu@intel.com>
>
>             Sent: Wednesday, September 20, 2023 11:36 AM
>
>               
>
>             On 9/19/2023 2:49 AM, Michael S. Tsirkin wrote:
>
>                 On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:
>
>                         Please refer to the code for setting FEATURES_OK.
>
>                     It wont work when one needs to suspend the device.
>
>                     There is no point of doing such work over registers as fundamental
>
>             framework is over the AQ.
>
>                 Well not really. It's over admin commands. When these were built the
>
>                 intent always was that it's possible to use admin commands through
>
>                 another interface, other than admin queue. Is there a problem
>
>                 implementing admin commands over a memory BAR? For example, I can see
>
>                 an "admin command" capability pointing at a BAR where commands are
>
>                 supplied, and using a new group type referring to device itself.
>
>             I am not sure, if a bar cap would be implemented as a proxy for the admin vq
>
>             based live migration. then the problems of admin vq LM that we have discussed
>
>             still exist. the bar is only a proxy, doesn't fix anything. and even larger side
>
>             channel attacking surface: vf-->pf-->vf
>
>           
>
>         AQ LM using PF has no side channel attack as hypervisor and owner device is trusted entity as already discussed.
>
>     I believe we have discussed this for many times, and I even
>     provide you some examples.
>
>     Let me repeat for the last time.
>
>     There can be malicious SW on the host, and the host may be hacked
>     and compromised.
>     For example:
>     1) SUSPEND the a running guest by admin vq
>     2) dumping guest memory through admin vq dirty page tracking.
>
>     These above can happen right?
>
>     You made TDISP as an example, but have you really read the TDISP spec?
>     In the spec:
>
>     Device Security Architecture - Administrative interfaces (e.g., a
>     PF) may be
>     used to influence the security properties of the TDI used by the TVM.
>
>     TEE-I/O requires the device to organize its hardware/software
>     interfaces such that the PF cannot
>     be used to affect the security of a TDI when it is in use by a TVM
>
>     Clear?
>
>
>           
>

--------------Z4VIngHpbxStoL01a8htve5T
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <font face="monospace">On 9/20/2023 5:52 PM, Parav Pandit wrote:</font><br>
    <blockquote type="cite"
cite="mid:PH0PR12MB5481E1007F900AD9C2E52E1DDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.fontstyle0
	{mso-style-name:fontstyle0;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal">Hi Lingshan,<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Last two email replies in non-next format
          are getting hard to follow.<o:p></o:p></p>
        <p class="MsoNormal">Can you please revert back to have
          text-based emails?<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">When one wants to use PF for the live
          migration in trusted hypervisor, PF is in the trust zone.</p>
      </div>
    </blockquote>
    <font face="monospace">even without live migration, it can be an
      attacking surface while guest running.<br>
      As repeated for many times, it can be used by malicious SW to dump
      guest memory<br>
    </font>
    <blockquote type="cite"
cite="mid:PH0PR12MB5481E1007F900AD9C2E52E1DDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">In future when hypervisor is not trusted,
          the task of LM will be delegated to other infrastructure TVM.<o:p></o:p></p>
        <p class="MsoNormal">Ravi at Intel already explained this a year
          ago using migration TD.<o:p></o:p></p>
        <p class="MsoNormal">This fits very well without bifurcating the
          member device which is extremely hard.</p>
      </div>
    </blockquote>
    <font face="monospace">TD, TDX or TDX-IO are more complex topics,
      and we should<br>
      focus on our live migration solution, not CC.<br>
      <br>
      My point is: using bar cap as a proxy for admin vq based LM is
      still problematic.<br>
      <br>
      Maybe we can close this. <br>
    </font>
    <blockquote type="cite"
cite="mid:PH0PR12MB5481E1007F900AD9C2E52E1DDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Parav<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0in
          0in 0in 4.0pt">
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b>From:</b> Zhu, Lingshan
                <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a> <br>
                <b>Sent:</b> Wednesday, September 20, 2023 3:15 PM<br>
                <b>To:</b> Parav Pandit <a class="moz-txt-link-rfc2396E" href="mailto:parav@nvidia.com">&lt;parav@nvidia.com&gt;</a>;
                Michael S. Tsirkin <a class="moz-txt-link-rfc2396E" href="mailto:mst@redhat.com">&lt;mst@redhat.com&gt;</a><br>
                <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev@lists.oasis-open.org">virtio-dev@lists.oasis-open.org</a>; Jason Wang
                <a class="moz-txt-link-rfc2396E" href="mailto:jasowang@redhat.com">&lt;jasowang@redhat.com&gt;</a><br>
                <b>Subject:</b> Re: [virtio-dev] Re: [PATCH 0/5] virtio:
                introduce SUSPEND bit and vq state<o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal" style="margin-bottom:12.0pt"><o:p> </o:p></p>
          <div>
            <p class="MsoNormal"><span style="font-family: &quot;Courier
                New&quot;;">On 9/20/2023 4:34 PM, Parav Pandit wrote:</span><o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"><span style="font-family: &quot;Courier
                New&quot;;">@font-face {font-family:"Cambria Math";
                panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
                {font-family:Calibri; panose-1:2 15 5 2 2 2 4 3 2
                4;}@font-face {font-family:Consolas; panose-1:2 11 6 9 2
                2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
                {margin:0in; font-size:11.0pt;
                font-family:"Calibri",sans-serif;}a:link,
                span.MsoHyperlink {mso-style-priority:99; color:blue;
                text-decoration:underline;}pre {mso-style-priority:99;
                mso-style-link:"HTML Preformatted Char"; margin:0in;
                margin-bottom:.0001pt; font-size:10.0pt;
                font-family:"Courier New";}span.HTMLPreformattedChar
                {mso-style-name:"HTML Preformatted Char";
                mso-style-priority:99; mso-style-link:"HTML
                Preformatted"; font-family:Consolas;}span.fontstyle0
                {mso-style-name:fontstyle0;}span.EmailStyle21
                {mso-style-type:personal-reply;
                font-family:"Calibri",sans-serif;
                color:windowtext;}.MsoChpDefault
                {mso-style-type:export-only; font-size:10.0pt;
                mso-ligatures:none;}div.WordSection1
                {page:WordSection1;}</span>
              <o:p></o:p></p>
            <div>
              <p class="MsoNormal"
                style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span
                  style="font-family: &quot;Courier New&quot;;">&gt;
                  There can be malicious SW on the host, and the host
                  may be hacked and compromised.<br>
                  &gt; For example:<br>
                  &gt; 1) SUSPEND the a running guest by admin vq<br>
                  &gt; 2) dumping guest memory through admin vq dirty
                  page tracking.<br>
                  <br>
                  <br>
                </span><o:p></o:p></p>
              <p class="MsoNormal"
                style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span
                  style="font-family: &quot;Courier New&quot;;">No.
                  hypervisor is trusted entity who is hosting the VM.</span><o:p></o:p></p>
            </div>
          </blockquote>
          <p class="MsoNormal"><span style="font-family: &quot;Courier
              New&quot;;">The PF may not owned by the hypervisor and the
              host can be hacked and computerized.
            </span><br>
            <br>
            <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <div>
              <p class="MsoNormal"
                style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span
                  style="font-family: &quot;Courier New&quot;;">The
                  device migration is initiated by the hypervisor.</span><o:p></o:p></p>
              <p class="MsoNormal"
                style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span
                  style="font-family: &quot;Courier New&quot;;"> </span><o:p></o:p></p>
              <p class="MsoNormal"
                style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span
                  style="font-family: &quot;Courier New&quot;;">I am
                  omitting the TDISP question for now as talked before.</span><o:p></o:p></p>
              <p class="MsoNormal"
                style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span
                  style="font-family: &quot;Courier New&quot;;">TDISP
                  spec will evolve for hypercalls when we get there.</span><o:p></o:p></p>
            </div>
          </blockquote>
          <p class="MsoNormal"><span style="font-family: &quot;Courier
              New&quot;;">Confidential computing is out of the spec, as
              we discussed and agreed.<br>
              <br>
              This is to demonstrate why even using a bar cap as proxy
              for admin vq LM is still problematic. 
              <br>
              TDISP gives examples of the attacking models, and admin vq
              based LM<br>
              conforms to the models.<br>
              <br>
            </span><o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <div>
              <p class="MsoNormal"
                style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span
                  style="font-family: &quot;Courier New&quot;;"> </span><o:p></o:p></p>
              <div>
                <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0in 0in 0in">
                  <p class="MsoNormal"
                    style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><b><span
                        style="font-family: &quot;Courier New&quot;;">From:</span></b><span
                      style="font-family: &quot;Courier New&quot;;">
                      <a href="mailto:virtio-dev@lists.oasis-open.org"
                        moz-do-not-send="true"
                        class="moz-txt-link-freetext">virtio-dev@lists.oasis-open.org</a>
                      <a href="mailto:virtio-dev@lists.oasis-open.org"
                        moz-do-not-send="true">&lt;virtio-dev@lists.oasis-open.org&gt;</a>
                      <b>On Behalf Of </b>Zhu, Lingshan<br>
                      <b>Sent:</b> Wednesday, September 20, 2023 12:01
                      PM<br>
                      <b>To:</b> Parav Pandit <a
                        href="mailto:parav@nvidia.com"
                        moz-do-not-send="true">&lt;parav@nvidia.com&gt;</a>;
                      Michael S. Tsirkin
                      <a href="mailto:mst@redhat.com"
                        moz-do-not-send="true">&lt;mst@redhat.com&gt;</a><br>
                      <b>Cc:</b> <a
                        href="mailto:virtio-dev@lists.oasis-open.org"
                        moz-do-not-send="true"
                        class="moz-txt-link-freetext">virtio-dev@lists.oasis-open.org</a>;
                      Jason Wang
                      <a href="mailto:jasowang@redhat.com"
                        moz-do-not-send="true">&lt;jasowang@redhat.com&gt;</a><br>
                      <b>Subject:</b> Re: [virtio-dev] Re: [PATCH 0/5]
                      virtio: introduce SUSPEND bit and vq state</span><o:p></o:p></p>
                </div>
              </div>
              <p class="MsoNormal"
                style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span
                  style="font-family: &quot;Courier New&quot;;"> </span><o:p></o:p></p>
              <p class="MsoNormal"
                style="mso-margin-top-alt:auto;margin-bottom:12.0pt"><span
                  style="font-family: &quot;Courier New&quot;;"> </span><o:p></o:p></p>
              <div>
                <p class="MsoNormal"
                  style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span
                    style="font-family: &quot;Courier New&quot;;">On
                    9/20/2023 2:08 PM, Parav Pandit wrote:</span><o:p></o:p></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre> <o:p></o:p></pre>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <pre>From: Zhu, Lingshan <a href="mailto:lingshan.zhu@intel.com" moz-do-not-send="true">&lt;lingshan.zhu@intel.com&gt;</a><o:p></o:p></pre>
                  <pre>Sent: Wednesday, September 20, 2023 11:36 AM<o:p></o:p></pre>
                  <pre> <o:p></o:p></pre>
                  <pre>On 9/19/2023 2:49 AM, Michael S. Tsirkin wrote:<o:p></o:p></pre>
                  <blockquote
                    style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <pre>On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:<o:p></o:p></pre>
                    <blockquote
                      style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <blockquote
                        style="margin-top:5.0pt;margin-bottom:5.0pt">
                        <pre>Please refer to the code for setting FEATURES_OK.<o:p></o:p></pre>
                      </blockquote>
                      <pre>It wont work when one needs to suspend the device.<o:p></o:p></pre>
                      <pre>There is no point of doing such work over registers as fundamental<o:p></o:p></pre>
                    </blockquote>
                  </blockquote>
                  <pre>framework is over the AQ.<o:p></o:p></pre>
                  <blockquote
                    style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <pre>Well not really. It's over admin commands. When these were built the<o:p></o:p></pre>
                    <pre>intent always was that it's possible to use admin commands through<o:p></o:p></pre>
                    <pre>another interface, other than admin queue. Is there a problem<o:p></o:p></pre>
                    <pre>implementing admin commands over a memory BAR? For example, I can see<o:p></o:p></pre>
                    <pre>an "admin command" capability pointing at a BAR where commands are<o:p></o:p></pre>
                    <pre>supplied, and using a new group type referring to device itself.<o:p></o:p></pre>
                  </blockquote>
                  <pre>I am not sure, if a bar cap would be implemented as a proxy for the admin vq<o:p></o:p></pre>
                  <pre>based live migration. then the problems of admin vq LM that we have discussed<o:p></o:p></pre>
                  <pre>still exist. the bar is only a proxy, doesn't fix anything. and even larger side<o:p></o:p></pre>
                  <pre>channel attacking surface: vf--&gt;pf--&gt;vf<o:p></o:p></pre>
                </blockquote>
                <pre> <o:p></o:p></pre>
                <pre>AQ LM using PF has no side channel attack as hypervisor and owner device is trusted entity as already discussed.<o:p></o:p></pre>
              </blockquote>
              <p class="MsoNormal"
                style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span
                  style="font-family: &quot;Courier New&quot;;">I
                  believe we have discussed this for many times, and I
                  even provide you some examples.<br>
                  <br>
                  Let me repeat for the last time.<br>
                  <br>
                  There can be malicious SW on the host, and the host
                  may be hacked and compromised.<br>
                  For example:<br>
                  1) SUSPEND the a running guest by admin vq<br>
                  2) dumping guest memory through admin vq dirty page
                  tracking.<br>
                  <br>
                  These above can happen right? <br>
                  <br>
                  You made TDISP as an example, but have you really read
                  the TDISP spec?<br>
                  In the spec:<br>
                  <br>
                  <span class="fontstyle0">Device Security Architecture
                    - Administrative interfaces (e.g., a PF) may be</span><br>
                  <span class="fontstyle0">used to influence the
                    security properties of the TDI used by the TVM.</span><br>
                  <br>
                  TEE-I/O requires the device to organize its
                  hardware/software interfaces such that the PF cannot<br>
                  be used to affect the security of a TDI when it is in
                  use by a TVM<br>
                  <br>
                  Clear?<br>
                  <br>
                  <br>
                </span><o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre> <o:p></o:p></pre>
              </blockquote>
              <div style="border:none;border-left:solid blue
                1.5pt;padding:0in 0in 0in 4.0pt">
                <p class="MsoNormal"
                  style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span
                    style="font-family: &quot;Courier New&quot;;"> </span><o:p></o:p></p>
              </div>
            </div>
          </blockquote>
          <p class="MsoNormal"><o:p> </o:p></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------Z4VIngHpbxStoL01a8htve5T--
