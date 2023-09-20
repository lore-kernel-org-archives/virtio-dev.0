Return-Path: <virtio-dev-return-13844-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AF4CE79AD
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 06:31:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A953A79574
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 06:31:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69F9E986668
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 06:31:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 42F4D986663; Wed, 20 Sep 2023 06:31:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31FB3986667
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 06:31:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370453679"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208,217";a="370453679"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="861854678"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208,217";a="861854678"
Content-Type: multipart/alternative;
 boundary="------------ydjUbhXdEbitpUZod88uaAeK"
Message-ID: <c81dc719-1abf-ff56-1c1b-07536d197354@intel.com>
Date: Wed, 20 Sep 2023 14:31:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>
References: <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
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
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481E94B590F6696F2A23028DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

--------------ydjUbhXdEbitpUZod88uaAeK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/20/2023 2:08 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan<lingshan.zhu@intel.com>
>> Sent: Wednesday, September 20, 2023 11:36 AM
>>
>> On 9/19/2023 2:49 AM, Michael S. Tsirkin wrote:
>>> On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:
>>>>> Please refer to the code for setting FEATURES_OK.
>>>> It wont work when one needs to suspend the device.
>>>> There is no point of doing such work over registers as fundamental
>> framework is over the AQ.
>>> Well not really. It's over admin commands. When these were built the
>>> intent always was that it's possible to use admin commands through
>>> another interface, other than admin queue. Is there a problem
>>> implementing admin commands over a memory BAR? For example, I can see
>>> an "admin command" capability pointing at a BAR where commands are
>>> supplied, and using a new group type referring to device itself.
>> I am not sure, if a bar cap would be implemented as a proxy for the admin vq
>> based live migration. then the problems of admin vq LM that we have discussed
>> still exist. the bar is only a proxy, doesn't fix anything. and even larger side
>> channel attacking surface: vf-->pf-->vf
> AQ LM using PF has no side channel attack as hypervisor and owner device is trusted entity as already discussed.
I believe we have discussed this for many times, and I even provide you 
some examples.

Let me repeat for the last time.

There can be malicious SW on the host, and the host may be hacked and 
compromised.
For example:
1) SUSPEND the a running guest by admin vq
2) dumping guest memory through admin vq dirty page tracking.

These above can happen right?

You made TDISP as an example, but have you really read the TDISP spec?
In the spec:

Device Security Architecture - Administrative interfaces (e.g., a PF) may be
used to influence the security properties of the TDI used by the TVM.

TEE-I/O requires the device to organize its hardware/software interfaces 
such that the PF cannot
be used to affect the security of a TDI when it is in use by a TVM

Clear?

--------------ydjUbhXdEbitpUZod88uaAeK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <font face="monospace"><br>
      <br>
    </font>
    <div class="moz-cite-prefix"><font face="monospace">On 9/20/2023
        2:08 PM, Parav Pandit wrote:<br>
      </font></div>
    <blockquote type="cite"
cite="mid:PH0PR12MB5481E94B590F6696F2A23028DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">From: Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
Sent: Wednesday, September 20, 2023 11:36 AM

On 9/19/2023 2:49 AM, Michael S. Tsirkin wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:
</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Please refer to the code for setting FEATURES_OK.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">It wont work when one needs to suspend the device.
There is no point of doing such work over registers as fundamental
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">framework is over the AQ.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Well not really. It's over admin commands. When these were built the
intent always was that it's possible to use admin commands through
another interface, other than admin queue. Is there a problem
implementing admin commands over a memory BAR? For example, I can see
an "admin command" capability pointing at a BAR where commands are
supplied, and using a new group type referring to device itself.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I am not sure, if a bar cap would be implemented as a proxy for the admin vq
based live migration. then the problems of admin vq LM that we have discussed
still exist. the bar is only a proxy, doesn't fix anything. and even larger side
channel attacking surface: vf--&gt;pf--&gt;vf
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
AQ LM using PF has no side channel attack as hypervisor and owner device is trusted entity as already discussed.</pre>
    </blockquote>
    <font face="monospace">I believe we have discussed this for many
      times, and I even provide you some examples.<br>
      <br>
      Let me repeat for the last time.<br>
      <br>
      There can be malicious SW on the host, and the host may be hacked
      and compromised.<br>
      For example:<br>
      1) SUSPEND the a running guest by admin vq<br>
      2) dumping guest memory through admin vq dirty page tracking.<br>
      <br>
      These above can happen right? <br>
      <br>
      You made TDISP as an example, but have you really read the TDISP
      spec?<br>
      In the spec:<br>
      <br>
      <span class="fontstyle0">Device Security Architecture -
        Administrative interfaces (e.g., a PF) may be<br>
        used to influence the security properties of the TDI used by the
        TVM.</span></font><br>
    <br>
    <font face="monospace">TEE-I/O requires the device to organize its
      hardware/software interfaces such that the PF cannot<br>
      be used to affect the security of a TDI when it is in use by a TVM<br>
      <br>
      Clear?<br style=" font-style: normal; font-variant: normal;
        font-weight: normal; letter-spacing: normal; line-height:
        normal; orphans: 2; text-align: -webkit-auto; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-size-adjust: auto;
        -webkit-text-stroke-width: 0px; ">
    </font>
    <blockquote type="cite"
cite="mid:PH0PR12MB5481E94B590F6696F2A23028DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <font face="monospace"><br>
    </font>
  </body>
</html>

--------------ydjUbhXdEbitpUZod88uaAeK--
