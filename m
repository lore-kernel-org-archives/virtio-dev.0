Return-Path: virtio-dev-return-4718-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3EFBE985C63
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Jul 2018 09:14:09 +0000 (UTC)
Date: Fri, 20 Jul 2018 11:14:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180720111403.7803623e.cohuck@redhat.com>
In-Reply-To: <CADGSJ23ZWOomQ7eJ+3Uj9t1UOvDtRtM-e1ObunSjXYhwqG=xww@mail.gmail.com>
References: <1532035780-38883-1-git-send-email-sridhar.samudrala@intel.com>
	<CADGSJ23ZWOomQ7eJ+3Uj9t1UOvDtRtM-e1ObunSjXYhwqG=xww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Siwei Liu <loseweigh@gmail.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 20 Jul 2018 01:41:00 -0700
Siwei Liu <loseweigh@gmail.com> wrote:

> On Thu, Jul 19, 2018 at 2:29 PM, Sridhar Samudrala
> <sridhar.samudrala@intel.com> wrote:
> > VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
> > driver to act as a standby for another device with the same MAC address.  
> You should use another feature bit to represent the match-by-MAC
> grouping. I think VIRTIO_NET_F_STANDBY is more of a failover concept
> and shouldn't marry to any grouping mechanism. What you propose simply
> kills off the possibility of introducing other grouping mechanisms
> which don't rely on MAC address at all.

I disagree. VIRTIO_NET_F_STANDBY as used by the Linux driver today does
indicate matching by MAC, so it makes sense for the spec to define it
that way.

We should use new feature bits for any alternative matching mechanisms.
We probably can either
- introduce new features (VIRTIO_NET_F_STANDBY_UUID or so) for any
  distinct matching mechanism, or
- introduce VIRTIO_NET_F_STANDBY2 (for the concept) and different
  features for different matching mechanisms (including by MAC) which
  depend on it.

The problem is that we already have code around that relies on the
semantic of "VIRTIO_NET_F_STANDBY gets you a standby device with the
same MAC", so we can't just redefine it in the spec. An unfortunate
effect of merging something that does not have a proper spec and not
even an agreed semantic :/

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

