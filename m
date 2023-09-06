Return-Path: <virtio-dev-return-13638-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650D8EB8FAD
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 09:37:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A3F4C159D2F
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 09:37:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 935B39865F7
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 09:37:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8368C9865D8; Wed,  6 Sep 2023 09:37:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 719F99865CD;
	Wed,  6 Sep 2023 09:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="380820049"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="380820049"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="741470287"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="741470287"
Message-ID: <87445e65-e8c0-fd09-523f-cc7b0036ef75@intel.com>
Date: Wed, 6 Sep 2023 17:37:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230906043016-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/6/2023 4:32 PM, Michael S. Tsirkin wrote:
> On Wed, Sep 06, 2023 at 04:16:37PM +0800, Zhu Lingshan wrote:
>> This patch adds two new le16 fields to common configuration structure
>> to support VIRTIO_F_QUEUE_STATE in PCI transport layer.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>
> I do not see why this would be pci specific at all.
It is just the implementation is transport specific.
>
> But besides I thought work on live migration will use
> admin queue. This was explicitly one of the motivators.
I assume this straight forward solution can work.
>
> Poking at the device from the driver to migrate it
> is not going to work if the driver lives within guest.
The hypervisor can still set SUSPEND and do other stuffs like
collecting dirty pages.

The process should be freeze the guest first, then suspend the device.
>
>
>
>
>> ---
>>   transport-pci.tex | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/transport-pci.tex b/transport-pci.tex
>> index a5c6719..3161519 100644
>> --- a/transport-pci.tex
>> +++ b/transport-pci.tex
>> @@ -325,6 +325,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>           /* About the administration virtqueue. */
>>           le16 admin_queue_index;         /* read-only for driver */
>>           le16 admin_queue_num;         /* read-only for driver */
>> +
>> +	/* Virtqueue state */
>> +        le16 queue_avail_state;         /* read-write */
>> +        le16 queue_used_state;          /* read-write */
>>   };
>>   \end{lstlisting}
>>   
>> @@ -428,6 +432,17 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>   	The value 0 indicates no supported administration virtqueues.
>>   	This field is valid only if VIRTIO_F_ADMIN_VQ has been
>>   	negotiated.
>> +
>> +\item[\field{queue_avail_state}]
>> +        This field is valid only if VIRTIO_F_QUEUE_STATE has been
>> +        negotiated. The driver sets and gets the available state of
>> +        the virtqueue here (see \ref{sec:Virtqueues / Virtqueue State}).
>> +
>> +\item[\field{queue_used_state}]
>> +        This field is valid only if VIRTIO_F_QUEUE_STATE has been
>> +        negotiated. The driver sets and gets the used state of the
>> +        virtqueue here (see \ref{sec:Virtqueues / Virtqueue State}).
>> +
>>   \end{description}
>>   
>>   \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
>> @@ -488,6 +503,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>   present either a value of 0 or a power of 2 in
>>   \field{queue_size}.
>>   
>> +If VIRTIO_F_QUEUE_STATE has not been negotiated, the device MUST ignore
>> +any accesses to \field{queue_avail_state} and \field{queue_used_state}.
>> +
>>   If VIRTIO_F_ADMIN_VQ has been negotiated, the value
>>   \field{admin_queue_index} MUST be equal to, or bigger than
>>   \field{num_queues}; also, \field{admin_queue_num} MUST be
>> -- 
>> 2.35.3
>>
>>
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>>
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>>
>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> List help: virtio-comment-help@lists.oasis-open.org
>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>> Committee: https://www.oasis-open.org/committees/virtio/
>> Join OASIS: https://www.oasis-open.org/join/
>>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

