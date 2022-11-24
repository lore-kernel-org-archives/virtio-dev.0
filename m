Return-Path: <virtio-dev-return-10265-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 238BB9864D3
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Nov 2022 12:12:49 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221124031554-mutt-send-email-mst@kernel.org>
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-3-mst@redhat.com>
 <CACGkMEuuHgJ-yZmMAu0L=piUmZa8sY-v7e5FyTrpUSdZML5KUA@mail.gmail.com>
 <20221124020650-mutt-send-email-mst@kernel.org>
 <CACGkMEtF0WLEiDPQw5W7o0f+JvkFSbX++uOc-SPYHsnFMXyJgw@mail.gmail.com>
 <20221124031554-mutt-send-email-mst@kernel.org>
Date: Thu, 24 Nov 2022 13:12:40 +0100
Message-ID: <87h6yoh7pj.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v9 02/10] admin: introduce device group
 and related concepts
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 24 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Nov 24, 2022 at 03:37:42PM +0800, Jason Wang wrote:
>> On Thu, Nov 24, 2022 at 3:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> >
>> > On Thu, Nov 24, 2022 at 01:41:41PM +0800, Jason Wang wrote:
>> > > On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>> > > > +The following group types, and their identifiers, are currently specified):
>> > > > +\begin{description}
>> > > > +\item[SR-IOV group type (0x1)]
>> > > > +This device group has a PCI Single Root I/O Virtualization
>> > > > +(SR-IOV) physical function (PF) device as the owner and includes
>> > > > +all its SR-IOV virtual functions (VFs) as members (see
>> > > > +\hyperref[intro:PCIe]{[PCIe]}).
>> > >
>> > > So I wonder what's the advantage of using a global identifier over the
>> > > transport specific one. There's almost no way for CCW/MMIO to use
>> > > SR-IOV. Limiting it to PCI seems much easier and avoids layer
>> > > violation.
>> > >
>> > > Thanks
>> >
>> > So we burn up an identifier, ccw and mmio won't be able to use it.
>> > Big deal? Why?
>> 
>> Because it is transport specific. The basic facility should be
>> transport independent.
>
> I tried this but the result is spread all over the spec
> and does not result in a readable cohesive whole.
> So we give up on the transport independent purity a bit and it
> seems worth it.
> Also explained this in the cover letter - have you seen that?
>
>
>
>> > And I think we might find a use for this with MMIO
>> > down the road with some kind of passthrough. Who knows.
>> 
>> Probably, but can it be modeled exactly as what SR-IOV looks like? Or
>> anyhow, it's not too late to define this for MMIO at that time. For
>> example, we know MSI-X may work for MMIO but we define it only for PCI
>> now.
>> 
>> Thanks
>
> Right. So if we reserve the id for all transports then it will
> be easy to do.

Also, if we go with transport-specific ids, we might end up with
different ids per transport when we add a future transport-independent
feature. The global id space really should be big enough to accommodate
even single-transport groups.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

