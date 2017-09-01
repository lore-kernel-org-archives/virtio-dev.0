Return-Path: virtio-dev-return-2507-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8FF3858190E0
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Sep 2017 08:43:13 -0700 (PDT)
Date: Fri, 1 Sep 2017 18:43:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170901183517-mutt-send-email-mst@kernel.org>
References: <1504199044.22080.11.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504199044.22080.11.camel@arista.com>
Subject: [virtio-dev] Re: virtio_net: ethtool supported link modes
To: Radu Rendec <rrendec@arista.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 31, 2017 at 06:04:04PM +0100, Radu Rendec wrote:
> Hello,
> 
> Looking at the code in virtnet_set_link_ksettings, it seems the speed
> and duplex can be set to any valid value. The driver will "remember"
> them and report them back in virtnet_get_link_ksettings.
> 
> However, the supported link modes (link_modes.supported in struct
> ethtool_link_ksettings) is always 0, indicating that no speed/duplex
> setting is supported.
> 
> Does it make more sense to set (at least a few of) the supported link
> modes, such as 10baseT_Half ... 10000baseT_Full?
> 
> I would expect to see consistency between what is reported in
> link_modes.supported and what can actually be set. Could you please
> share your opinion on this?
> 
> Thank you,
> Radu Rendec


I would like to know more about why this is desirable.

We used not to support the modes at all, but it turned out
some tools are confused by this: e.g. people would try to
bond virtio with a hardware device, tools would see
a mismatch in speed and features between bonded devices
and get confused.

See

	commit 16032be56c1f66770da15cb94f0eb366c37aff6e
	Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
	Date:   Wed Feb 3 04:04:37 2016 +0100

	    virtio_net: add ethtool support for set and get of settings


as well as the discussion around it
	https://www.spinics.net/lists/netdev/msg362111.html


If you think we need to add more hacks like this, a stronger
motivation than "to see consistency" would be needed.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

