Return-Path: virtio-dev-return-5907-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2187E985BCA
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Jul 2019 14:50:00 +0000 (UTC)
References: <1557600460-18966-1-git-send-email-ndragazis@arrikto.com>
 <20190619145430.GA1232@stefanha-x1.localdomain>
 <20190621164315-mutt-send-email-mst@kernel.org>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <d37d5a6e-f591-5156-126c-bf9ee07ec4aa@arrikto.com>
Date: Wed, 31 Jul 2019 17:49:57 +0300
MIME-Version: 1.0
In-Reply-To: <20190621164315-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v3 0/4] introduce virtio vhost-user backend
 device type
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Vangelis Koukis <vkoukis@arrikto.com>, Stojaczyk Dariusz <dariusz.stojaczyk@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 21/6/19 11:43 μ.μ., Michael S. Tsirkin wrote:
> On Wed, Jun 19, 2019 at 03:54:30PM +0100, Stefan Hajnoczi wrote:
>> On Sat, May 11, 2019 at 09:47:36PM +0300, Nikos Dragazis wrote:
>>> Hi everyone,
>>>
>>> this PATCH presents an updated version of the RFC virtio device spec for
>>> the virtio-vhost-user device. The initial RFC implementation can be
>>> found here: [1].
>>>
>>> This PATCH is split into four parts:
>>>
>>> 1. the first commit is just a refactored version of the initial RFC
>>> implementation [1]. I just moved the device spec into a separate .tex
>>> file and changed the device id from #24 to #28 since the ids #24-#27 are
>>> reserved.
>>>
>>> 2. the second commit fixes some minor issues with the device spec. This
>>> is quite straightforward.
>>>
>>> 3. the third commit enhances the notification capability with some
>>> device/driver requirements. This makes sense because the notification
>>> capability behaves similarly to the MSI-X capability, thereby having
>>> some requirements that need to be mentioned.
>>>
>>> 4. the fourth commit synchronizes the shared memory capability with a
>>> recent patch [2] that attempts to standardize a standalone
>>> SHARED_MEMORY_CFG virtio capability.
>>>
>>> v3 changes:
>>>  * Device Requirements for the Notification Capability: point out the
>>>    difference between the MSI-X Table Size stored in the Message Control
>>>    register of the MSI-X capability structure and the actual MSI-X Table
>>>    Size
>>>
>>> v2 changes:
>>>  * Change device id from #25 to #28
>>>
>>> Looking forward to your comments.
>> I'm happy with v3.
>>
>> Any other comments or shall we proceed to a vote?
>>
>> Stefan
> I think we need to wait for shared memory part to be finalized, right?
>

Michael,

given that David's patchset for the shared memory regions has been
approved, I think we can start discussing on the spec for the
virtio-vhost-user device. A link to the latest version is here: [1].

I really think that this device is useful and should be part of the
VIRTIO specification. I will submit a fifth version of the patchset soon
with some minor changes that seem reasonable to me.

Best regards,
Nikos

[1] https://lists.oasis-open.org/archives/virtio-dev/201906/msg00036.html

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

