Return-Path: virtio-dev-return-4736-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E15E2985C88
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Jul 2018 13:28:03 +0000 (UTC)
Date: Wed, 25 Jul 2018 16:27:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180725162729-mutt-send-email-mst@kernel.org>
References: <1532365355-45245-1-git-send-email-sridhar.samudrala@intel.com>
 <20180724144351.5f8dd113.cohuck@redhat.com>
 <054ef852-6131-b52d-9ce6-d3f95481ad80@intel.com>
 <20180725150231.4c8bd3ae.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725150231.4c8bd3ae.cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v2] content: Introduce
 VIRTIO_NET_F_STANDBY feature
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 25, 2018 at 03:02:31PM +0200, Cornelia Huck wrote:
> On Tue, 24 Jul 2018 11:27:33 -0700
> "Samudrala, Sridhar" <sridhar.samudrala@intel.com> wrote:
> 
> > On 7/24/2018 5:43 AM, Cornelia Huck wrote:
> > > I still think we need a more detailed description of how this is
> > > supposed to work elsewhere (i.e., outside of the normative section).
> > > But we can probably merge an updated version of this patch to get at
> > > least the feature bit reserved and documented. Thoughts?  
> > 
> > Sure. I can submit a v3 version with the minor changes you suggested.
> > The detailed description of the failover mechanism can be added once qemu
> > patch to handle the standby feature bit is submitted and reviewed.
> > I am assuming someone in RH is looking into the qemu enablement patch.
> 
> Sounds reasonable to me.
> 
> Michael, what do you think?

I'm not sure I understand what's proposed. Post v3 and we'll discuss?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

