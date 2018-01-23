Return-Path: virtio-dev-return-3033-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 406AA58180AD
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Jan 2018 15:01:16 -0800 (PST)
Date: Wed, 24 Jan 2018 01:01:03 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180124010051-mutt-send-email-mst@kernel.org>
References: <20180117203757-mutt-send-email-mst@kernel.org>
 <058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
 <20180117213527-mutt-send-email-mst@kernel.org>
 <CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
 <20180122231713-mutt-send-email-mst@kernel.org>
 <7edf772b-627c-6121-3332-479caed524da@intel.com>
 <20180123020332-mutt-send-email-mst@kernel.org>
 <be3864b4-f108-6a7d-8628-204d4d4ae278@intel.com>
 <20180123035619-mutt-send-email-mst@kernel.org>
 <CAKgT0UfaKG7=E5ciarE3fSUp-Ke-oDNodGe_baEAGbZqWV4Qug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfaKG7=E5ciarE3fSUp-Ke-oDNodGe_baEAGbZqWV4Qug@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
 VIRTIO_NET_F_BACKUP feature bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, achiad shochat <achiad.mellanox@gmail.com>, Achiad Shochat <achiad@mellanox.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 22, 2018 at 07:36:32PM -0800, Alexander Duyck wrote:
> On Mon, Jan 22, 2018 at 6:04 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Mon, Jan 22, 2018 at 05:34:37PM -0800, Samudrala, Sridhar wrote:
> >> On 1/22/2018 4:05 PM, Michael S. Tsirkin wrote:
> >> > On Mon, Jan 22, 2018 at 03:27:40PM -0800, Samudrala, Sridhar wrote:
> >> > > > > You could probably
> >> > > > > even handle the Tx queue selection via a simple eBPF program and map
> >> > > > > since the input for whatever is used to select Tx should be pretty
> >> > > > > simple, destination MAC, source NUMA node, etc, and the data-set
> >> > > > > shouldn't be too large.
> >> > > > That sounds interesting. A separate device might make this kind of setup
> >> > > > a bit easier.  Sridhar, did you look into creating a separate device for
> >> > > > the virtual bond device at all?  It does not have to be in a separate
> >> > > > module, that kind of refactoring can come later, but once we commit to
> >> > > > using the same single device as virtio, we can't change that.
> >> > > No. I haven't looked into creating a separate device. If we are going to
> >> > > create a new
> >> > > device, i guess it has to be of a new device type with its own driver.
> >> > Well not necessarily - just a separate netdev ops.
> >> > Kind of like e.g. vlans share a driver with the main driver.
> >>
> >> Not sure what you meant by vlans sharing a driver with the main driver.
> >> IIUC, vlans are supported via 802.1q driver and  creates a netdev of type
> >> 'vlan'
> >> with vlan_netdev_ops
> >
> > But nothing prevents a single module from registering
> > multiple ops.
> 
> Just to clarify, it seems like what you are suggesting is just adding
> the "master" as a separate set of netdev ops or netdevice and to have
> virtio spawn two network devices, one slave and one master, if the
> BACKUP bit is set. Do I have that right?

Yes, that was my idea.

> I am good with the code still living in the virtio driver and
> consolidation with other similar implementations and further
> improvement could probably happen later as part of some refactor.
> 
> Thanks.
> 
> - Alex


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

