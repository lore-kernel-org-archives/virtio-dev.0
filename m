Return-Path: <virtio-dev-return-13770-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB608EDE989
	for <virtio-dev@archiver.kernel.org>; Fri, 15 Sep 2023 02:59:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3D4562B37D
	for <virtio-dev@archiver.kernel.org>; Fri, 15 Sep 2023 02:59:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3642698665E
	for <virtio-dev@archiver.kernel.org>; Fri, 15 Sep 2023 02:59:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2538C986659; Fri, 15 Sep 2023 02:59:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15C8D983C27;
	Fri, 15 Sep 2023 02:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="369459042"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="369459042"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="810354039"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="810354039"
Message-ID: <313a60c5-34ac-ca77-b7e1-7cb7eaf11340@intel.com>
Date: Fri, 15 Sep 2023 10:59:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-4-lingshan.zhu@intel.com>
 <20230914072857-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230914072857-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH 3/5] virtqueue: constraints for virtqueue state



On 9/14/2023 7:30 PM, Michael S. Tsirkin wrote:
> On Wed, Sep 06, 2023 at 04:16:35PM +0800, Zhu Lingshan wrote:
>> This commit specifies the constraints of the virtqueue state,
>> and the actions should be taken by the device when SUSPEND
>> and DRIVER_OK is set
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>> ---
>>   content.tex | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index 0fab537..9d727ce 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -594,6 +594,25 @@ \subsection{\field{Used State} Field}
>>   When VIRTIO_RING_F_PACKED is not negotiated, the 16-bit value of \field{used_idx}
>>   is always 0
>>   
>> +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
>> +
>> +If VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKED not been negotiated,
>> +the driver SHOULD NOT access \field{Used State} of any virtqueues, it SHOULD use the
>> +used index in the used ring.
>> +
>> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
>> +
>> +If VIRTIO_F_QUEUE_STATE has been negotiated, the device SHOULD only accept setting
>> +Virtqueue State of any virtqueues when DRIVER_OK is not set in \field{device status},
>> +or both of DRIVER_OK and SUSPEND are set in \field{device status}.
>> +Otherwise the device MUST ignore any writes to Virtqueue State of any virtqueues.
>> +
>> +If VIRTIO_F_QUEUE_STATE have been negotiated, when SUSPEND is set,
>> +the device MUST record the Virtqueue State of every enabled virtqueue
>> +in \field{Available State} and \field{Used State} respectively,
> record how?
This is transport specific, for PCI they are recorded in the common 
config space,
two new fields of them are introduced in patch 5.
>
>> +and correspondingly restore the Virtqueue State of every enabled virtqueue
>> +from \field{Available State} and \field{Used State} when DRIVER_OK is set.
> when is that?
When the DRIVER sets DRIVER_OK and done before the device presents 
DRIVER_OK.
>
>
>> +
>>   \input{admin.tex}
>>   
>>   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>> -- 
>> 2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

