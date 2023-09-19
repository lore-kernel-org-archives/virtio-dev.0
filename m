Return-Path: <virtio-dev-return-13820-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D562CD5492
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:46:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AF1F429FCC
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:46:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B20E9864D1
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:46:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6F8D0983E25; Tue, 19 Sep 2023 07:46:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 602D59864C2
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 07:46:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="360130591"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="360130591"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="739582709"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="739582709"
Message-ID: <474be878-333b-7c80-f116-28b90a3eca4d@intel.com>
Date: Tue, 19 Sep 2023 15:46:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org>
 <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvebT7wWUdEamq0u7d2EOrUsjfdyLW4qu2-78UVs7vj1A@mail.gmail.com>
 <PH0PR12MB54815BB722153D38E8496562DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB54815BB722153D38E8496562DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/19/2023 3:32 PM, Parav Pandit wrote:
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Tuesday, September 19, 2023 9:58 AM
>>
>> On Mon, Sep 18, 2023 at 2:55 PM Parav Pandit <parav@nvidia.com> wrote:
>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>> Sent: Monday, September 18, 2023 12:19 PM
>>>
>>>> so admin vq based LM solution can be a side channel attacking
>>>> surface
>>> It will be part of the DSM whenever it will be used in future.
>>> Hence, it is not attack surface.
>> DSM is not a part of TVM. So it really depends on what kind of work did the
>> admin virtqueue do. For commands that can't be self-contained like
>> provisioning, it is fine, since it is done before the TDI assignment. But it not
>> necessarily for your migration proposal. It seems you've found another case
>> that self-containing is important:
>> allowing the owner to access the member after TDI is attached to TVM is a side
>> channel attack.
> TVM and DSM specs will be extended in future when we get there, so core hypervisor will not be involved.
> With trap+mediation, it is involved.
>
> Lingshan wanted to take this TDISP extension in future.
> So are you both aligned or not yet?
I didn't say that, never ever.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

