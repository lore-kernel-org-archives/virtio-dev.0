Return-Path: <virtio-dev-return-13841-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BD7CE79AD
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 05:59:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E561A2B007
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 05:59:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD5F398666A
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 05:59:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BEDC4986668; Wed, 20 Sep 2023 05:59:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7B0E986662;
	Wed, 20 Sep 2023 05:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="444226201"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="444226201"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="812013672"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="812013672"
Message-ID: <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
Date: Wed, 20 Sep 2023 13:59:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@gmail.com>, Robert Beckett <bob.beckett@collabora.com>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Alex Deucher <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>,
 Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>,
 Huang Rui <Ray.Huang@amd.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230919082802-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg



On 9/19/2023 8:31 PM, Michael S. Tsirkin wrote:
> On Tue, Sep 19, 2023 at 07:42:42PM +0800, Jiqian Chen wrote:
>> When guest vm does S3, Qemu will reset and clear some things of virtio
>> devices, but guest can't aware that, so that may cause some problems.
>> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
>> resume, that function will destroy render resources of virtio-gpu. As
>> a result, after guest resume, the display can't come back and we only
>> saw a black screen. Due to guest can't re-create all the resources, so
>> we need to let Qemu not to destroy them when S3.
>>
>> For above purpose, we need a mechanism that allows guests and QEMU to
>> negotiate their reset behavior. So this patch add a new parameter
>> named freeze_mode to struct virtio_pci_common_cfg. And when guest
>> suspends, it can write freeze_mode to be FREEZE_S3, and then virtio
>> devices can change their reset behavior on Qemu side according to
>> freeze_mode. What's more, freeze_mode can be used for all virtio
>> devices to affect the behavior of Qemu, not just virtio gpu device.
Hi Jiqian,

Have you seen this series: [PATCH 0/5] virtio: introduce SUSPEND bit and 
vq state
https://lore.kernel.org/all/3f4cbf84-010c-cffa-0b70-33c449b5561b@intel.com/T/

We introduced a bit in the device status SUSPEND, when VIRTIO_F_SUSPEND is
negotiated, the driver can set SUSPEND in the device status to suspend the
device.

When SUSPEND, the device should pause its operations and preserve its 
configurations
in its configuration space.

The driver re-write DRIVER_OK to clear SUSPEND, so the device resumes 
running.

This is originally to serve live migration, but I think it can also meet 
your needs.

Thanks,
Zhu Lingshan
>>
>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
>> ---
>>   transport-pci.tex | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/transport-pci.tex b/transport-pci.tex
>> index a5c6719..2543536 100644
>> --- a/transport-pci.tex
>> +++ b/transport-pci.tex
>> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>           le64 queue_desc;                /* read-write */
>>           le64 queue_driver;              /* read-write */
>>           le64 queue_device;              /* read-write */
>> +        le16 freeze_mode;               /* read-write */
>>           le16 queue_notif_config_data;   /* read-only for driver */
>>           le16 queue_reset;               /* read-write */
>>
> we can't add fields in the middle of the structure like this -
> offset of queue_notif_config_data and queue_reset changes.
>
>    
>> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>   \item[\field{queue_device}]
>>           The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>>   
>> +\item[\field{freeze_mode}]
>> +        The driver writes this to set the freeze mode of virtio pci.
>> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
>> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and virtio-pci enters S3 suspension;
>> +        Other values are reserved for future use, like S4, etc.
>> +
> we need to specify these values then.
>
> we also need
> - feature bit to detect support for S3
> - conformance statements documenting behavious under S3
>
>
>>   \item[\field{queue_notif_config_data}]
>>           This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
>>           The driver will use this value when driver sends available buffer
>> -- 
>> 2.34.1
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

