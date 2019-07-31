Return-Path: virtio-dev-return-5910-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C403985D26
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Jul 2019 20:19:30 +0000 (UTC)
Date: Wed, 31 Jul 2019 16:19:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190731155659-mutt-send-email-mst@kernel.org>
References: <1557600460-18966-1-git-send-email-ndragazis@arrikto.com>
 <20190619145430.GA1232@stefanha-x1.localdomain>
 <20190621164315-mutt-send-email-mst@kernel.org>
 <d37d5a6e-f591-5156-126c-bf9ee07ec4aa@arrikto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d37d5a6e-f591-5156-126c-bf9ee07ec4aa@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v3 0/4] introduce virtio vhost-user backend
 device type
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Vangelis Koukis <vkoukis@arrikto.com>, Stojaczyk Dariusz <dariusz.stojaczyk@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 31, 2019 at 05:49:57PM +0300, Nikos Dragazis wrote:
> On 21/6/19 11:43 μ.μ., Michael S. Tsirkin wrote:
> > On Wed, Jun 19, 2019 at 03:54:30PM +0100, Stefan Hajnoczi wrote:
> >> On Sat, May 11, 2019 at 09:47:36PM +0300, Nikos Dragazis wrote:
> >>> Hi everyone,
> >>>
> >>> this PATCH presents an updated version of the RFC virtio device spec for
> >>> the virtio-vhost-user device. The initial RFC implementation can be
> >>> found here: [1].
> >>>
> >>> This PATCH is split into four parts:
> >>>
> >>> 1. the first commit is just a refactored version of the initial RFC
> >>> implementation [1]. I just moved the device spec into a separate .tex
> >>> file and changed the device id from #24 to #28 since the ids #24-#27 are
> >>> reserved.
> >>>
> >>> 2. the second commit fixes some minor issues with the device spec. This
> >>> is quite straightforward.
> >>>
> >>> 3. the third commit enhances the notification capability with some
> >>> device/driver requirements. This makes sense because the notification
> >>> capability behaves similarly to the MSI-X capability, thereby having
> >>> some requirements that need to be mentioned.
> >>>
> >>> 4. the fourth commit synchronizes the shared memory capability with a
> >>> recent patch [2] that attempts to standardize a standalone
> >>> SHARED_MEMORY_CFG virtio capability.
> >>>
> >>> v3 changes:
> >>>  * Device Requirements for the Notification Capability: point out the
> >>>    difference between the MSI-X Table Size stored in the Message Control
> >>>    register of the MSI-X capability structure and the actual MSI-X Table
> >>>    Size
> >>>
> >>> v2 changes:
> >>>  * Change device id from #25 to #28
> >>>
> >>> Looking forward to your comments.
> >> I'm happy with v3.
> >>
> >> Any other comments or shall we proceed to a vote?
> >>
> >> Stefan
> > I think we need to wait for shared memory part to be finalized, right?
> >
> 
> Michael,
> 
> given that David's patchset for the shared memory regions has been
> approved, I think we can start discussing on the spec for the
> virtio-vhost-user device. A link to the latest version is here: [1].
> 
> I really think that this device is useful and should be part of the
> VIRTIO specification. I will submit a fifth version of the patchset soon
> with some minor changes that seem reasonable to me.
> 
> Best regards,
> Nikos
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/201906/msg00036.html

One part I dislike there is "Additional Device Resources over PCI".
That mostly seems to deal with allocating interrupts.
Can't we (ab)use the virtio pci registers for this?
Just extend VQ number to VQ/notification number.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

