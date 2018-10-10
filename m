Return-Path: virtio-dev-return-4890-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 82B93985CA2
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Oct 2018 14:43:49 +0000 (UTC)
Date: Wed, 10 Oct 2018 10:43:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181010104221-mutt-send-email-mst@kernel.org>
References: <20180919230502-mutt-send-email-mst@kernel.org>
 <CADGSJ22OybVCOsBmqdAHLPBU0PKF13xWz3YtHT=Pw5bT_a71BA@mail.gmail.com>
 <20180920220951-mutt-send-email-mst@kernel.org>
 <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
 <20180927121739-mutt-send-email-mst@kernel.org>
 <CADGSJ22JC9asjQ3nVV5e-ajxB-pggJ6ToMGqG072Q5TvFVCKBQ@mail.gmail.com>
 <20181002083928-mutt-send-email-mst@kernel.org>
 <CADGSJ23NaaPXrgoL1-ySs=SWytE65SORatOFMSapzFsKZUH4yA@mail.gmail.com>
 <20181005101419-mutt-send-email-mst@kernel.org>
 <CAKPgXcF6vu-O5wDRmK+-4cFQH1w7exEUtMuMvxkgUVeXt=Punw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPgXcF6vu-O5wDRmK+-4cFQH1w7exEUtMuMvxkgUVeXt=Punw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Sameeh Jubran <sameeh@daynix.com>
Cc: Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, sridhar.samudrala@intel.com, virtio-dev <virtio-dev@lists.oasis-open.org>, ehabkost@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 09, 2018 at 01:06:59AM +0300, Sameeh Jubran wrote:
> Hi All,
> 
> I have been busy trying to figure out how to implement the feature and
> got very confused with the current open questions and tier impact.
> 
> As I have stated earlier, I thought about doing the following:
> 
> 1 - Have an id for virtio-net (the standby device) and one for the
> vfio device (primary).
> 2 - On realize of virtio-net check for the existence of the primary
> device and hide the standby feature.
> 3 - Once the feature is acked by the guest, the device would be
> plugged back by virtio-net.
> 
> I've faced few issues when I tried to implement this which I overcame.
> At the end of the email I've included a prototype which implements
> this basic functionality using e1000 instead of vfio net device, I'm
> sharing this as a draft only (it has many flaws) as parts of it are
> valid for the actual implementation.
> 
> Issues that I've faced:
> 
> * I've used a device_listener callbacks it get the device to register
> itself for virtio-net. This makes virtio-net listen to the realization
> of the device. I don't think this approach is right, as it makes the
> virtio-net listen to every device which can be avoided by extending
> the current implementation of the device listner, Moreover, this
> doesn't solve the migration issues, as far as I understand, the
> realize function doesn't get called after the migration process which
> means this doesn't work. (correct me if I'm wrong)
> 
> * When testing with PC machine type which uses the PIIX4 as the
> hotplug handler, the hotplug handler get's set after the virtio-net
> and e1000 device has been realized. This means that I can't save the
> hotplug handler before detaching the device which means I can't plug
> it back as when the device is unplugged it is unattached from it's
> parent bus. This was resolved by saving a pointer to the parent bus
> instead and when attempting to replug the device then the parent can
> be used to get the hotplug handler. Note that unplugging the device
> using "qdev_simple_device_unplug_cb" doesn't require the hotplug
> handler as this function simply detaches the device object from it's
> parent object (the pci bus).
> 
> I've talked to Eduardo and he mentioned that he and Michael had
> discussed the following approach: using a property (for pci devices
> currently and maybe for others in the future?) which tells Qemu to
> hide the device from the bus upon init. This approach leaves the
> responsibility of managing the failover device to the management. The
> management can send commands to plug the hidden device or hide it back
> as well. I think that I like this approach better as it is proof of
> issues that can come up when trying to handle the failure of
> unplug/plug requests to the guest.
> 
> Please share your thoughts on this approach versus the draft implementation.

I would think just an internal flag on the pci device that
controls whether it's guest visible would be enough.
Not sure why would management need to be involved.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

