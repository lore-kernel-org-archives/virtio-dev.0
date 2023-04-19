Return-Path: <virtio-dev-return-12310-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A298FC6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 08:25:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D9E3723D68
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 08:25:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF07598643A
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 08:25:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C44E298641F; Wed, 19 Apr 2023 08:25:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B10AD98641E;
	Wed, 19 Apr 2023 08:25:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="325004282"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325004282"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="760656756"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="760656756"
Message-ID: <588b201f-8da7-dc6e-d66e-1489914ef051@intel.com>
Date: Wed, 19 Apr 2023 16:25:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
 Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20230411194220.752355-1-parav@nvidia.com>
 <20230411194220.752355-2-parav@nvidia.com>
 <20230419030057-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230419030057-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 1/2] transport-pci: Improve config msix
 vector description



On 4/19/2023 3:05 PM, Michael S. Tsirkin wrote:
> On Tue, Apr 11, 2023 at 10:42:19PM +0300, Parav Pandit wrote:
>> config_msix_vector is the register that holds the MSI-X vector number
>> for receiving configuration change related interrupts.
>>
>> It is not "for MSI-X".
>>
>> Hence, replace the confusing text with appropriate one.
>>
>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> Signed-off-by: Parav Pandit <parav@nvidia.com>
>>
>> ---
>> changelog:
>> v0->v1:
>> - added 'here'
>> - dropped 'receiving'
>> ---
>>   transport-pci.tex | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/transport-pci.tex b/transport-pci.tex
>> index 42be072..cb9fadd 100644
>> --- a/transport-pci.tex
>> +++ b/transport-pci.tex
>> @@ -343,7 +343,8 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>           Driver Feature Bits selected by \field{driver_feature_select}.
>>   
>>   \item[\field{config_msix_vector}]
>> -        The driver sets the Configuration Vector for MSI-X.
>> +        The driver writes an MSI-X vector number here for Configuration change
>> +        interrupts.
> Hmm I think it's "the vector", not an. And the order of words
> is unusual. We also don't normally use "writes here". Would
>
> 	Used by the driver to set the MSI-X vector number for Configuration change interrupts.
>
> be equally acceptable?
Is it better also explain what is a MSI-X vector number here? Like 
saying the offset in the table or the slot number?

Thanks,
Zhu Lingshan
>
>
>>   \item[\field{num_queues}]
>>           The device specifies the maximum number of virtqueues supported here.
>> -- 
>> 2.26.2
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

