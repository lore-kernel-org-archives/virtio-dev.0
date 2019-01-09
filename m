Return-Path: virtio-dev-return-5298-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B6CC985CDD
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Jan 2019 10:29:34 +0000 (UTC)
Message-ID: <5C35CE55.6030200@intel.com>
Date: Wed, 09 Jan 2019 18:35:01 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com> <1546844466-38079-2-git-send-email-wei.w.wang@intel.com> <4ea022d4-6b89-b481-5747-871e154dd21a@de.ibm.com> <5C343688.2060609@intel.com> <20f5fb20-612a-fe37-c5e1-af5ecb98f5d3@de.ibm.com>
In-Reply-To: <20f5fb20-612a-fe37-c5e1-af5ecb98f5d3@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v3 1/3] virtio-balloon: tweak config_changed implementation
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/08/2019 04:46 PM, Christian Borntraeger wrote:
>
> On 08.01.2019 06:35, Wei Wang wrote:
>> On 01/07/2019 09:49 PM, Christian Borntraeger wrote:
>>> On 07.01.2019 08:01, Wei Wang wrote:
>>>> virtio-ccw has deadlock issues with reading the config space inside the
>>>> interrupt context, so we tweak the virtballoon_changed implementation
>>>> by moving the config read operations into the related workqueue contexts.
>>>> The config_read_bitmap is used as a flag to the workqueue callbacks
>>>> about the related config fields that need to be read.
>>>>
>>>> The cmd_id_received is also renamed to cmd_id_received_cache, and
>>>> the value should be obtained via virtio_balloon_cmd_id_received.
>>>>
>>>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>> Together with
>>>     virtio_pci: use queue idx instead of array idx to set up the vq
>>>     virtio: don't allocate vqs when names[i] = NULL
>>>
>>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> OK. I don't plan to send a new version of the above patches as no changes needed so far.
>>
>> Michael, if the above two patches look good to you, please help add the related tested-by
>> and reviewed-by tags. Thanks.
> Can we also make sure that
>
> virtio_pci: use queue idx instead of array idx to set up the vq
> virtio: don't allocate vqs when names[i] = NULL
>
> also land in stable?
>

You could also send the request to stable after it gets merged to Linus' 
tree.
The stable review committee will decide whether to take it.

Please see Option 2:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

