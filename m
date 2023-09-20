Return-Path: <virtio-dev-return-13857-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CBBCE79AC
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 07:45:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9C06477E8C
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 07:45:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90A0D98667D
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 07:45:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 82C2F98666A; Wed, 20 Sep 2023 07:45:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 71908986669;
	Wed, 20 Sep 2023 07:45:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370468079"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="370468079"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="749789384"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="749789384"
Message-ID: <1a2537e9-b70c-0d85-20f5-e8ef5c8a9bb8@intel.com>
Date: Wed, 20 Sep 2023 15:45:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@gmail.com>, Robert Beckett <bob.beckett@collabora.com>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
 <PH0PR12MB5481891053E37A79920991F6DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <91c3e7ec-d702-ee61-c420-59ddc8dac6dc@intel.com>
 <PH0PR12MB548118296F71CBD9158963B0DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB548118296F71CBD9158963B0DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg



On 9/20/2023 3:32 PM, Parav Pandit wrote:
>
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Wednesday, September 20, 2023 12:58 PM
>>
>> On 9/20/2023 3:10 PM, Parav Pandit wrote:
>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>> Sent: Wednesday, September 20, 2023 12:37 PM
>>>>> The problem to overcome in [1] is, resume operation needs to be
>>>>> synchronous
>>>> as it involves large part of context to resume back, and hence just
>>>> asynchronously setting DRIVER_OK is not enough.
>>>>> The sw must verify back that device has resumed the operation and
>>>>> ready to
>>>> answer requests.
>>>> this is not live migration, all device status and other information
>>>> still stay in the device, no need to "resume" context, just resume running.
>>>>
>>> I am aware that it is not live migration. :)
>>>
>>> "Just resuming" involves lot of device setup task. The device implementation
>> does not know for how long a device is suspended.
>>> So for example, a VM is suspended for 6 hours, hence the device context
>> could be saved in a slow disk.
>>> Hence, when the resume is done, it needs to setup things again and driver got
>> to verify before accessing more from the device.
>> The restore procedures should perform by the hypervisor and done before set
>> DRIVER_OK and wake up the guest.
> Which is the signal to trigger the restore? Which is the trigger in physical device when there is no hypervisor?
>
> In my view, setting the DRIVER_OK is the signal regardless of hypervisor or physical device.
> Hence the re-read is must.
Yes, as I said below, should verify by re-read.
>
>> And the hypervisor/driver needs to check the device status by re-reading.
>>>> Like resume from a failed LM.
>>>>> This is slightly different flow than setting the DRIVER_OK for the
>>>>> first time
>>>> device initialization sequence as it does not involve large restoration.
>>>>> So, to merge two ideas, instead of doing DRIVER_OK to resume, the
>>>>> driver
>>>> should clear the SUSPEND bit and verify that it is out of SUSPEND.
>>>>> Because driver is still in _OK_ driving the device flipping the SUSPEND bit.
>>>> Please read the spec, it says:
>>>> The driver MUST NOT clear a device status bit
>>>>
>>> Yes, this is why either DRIER_OK validation by the driver is needed or Jiqian's
>> synchronous new register..
>> so re-read
> Yes. re-read until set, Thanks.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

