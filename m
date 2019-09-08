Return-Path: virtio-dev-return-6076-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB3D7984076
	for <virtio-dev@lists.oasis-open.org>; Sun,  8 Sep 2019 13:42:31 +0000 (UTC)
Date: Sun, 8 Sep 2019 09:42:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190908094155-mutt-send-email-mst@kernel.org>
References: <20190611065304.16880-1-tiwei.bie@intel.com>
 <20190717100426.GC7341@stefanha-x1.localdomain>
 <20190717065901-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717065901-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH] content: fix typo in feature bit name
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 17, 2019 at 06:59:08AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 17, 2019 at 11:04:26AM +0100, Stefan Hajnoczi wrote:
> > On Tue, Jun 11, 2019 at 02:53:04PM +0800, Tiwei Bie wrote:
> > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > ---
> > >  content.tex | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/content.tex b/content.tex
> > > index 193b6e1..a143d91 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3523,7 +3523,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> > >  
> > >  \paragraph{VLAN Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering}
> > >  
> > > -If the driver negotiates the VIRTION_NET_F_CTRL_VLAN feature, it
> > > +If the driver negotiates the VIRTIO_NET_F_CTRL_VLAN feature, it
> > >  can control a VLAN filter table in the device.
> > >  
> > >  \begin{lstlisting}
> > > -- 
> > > 2.17.1
> > 
> > I have opened a GitHub Issue so this can be voted on and merged:
> > https://github.com/oasis-tcs/virtio-spec/issues/46
> 
> Thanks!

For the future the way to record this is by writing:

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/46


> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

