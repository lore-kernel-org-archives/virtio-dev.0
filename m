Return-Path: virtio-dev-return-4069-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7030F5818FBB
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 May 2018 11:09:47 -0700 (PDT)
Date: Fri, 11 May 2018 21:09:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180511210815-mutt-send-email-mst@kernel.org>
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
 <1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
 <460f3d8f-b2ec-2118-e296-03f4f9655c5a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460f3d8f-b2ec-2118-e296-03f4f9655c5a@infradead.org>
Subject: [virtio-dev] Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, May 07, 2018 at 03:39:19PM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 05/07/2018 03:10 PM, Sridhar Samudrala wrote:
> > 
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > ---
> >  MAINTAINERS                |    7 +
> >  include/linux/netdevice.h  |   16 +
> >  include/net/net_failover.h |   52 +++
> >  net/Kconfig                |   10 +
> >  net/core/Makefile          |    1 +
> >  net/core/net_failover.c    | 1044 ++++++++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 1130 insertions(+)
> >  create mode 100644 include/net/net_failover.h
> >  create mode 100644 net/core/net_failover.c
> 
> 
> > diff --git a/net/Kconfig b/net/Kconfig
> > index b62089fb1332..0540856676de 100644
> > --- a/net/Kconfig
> > +++ b/net/Kconfig
> > @@ -429,6 +429,16 @@ config MAY_USE_DEVLINK
> >  config PAGE_POOL
> >         bool
> >  
> > +config NET_FAILOVER
> > +	tristate "Failover interface"
> > +	default m
> 
> Need some justification for default m (as opposed to n).

Or one can just leave the default line out.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

