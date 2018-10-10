Return-Path: virtio-dev-return-4889-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A14C985CA2
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Oct 2018 14:40:57 +0000 (UTC)
Date: Wed, 10 Oct 2018 10:40:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181010103908-mutt-send-email-mst@kernel.org>
References: <CADGSJ21CujSW=aF7BqdXmSFahLwSgPmG3_KFF5mSeVA5Z8PkQg@mail.gmail.com>
 <20180919230502-mutt-send-email-mst@kernel.org>
 <CADGSJ22OybVCOsBmqdAHLPBU0PKF13xWz3YtHT=Pw5bT_a71BA@mail.gmail.com>
 <20180920220951-mutt-send-email-mst@kernel.org>
 <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
 <20180927121739-mutt-send-email-mst@kernel.org>
 <CADGSJ22JC9asjQ3nVV5e-ajxB-pggJ6ToMGqG072Q5TvFVCKBQ@mail.gmail.com>
 <20181002083928-mutt-send-email-mst@kernel.org>
 <CADGSJ23NaaPXrgoL1-ySs=SWytE65SORatOFMSapzFsKZUH4yA@mail.gmail.com>
 <42b5758f-3507-1d18-8fe1-83661ba0f998@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42b5758f-3507-1d18-8fe1-83661ba0f998@intel.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Siwei Liu <loseweigh@gmail.com>, Venu Busireddy <venu.busireddy@oracle.com>, Cornelia Huck <cohuck@redhat.com>, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 04, 2018 at 10:17:04PM -0700, Samudrala, Sridhar wrote:
> On 10/4/2018 5:03 PM, Siwei Liu wrote:
> > On Tue, Oct 2, 2018 at 5:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Tue, Oct 02, 2018 at 01:42:09AM -0700, Siwei Liu wrote:
> > > > The VF's MAC can be updated by PF/host on the fly at any time. One can
> > > > start with a random MAC but use group ID to pair device instead. And
> > > > only update MAC address to the real one when moving MAC filter around
> > > > after PV says OK to switch datapath.
> > > > 
> > > > Do you see any problem with this design?
> > > Isn't this what I proposed:
> > >          Maybe we can
> > >          start VF with a temporary MAC, then change it to a final one when guest
> > >          tries to use it. It will work but we run into fact that MACs are
> > >          currently programmed by mgmnt - in many setups qemu does not have the
> > >          rights to do it.
> > > 
> > > ?
> > > 
> > > If yes I don't see a problem with the interface design, even though
> > > implementation wise it's more work as it will have to include management
> > > changes.
> > I thought we discussed this design a while back:
> > https://www.spinics.net/lists/netdev/msg512232.html
> > 
> > ... plug in a VF with a random MAC filter programmed in prior, and
> > initially use that random MAC within guest. This would require:
> > a) not relying on permanent MAC address to do pairing during the
> > initial discovery, e.g. use the failover group ID as in this
> > discussion
> > b) host to toggle the MAC address filter: which includes taking down
> > the tap device to return the MAC back to PF, followed by assigning
> > that MAC to VF using "ip link ... set vf ..."
> > c) notify guest to reload/reset VF driver for the change of hardware MAC address
> > d) until VF reloads the driver it won't be able to use the datapath,
> > so very short period of network outage is (still) expected
> > 
> > though I still don't think this design can elimnate downtime. However,
> > it looks like as of today the MAC matching still haven't addressed the
> > datapath switching and error handling in a clean way.
> 
> I am not sure what is the issue with datapath switching with the net_failover solution.
> 
> Do you see any issues with the migration management layer to automate the steps
> that are listed in the example script in the documentation.
> https://www.kernel.org/doc/html/latest/networking/net_failover.html
> 
> Now that we are considering making the VF visible only when the standby negotiation
> is completed, i am not sure why we need a random MAC.
> 

The claim is that some pfs update MAC RX filter immediately once vf is
created, not when its driver attaches. That will mean on hot-plug there
is downtime until device is guest visible and driver initialized.

Can you confirm that isn't the case for intel cards?


> > As said, for
> > SR-IOV live migration on iSCSI root disk there will be a lot of
> > dancing parts going along the way, reliable network connectity and
> > dedicated handshakes are critical to this kind of setup.
> > 
> > -Siwei
> > 
> > > --
> > > MST
> > > 
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > > 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

