Return-Path: <virtio-dev-return-14007-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8018CDB482
	for <virtio-dev@archiver.kernel.org>; Fri, 13 Oct 2023 10:24:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CEC7788E09
	for <virtio-dev@archiver.kernel.org>; Fri, 13 Oct 2023 10:24:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6360986841
	for <virtio-dev@archiver.kernel.org>; Fri, 13 Oct 2023 10:24:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B941F9865D9; Fri, 13 Oct 2023 10:24:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9BB9986836;
	Fri, 13 Oct 2023 10:24:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="375499565"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="375499565"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="731318391"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="731318391"
Message-ID: <321167d3-aaff-4a7e-89c1-2371e2d5a64e@intel.com>
Date: Fri, 13 Oct 2023 18:23:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Jason Wang <jasowang@redhat.com>, "eperezma@redhat.com"
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <PH0PR12MB5481C57B255B0D5EA6FB109DDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ddbd47c8-6985-2d08-bf98-0e7516f0c3c4@intel.com>
 <20230926064201-mutt-send-email-mst@kernel.org>
 <305d9907-9668-d362-1ff2-49a5e9f90e42@intel.com>
 <20230927113510-mutt-send-email-mst@kernel.org>
 <558fe3d6-0b81-4def-7256-52ac3cbffa8f@intel.com>
 <20231011061508-mutt-send-email-mst@kernel.org>
 <373821b2-1a1e-3bf3-51dc-8af54db85d00@intel.com>
 <20231012054804-mutt-send-email-mst@kernel.org>
 <ce8a8000-8ed8-66fc-71f9-db560975c100@intel.com>
 <20231012101046-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20231012101046-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH 0/5] virtio:
 introduce SUSPEND bit and vq state



On 10/12/2023 10:38 PM, Michael S. Tsirkin wrote:
> On Thu, Oct 12, 2023 at 06:49:51PM +0800, Zhu, Lingshan wrote:
>> For PCI based configuration, like MSI, we need to fetch from config space
>> anyway.
>> For others like dirty page, we can store the bitmap in host memory, and use
>> PASID for isolation.
> Ok. So how a about a simple interface along the lines of
> u64 cmd_address
> u8 ready_flags:1
>
> For this kind of stuff?
Yes, something like this, log dirty pages in host memory.
The is the draft, not finished yet.

  84 +\begin{lstlisting}
  85 +struct virtio_pci_dity_page_track {
  86 +        u8 enable;               /* Read-Write */
  87 +        u8 gra_power;            /* Read-Write */
  88 +        u8 reserved[2];
  89 +        le32 {
  90 +            pasid: 20;           /* Read-Write */
  91 +            reserved: 12;
  92 +        };
  93 +        le64 bitmap_addr;        /* Read-Write */
  94 +        le64 bitmap_length;      /* Read-Write */
  95 +};
  96 +\end{lstlisting}


>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

