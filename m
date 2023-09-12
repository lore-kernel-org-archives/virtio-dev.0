Return-Path: <virtio-dev-return-13680-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCD5CA0EC3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 03:43:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5DD7F66DC8
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 03:43:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 57081986610
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 03:43:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 49E829843C1; Tue, 12 Sep 2023 03:43:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3476A986485;
	Tue, 12 Sep 2023 03:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409221554"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="409221554"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="693338424"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="693338424"
Message-ID: <c045564a-93b4-1f55-2a4c-78e98504a5cd@intel.com>
Date: Tue, 12 Sep 2023 11:43:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, "eperezma@redhat.com"
 <eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <20230911061236-mutt-send-email-mst@kernel.org>
 <CACGkMEsXadEnJoNWtg8wRmuQkL=NXMfzoXzVFPLGgK+PuuG3+Q@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEsXadEnJoNWtg8wRmuQkL=NXMfzoXzVFPLGgK+PuuG3+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/12/2023 11:35 AM, Jason Wang wrote:
> On Mon, Sep 11, 2023 at 6:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Mon, Sep 11, 2023 at 02:30:31PM +0800, Jason Wang wrote:
>>> Customers don't want to have admin stuff, SR-IOV or PASID in the guest
>>> in order to migrate a single virtio device in the nest.
>> Built an alternative facility to implement admin commands then.
> I wonder if it could be built in an efficient way. For example the
> length of admin commands is not fixed and we don't want to grow MMIO
> areas as the admin command, this will result in something like
> VIRTIO_PCI_CAP_PCI_CFG which is sub-optimal (much more registers
> accesses than simply introducing new fields in common cfg).
>
>> The advantage of admin commands is they are nicely contained.
> If it want to be contained it needs to duplicate the functionality of
> the existing facilities like common cfg and others (one example is to
> setup the virtqueue after migration). Otherwise during live migration,
> we will use both admin commands and existing configuration structure
> which will end up with more issues.
>
> As stated before, the best way is to decouple the basic facilities
> (states like index, inflight, dirty page) from a specific
> interface/transport and keep the flexibility at the transport layer.
> Transport layer can choose to stick to the existing interfaces or
> implement the admin commands. So we can have two ways in parallel:
>
> 1) live migration via the existing transport specific facilities, this
> allows us to reuse the existing interfaces with minimal extensions or
> take the advantages of the transport specific facilities like PASID
> 2) live migration via admin commands, but it needs to invent commands
> to access existing facilities which is just a new transport interface
> that LingShan is work (transport over admin commands)
>
> Instead of focusing on a solution that only works for a specific setup
> on a specific transport.
I totally agree
>
> Thanks
>
>> This proposal is way too intrusive.
>>
>> --
>> MST
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

