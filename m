Return-Path: virtio-dev-return-4724-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F0A85985C74
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Jul 2018 09:03:17 +0000 (UTC)
Date: Mon, 23 Jul 2018 11:03:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180723110311.5a36f56a.cohuck@redhat.com>
In-Reply-To: <20180722182834-mutt-send-email-mst@kernel.org>
References: <1532035780-38883-1-git-send-email-sridhar.samudrala@intel.com>
	<20180720094450.2f2978f9.cohuck@redhat.com>
	<20180722182834-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, 22 Jul 2018 18:37:42 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jul 20, 2018 at 09:44:50AM +0200, Cornelia Huck wrote:
> > On Thu, 19 Jul 2018 14:29:40 -0700
> > Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> >   
> > > VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
> > > driver to act as a standby for another device with the same MAC address.
> > > 
> > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com
> > > ---
> > >  content.tex | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)

> > > @@ -2636,6 +2639,13 @@ If the driver negotiates VIRTIO_NET_F_MTU, it MUST NOT transmit packets of
> > >  size exceeding the value of \field{mtu} (plus low level ethernet header length)
> > >  with \field{gso_type} NONE or ECN.
> > >  
> > > +A driver SHOULD negotiate VIRTIO_NET_F_STANDBY feature if the device offers it.  
> > 
> > I'm not sure that this is the right section of the spec. Maybe we need
> > a new normative driver section for "cross-device features" (better
> > names wanted :), and the same for devices?  
> 
> You mean if we ever extend this to non-network devices?
> This is a network specific feature bit so what makes
> it a cross-device feature?

No, the network device location is alright. But it is in a section that
deals with how the config space etc. is handled, and I'm not sure
whether it fits well with the other statements in there. Not a major
gripe, though.

> 
> > > +
> > > +If the driver negotiates VIRTIO_NET_F_STANDBY, it should act as a standby  
> > for  
> > > +another device with the same MAC address when available. The hypervisor can
> > > +hot-plug a primary device with same MAC address if the feature is successfully
> > > +negotiated with the driver.  
> > 
> > I don't think you should add implementation details like hotplugging
> > into the spec.
> > 
> > What about:
> > 
> > "If the driver negotiates VIRTIO_NET_F_STANDBY, the device MAY act as a
> > standby device for another device with the same MAC address, the
> > 'failover device'.  
> 
> I find the name "failover device" confusing. Linux came up with
> names primary and standby.

"...the device MAY act as a standby device for a primary device with
the same MAC address."

?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

