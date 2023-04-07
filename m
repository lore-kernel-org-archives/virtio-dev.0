Return-Path: <virtio-dev-return-12048-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562B8C76196
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 02:02:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B2B7C370EE
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 02:02:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A98709865F0
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 02:02:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9DFBC9865DE; Fri,  7 Apr 2023 02:02:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83D019865D7;
	Fri,  7 Apr 2023 02:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="341646951"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="341646951"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="798555795"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="798555795"
Message-ID: <fc449c23-9fd0-e6a4-b147-458b874ed3c8@intel.com>
Date: Fri, 7 Apr 2023 10:01:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
To: Parav Pandit <parav@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
 "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
 "hang.yuan@intel.com" <hang.yuan@intel.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
 Jiri Pirko <jiri@nvidia.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1680533760.git.mst@redhat.com>
 <84cf421ad95111b37cddb52b2a7bf625b7955ae6.1680533760.git.mst@redhat.com>
 <0149d88a-196b-0bdc-32b4-1e01eb562310@linux.intel.com>
 <PH0PR12MB548174BC1333E7107B731108DC919@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB548174BC1333E7107B731108DC919@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v11 08/10] admin: command list discovery



On 4/6/2023 10:05 PM, Parav Pandit wrote:
>
>> From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
>> Sent: Thursday, April 6, 2023 3:20 AM
> I have a dumb question.
> Zhu responded to these patches.
> Some patches have prefix appended as "virtio", some has "virtio-dev", and some have "virtio-comment".
> Whichever tool is adding it prefix, why it cannot keep the simple consistency?
>
> Do we need to ask OASIS about it?
one of the reasons is that I subscribed virtio, virtio-comment and 
virtio-dev, and these threads list are all in the to or cc recipients.

I agree OASIS mailing server sometimes behave oddly, it is reliable most 
of the time, but I didn't receive any direct emails from you about
the virtio-net Sub-TC proposal, but I can receive emails from Stefan. 
That's odd, I should see all your emails via virtio@list.oasis-open.org.
>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

