Return-Path: <virtio-dev-return-13549-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB365C001B0
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 11:31:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 29F857908A
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 11:31:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 169D69863B2
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 11:31:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0A05898633F; Tue, 15 Aug 2023 11:31:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ECB5598634B;
	Tue, 15 Aug 2023 11:31:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="436152468"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436152468"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="710680265"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="710680265"
Message-ID: <3f5e34be-9c6d-cf83-96b8-ef8660962727@intel.com>
Date: Tue, 15 Aug 2023 19:31:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-6-lingshan.zhu@intel.com>
 <20230814151820.GH3146793@fedora>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230814151820.GH3146793@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] [RFC PATCH 5/5] virtio-pci:
 implement VIRTIO_F_QUEUE_STATE



On 8/14/2023 11:18 PM, Stefan Hajnoczi wrote:
> On Tue, Aug 15, 2023 at 03:29:04AM +0800, Zhu Lingshan wrote:
>> This patch adds two new le16 fields to common configruation structure
>> to support VIRTIO_F_QUEUE_STATE in PCI tranport layer.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   transport-pci.tex | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/transport-pci.tex b/transport-pci.tex
>> index a5c6719..d9bccb0 100644
>> --- a/transport-pci.tex
>> +++ b/transport-pci.tex
>> @@ -321,6 +321,8 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>           le64 queue_device;              /* read-write */
>>           le16 queue_notif_config_data;   /* read-only for driver */
>>           le16 queue_reset;               /* read-write */
>> +        le16 queue_avail_state;         /* read-write */
>> +        le16 queue_used_state;          /* read-write */
>>   
>>           /* About the administration virtqueue. */
>>           le16 admin_queue_index;         /* read-only for driver */
> This is an incompatible change to the register layout. Please add new
> registers at the end of struct virtio_pci_common_cfg so field offsets
> don't change for existing drivers and devices.
Oh yes, I missed that, thanks
>> @@ -415,6 +417,16 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>           This field exists only if VIRTIO_F_RING_RESET has been
>>           negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>>   
>> +\item[\field{queue_avail_state}]
>> +        This field is vaild only if VIRTIO_F_QUEUE_STATE has been
> "valid"
yes
>
>> +        negotiated. The driver sets and gets the available state of
>> +        the virtqueue here (see \ref{sec:Virtqueues / Virtqueue State}).
>> +
>> +\item[\field{queue_used_state}]
>> +        This field is vaild only if VIRTIO_F_QUEUE_STATE has been
> "valid"
yes
>
>> +        negotiated. The driver sets and gets the used state of the
>> +        virtqueue here (see \ref{sec:Virtqueues / Virtqueue State}).
>> +
>>   \item[\field{admin_queue_index}]
>>           The device uses this to report the index of the first administration virtqueue.
>>           This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
>> @@ -488,6 +500,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>   present either a value of 0 or a power of 2 in
>>   \field{queue_size}.
>>   
>> +If VIRTIO_F_QUEUE_STATE has not been negotiated, the device MUST ignore
>> +any accesses against \field{queue_avail_state} and \field{queue_used_state}.
> "accesses to"
Yes, thanks for your review
>
>> +
>>   If VIRTIO_F_ADMIN_VQ has been negotiated, the value
>>   \field{admin_queue_index} MUST be equal to, or bigger than
>>   \field{num_queues}; also, \field{admin_queue_num} MUST be
>> -- 
>> 2.35.3
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

