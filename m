Return-Path: <virtio-dev-return-13544-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D190FC04A6A
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 10:53:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EA3F675334
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 10:53:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3E369863EE
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 10:53:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AA2A898633F; Tue, 15 Aug 2023 10:53:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97C6F98634B;
	Tue, 15 Aug 2023 10:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="372248963"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="372248963"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="683616528"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="683616528"
Message-ID: <40b16480-8b59-4b97-a079-33b477fcb37c@intel.com>
Date: Tue, 15 Aug 2023 18:53:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-3-lingshan.zhu@intel.com>
 <20230814144941.GE3146793@fedora>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230814144941.GE3146793@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [RFC PATCH 2/5] virtio: introduce vq state as basic
 facility



On 8/14/2023 10:49 PM, Stefan Hajnoczi wrote:
> On Tue, Aug 15, 2023 at 03:29:01AM +0800, Zhu Lingshan wrote:
>> This patch adds new device facility to save and restore virtqueue
>> state. The virtqueue state is split into two parts:
>>
>> - The available state: The state that is used for read the next
>>    available buffer.
>> - The used state: The state that is used for make buffer used.
>>
>> This will simply the transport specific method implemention. E.g two
>> le16 could be used instead of a single le32). For split virtqueue, we
>> only need the available state since the used state is implemented in
>> the virtqueue itself (the used index). For packed virtqueue, we need
>> both the available state and the used state.
>>
>> Those states are required to implement live migration support for
>> virtio device.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   content.tex | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index 1bb4401..074f43e 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -516,6 +516,68 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>>   types. It is RECOMMENDED that devices generate version 4
>>   UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>>   
>> +\section{Virtqueue State}\label{sec:Virtqueues / Virtqueue State}
>> +
>> +When VIRTIO_F_QUEUE_STATE is negotiated, the driver can set and
>> +get the device internal virtqueue state through the following
>> +fields. The implementation of the interfaces is transport specific.
>> +
>> +\subsection{\field{Available State} Field}
>> +
>> +The available state field is two bytes virtqueue state that is used by
> "two bytes of virtqueue state"
Yes, will fix
>
>> +the device to read the next available buffer.
>> +
>> +When VIRTIO_RING_F_PACKED is not negotiated, it contains:
>> +
>> +\begin{lstlisting}
>> +le16 last_avail_idx;
>> +\end{lstlisting}
>> +
>> +The \field{last_avail_idx} field is the free-running available ring
>> +index where the device will read the next available head of a
>> +descriptor chain.
>> +
>> +See also \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Available Ring}.
>> +
>> +When VIRTIO_RING_F_PACKED is negotiated, it contains:
>> +
>> +\begin{lstlisting}
>> +le16 {
>> +  last_avail_idx : 15;
>> +  last_avail_wrap_counter : 1;
>> +};
>> +\end{lstlisting}
>> +
>> +The \field{last_avail_idx} field is the free-running location
>> +where the device read the next descriptor from the virtqueue descriptor ring.
>> +
>> +The \field{last_avail_wrap_counter} field is the last driver ring wrap
>> +counter that was observed by the device.
>> +
>> +See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Counters}.
>> +
>> +\subsection{\field{Used State} Field}
>> +
>> +The used state field is two bytes of virtqueue state that is used by
>> +the device when marking a buffer used.
> Please specify the non-packed case:
>
> "When VIRTIO_RING_F_PACKED is not negotiated, the 16-bit value is always
> 0."
we did not define the used_state for non-packed vqs in this series.
I will define this in the next version. and Say it is always 0 if 
VIRTIO_F_PACKED is not negotiated.
>
>> +
>> +When VIRTIO_RING_F_PACKED is negotiated, the used state contains:
>> +
>> +\begin{lstlisting}
>> +le16 {
>> +  used_idx : 15;
>> +  used_wrap_counter : 1;
>> +};
>> +\end{lstlisting}
>> +
>> +The \field{used_idx} field is the free-running location where the device write next
> "device writes the next"
Yes, will fix

Thanks
>
>> +used descriptor to the descriptor ring.
>> +
>> +The \field{used_wrap_counter} field is the wrap counter that is used
>> +by the device.
>> +
>> +See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Counters}.
>> +
>>   \input{admin.tex}
>>   
>>   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
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

