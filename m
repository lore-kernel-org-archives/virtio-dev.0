Return-Path: virtio-dev-return-3021-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F98C58191EC
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Jan 2018 16:05:53 -0800 (PST)
Date: Tue, 23 Jan 2018 02:05:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180123020332-mutt-send-email-mst@kernel.org>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
 <20180117203757-mutt-send-email-mst@kernel.org>
 <058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
 <20180117213527-mutt-send-email-mst@kernel.org>
 <CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
 <20180122231713-mutt-send-email-mst@kernel.org>
 <7edf772b-627c-6121-3332-479caed524da@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7edf772b-627c-6121-3332-479caed524da@intel.com>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
 VIRTIO_NET_F_BACKUP feature bit
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, achiad shochat <achiad.mellanox@gmail.com>, Achiad Shochat <achiad@mellanox.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 22, 2018 at 03:27:40PM -0800, Samudrala, Sridhar wrote:
> > > You could probably
> > > even handle the Tx queue selection via a simple eBPF program and map
> > > since the input for whatever is used to select Tx should be pretty
> > > simple, destination MAC, source NUMA node, etc, and the data-set
> > > shouldn't be too large.
> > That sounds interesting. A separate device might make this kind of setup
> > a bit easier.  Sridhar, did you look into creating a separate device for
> > the virtual bond device at all?  It does not have to be in a separate
> > module, that kind of refactoring can come later, but once we commit to
> > using the same single device as virtio, we can't change that.
> 
> No. I haven't looked into creating a separate device. If we are going to
> create a new
> device, i guess it has to be of a new device type with its own driver.

Well not necessarily - just a separate netdev ops.
Kind of like e.g. vlans share a driver with the main driver.

> As we are using virtio_net to control and manage the VF data path, it is not
> clear to me
> what is the advantage of creating a new device rather than extending
> virtio_net to manage
> the VF datapath via transparent bond mechanism.
> 
> Thanks
> Sridhar

So that XDP redirect actions can differentiate between virtio, PT
device and the bond. Without it there's no way to redirect
to virtio specifically.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

