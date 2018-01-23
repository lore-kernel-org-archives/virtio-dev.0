Return-Path: virtio-dev-return-3022-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7BD8D58191ED
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Jan 2018 16:48:10 -0800 (PST)
Date: Tue, 23 Jan 2018 02:47:57 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180123023810-mutt-send-email-mst@kernel.org>
References: <1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
 <20180117203757-mutt-send-email-mst@kernel.org>
 <058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
 <20180117213527-mutt-send-email-mst@kernel.org>
 <CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
 <20180122231713-mutt-send-email-mst@kernel.org>
 <7edf772b-627c-6121-3332-479caed524da@intel.com>
 <20180123020332-mutt-send-email-mst@kernel.org>
 <20180122161623.22b6e151@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122161623.22b6e151@cakuba.netronome.com>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
 VIRTIO_NET_F_BACKUP feature bit
To: Jakub Kicinski <kubakici@wp.pl>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, achiad shochat <achiad.mellanox@gmail.com>, Achiad Shochat <achiad@mellanox.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 22, 2018 at 04:16:23PM -0800, Jakub Kicinski wrote:
> On Tue, 23 Jan 2018 02:05:48 +0200, Michael S. Tsirkin wrote:
> > > As we are using virtio_net to control and manage the VF data path, it is not
> > > clear to me
> > > what is the advantage of creating a new device rather than extending
> > > virtio_net to manage
> > > the VF datapath via transparent bond mechanism.
> > 
> > So that XDP redirect actions can differentiate between virtio, PT
> > device and the bond. Without it there's no way to redirect
> > to virtio specifically.
> 
> Let's make a list :P
> 
> separate netdev:
> 1. virtio device being a bond master is confusing/unexpected.
> 2. virtio device being both a master and a slave is confusing.

vlans are like this too, aren't they?

> 3. configuration of a master may have different semantics than
>    configuration of a slave.
> 4. two para-virt devices may create a loop (or rather will be bound 
>    to each other indeterministically, depending on which spawns first).

For 2 virtio devices, we can disable the bond to make it deterministic.

> 5. there is no user configuration AFAIR in existing patch, VM admin
>    won't be able to prevent the bond.  Separate netdev we can make 
>    removable even if it's spawned automatically.

That's more or less a feature. If you want configurability, just use
any of the existing generic solutions (team,bond,bridge,...).

> 6. XDP redirect use-case (or any explicit use of the virtio slave)
>    (from MST)
> 
> independent driver:
> 7. code reuse.

With netvsc? That precludes a separate device though because of
compatibility.

> 
> separate device:

I'm not sure I understand how "separate device" is different from
"separate netdev". Do you advocate for a special device who's job is
just to tell the guest "bind these two devices together"?

Yea, sure, that works. However for sure it's more work to
implement and manage at all levels. Further

- it doesn't answer the question
- a feature bit in a virtio device is cheap enough that
  I wouldn't worry too much about this feature
  going unused later.

> 8. bond any netdev with any netdev.
> 9. reuse well-known device driver model.
> a. natural anchor for hypervisor configuration (switchdev etc.)

saparate netdev has the same property

> b. next-gen silicon may be able to disguise as virtio device, and the
>    loop check in virtio driver will prevent the legitimate bond it such
>    case.  AFAIU that's one of the goals of next-gen virtio spec as well.

In fact we have a virtio feature bit for the fallback.
So this part does not depend on how software in guest works
and does not need software solutions.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

