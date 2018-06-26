Return-Path: virtio-dev-return-4546-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D906E1CB807B
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Jun 2018 10:50:32 -0700 (PDT)
Date: Tue, 26 Jun 2018 20:50:20 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180626204312-mutt-send-email-mst@kernel.org>
References: <20180621165913.7e3f4faa.cohuck@redhat.com>
 <20180621211712-mutt-send-email-mst@kernel.org>
 <20180622170955.298900c1.cohuck@redhat.com>
 <20180622214259-mutt-send-email-mst@kernel.org>
 <CADGSJ22e=Sa8S-HqM4XtOa6ngBKPL73SiQRPh8PUzQgRaie5oA@mail.gmail.com>
 <20180623003022-mutt-send-email-mst@kernel.org>
 <CADGSJ22oFhP955cuTmMWeSt0UOsG5K1A--c34QUSMx5z3Up2SA@mail.gmail.com>
 <20180623012934-mutt-send-email-mst@kernel.org>
 <CADGSJ21HNd4VYNcCt4H0gJ_CCx1GUFpHrDof2N=4WqhD24Zc2A@mail.gmail.com>
 <20180626170813.4db094a1.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626170813.4db094a1.cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: Cornelia Huck <cohuck@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jun 26, 2018 at 05:08:13PM +0200, Cornelia Huck wrote:
> On Fri, 22 Jun 2018 17:05:04 -0700
> Siwei Liu <loseweigh@gmail.com> wrote:
> 
> > On Fri, Jun 22, 2018 at 3:33 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > I suspect the diveregence will be lost on most users though
> > > simply because they don't even care about vfio. They just
> > > want things to go fast.  
> > 
> > Like Jason said, VF isn't faster than virtio-net in all cases. It
> > depends on the workload and performance metrics: throughput, latency,
> > or packet per second.
> 
> So, will it be guest/admin-controllable then where the traffic flows
> through? Just because we do have a vf available after negotiation of
> the feature bit, it does not necessarily mean we want to use it? Do we
> (the guest) even want to make it visible in that case?

I think these ideas belong to what Alex Duyck wanted to do:
some kind of advanced device that isn't tied to
any network interfaces and allows workload and performance
specific tuning.

Way out of scope for a simple failover, and more importantly,
no one is looking at even enumerating the problems involved,
much less solving them.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

