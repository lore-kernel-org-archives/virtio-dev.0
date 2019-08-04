Return-Path: virtio-dev-return-5923-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6BDD985521
	for <virtio-dev@lists.oasis-open.org>; Sun,  4 Aug 2019 22:32:17 +0000 (UTC)
References: <1557600460-18966-1-git-send-email-ndragazis@arrikto.com>
 <20190619145430.GA1232@stefanha-x1.localdomain>
 <20190621164315-mutt-send-email-mst@kernel.org>
 <d37d5a6e-f591-5156-126c-bf9ee07ec4aa@arrikto.com>
 <20190731155659-mutt-send-email-mst@kernel.org>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <f621dc5f-aa35-a1c9-ac5f-0714c76ad394@arrikto.com>
Date: Mon, 5 Aug 2019 01:32:14 +0300
MIME-Version: 1.0
In-Reply-To: <20190731155659-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v3 0/4] introduce virtio vhost-user backend
 device type
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Vangelis Koukis <vkoukis@arrikto.com>, Stojaczyk Dariusz <dariusz.stojaczyk@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 31/7/19 11:19 μ.μ., Michael S. Tsirkin wrote:
> On Wed, Jul 31, 2019 at 05:49:57PM +0300, Nikos Dragazis wrote:
>> On 21/6/19 11:43 μ.μ., Michael S. Tsirkin wrote:
>>> On Wed, Jun 19, 2019 at 03:54:30PM +0100, Stefan Hajnoczi wrote:
>>>> On Sat, May 11, 2019 at 09:47:36PM +0300, Nikos Dragazis wrote:
>>>>> Hi everyone,
>>>>>
>>>>> this PATCH presents an updated version of the RFC virtio device spec for
>>>>> the virtio-vhost-user device. The initial RFC implementation can be
>>>>> found here: [1].
>>>>>
>>>>> This PATCH is split into four parts:
>>>>>
>>>>> 1. the first commit is just a refactored version of the initial RFC
>>>>> implementation [1]. I just moved the device spec into a separate .tex
>>>>> file and changed the device id from #24 to #28 since the ids #24-#27 are
>>>>> reserved.
>>>>>
>>>>> 2. the second commit fixes some minor issues with the device spec. This
>>>>> is quite straightforward.
>>>>>
>>>>> 3. the third commit enhances the notification capability with some
>>>>> device/driver requirements. This makes sense because the notification
>>>>> capability behaves similarly to the MSI-X capability, thereby having
>>>>> some requirements that need to be mentioned.
>>>>>
>>>>> 4. the fourth commit synchronizes the shared memory capability with a
>>>>> recent patch [2] that attempts to standardize a standalone
>>>>> SHARED_MEMORY_CFG virtio capability.
>>>>>
>>>>> v3 changes:
>>>>>  * Device Requirements for the Notification Capability: point out the
>>>>>    difference between the MSI-X Table Size stored in the Message Control
>>>>>    register of the MSI-X capability structure and the actual MSI-X Table
>>>>>    Size
>>>>>
>>>>> v2 changes:
>>>>>  * Change device id from #25 to #28
>>>>>
>>>>> Looking forward to your comments.
>>>> I'm happy with v3.
>>>>
>>>> Any other comments or shall we proceed to a vote?
>>>>
>>>> Stefan
>>> I think we need to wait for shared memory part to be finalized, right?
>>>
>> Michael,
>>
>> given that David's patchset for the shared memory regions has been
>> approved, I think we can start discussing on the spec for the
>> virtio-vhost-user device. A link to the latest version is here: [1].
>>
>> I really think that this device is useful and should be part of the
>> VIRTIO specification. I will submit a fifth version of the patchset soon
>> with some minor changes that seem reasonable to me.
>>
>> Best regards,
>> Nikos
>>
>> [1] https://lists.oasis-open.org/archives/virtio-dev/201906/msg00036.html
> One part I dislike there is "Additional Device Resources over PCI".
> That mostly seems to deal with allocating interrupts.

Actually, it deals with allocating notification addresses (doorbells)
and device interrupts for the vhost-user virtqueues. The
virtio-vhost-user device must be able to handle both its own RX/TX
virtqueues and the vhost-user virtqueues. So, the device must offer
separate notification addresses and interrupt vectors for the vhost-user
virtqueues. We are standardizing these resources with the
VIRTIO_PCI_CAP_DOORBELL_CFG and VIRTIO_PCI_CAP_NOTIFICATION_CFG
configuration structures.

> Can't we (ab)use the virtio pci registers for this?
> Just extend VQ number to VQ/notification number.
>

I am not sure I get your point. But, yes, I think we could use the
existing registers (queue_select, queue_msix_vector, queue_notify_off)
in the common configuration structure for both the device’s virtqueues
and the vhost-user virtqueues. So, for example, we could use indexes 0,
1 for the device’s RX/TX virtqueues and index i+2 for the i-th
vhost-user virtqueue.

However, I don't see why mixing up the configuration of the RX/TX and
the vhost-user virtqueues is a better solution. Wouldn’t it be more
clean if we had separate configuration structures for the device's RX/TX
virtqueues and the vhost-user virtqueues?

--
Nikos

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

