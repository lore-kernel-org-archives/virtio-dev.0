Return-Path: virtio-dev-return-3968-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 932431CB80F1
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Apr 2018 19:43:25 -0700 (PDT)
Date: Thu, 26 Apr 2018 05:43:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180426053209-mutt-send-email-mst@kernel.org>
References: <20180423100406.71b95f74@xeon-e3>
 <20180423202204-mutt-send-email-mst@kernel.org>
 <20180423104440.2fe6cfd2@xeon-e3>
 <20180423205019-mutt-send-email-mst@kernel.org>
 <CADGSJ20ge75T+ddxtUBT4d9m1i3=HLOAHJEoS7Cg0bqnXrutwA@mail.gmail.com>
 <20180423230037-mutt-send-email-mst@kernel.org>
 <CADGSJ22WMxXEtR9QpRa9_ZqgmTbgWHZz2j4hsUnRJrM9zTsW4w@mail.gmail.com>
 <20180426011221-mutt-send-email-mst@kernel.org>
 <CADGSJ20vck5V8JCoF0Tq9PWfBu7QYPDvg0yAZ_8Xkig7TKU7Lw@mail.gmail.com>
 <20180425171831.785f412b@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425171831.785f412b@xeon-e3>
Subject: [virtio-dev] Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event handling
 code to use the failover framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Siwei Liu <loseweigh@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Sridhar Samudrala <sridhar.samudrala@intel.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 25, 2018 at 05:18:31PM -0700, Stephen Hemminger wrote:
> On Wed, 25 Apr 2018 15:57:57 -0700
> Siwei Liu <loseweigh@gmail.com> wrote:
> 
> > >
> > > I think ideally the infrastructure should suppport flexible matching of
> > > NICs - netvsc is already reported to be moving to some kind of serial
> > > address.
> > >  
> > As Stephen said, Hyper-V supports the serial UUID thing from day-one.
> > It's just the Linux netvsc guest driver itself does not leverage that
> > ID from the very beginging.
> > 
> > Regards,
> > -Siwei
> 
> I am working on that.  The problem is that it requires some messy work
> to go from VF netdevice back to PCI device and from there to the PCI hyperv
> host infrastructure to find the serial number.
> 
> I was hoping that the serial number would also match the concept of PCI Express
> device serial number. But that is a completely different ID :-( 
> The PCI-E serial number is a hardware serial number more like MAC address.
> The Hyper-V serial number is more like PCI slot value.

Asuming you mean the Device Serial Number Capability,
I did consider this, and
we could use that, changing the UUID to one matching the
PV device, but I'm not sure no drivers will get confused
suddenly seeing the UUID of another company there.

If we are going the UUID route, a better idea might be to
specify the UUID of the PCI port into which the PT device is
being hotplugged.  This is PCI-Express specific, but presumably
legacy PCI/PCI-X devices aren't common enough to bother about
this for now.


-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

